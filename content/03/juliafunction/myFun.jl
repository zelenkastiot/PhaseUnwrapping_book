module myFun
    using LinearAlgebra
    export closest_point_estimation
    export twoDimIntegration
    export array_check

    function two_point_check(point1,point2,threshold)
        tmp1 = abs(point2-point1)
        threshold = abs(threshold)
        output = point2
        if tmp1>threshold
            output = point1
        end
        return output
    end

    function array_check(array1::Array{Float64,1},threshold)
        newData = copy(array1);
        len = length(array1)
        countme = 2
        while (countme <= len)
            newData[countme] = two_point_check(newData[countme-1],newData[countme],threshold)
            countme = countme + 1;
        end
        return newData
    end

    function gradient(array1)
        a = array1[:];
        array2 = vcat(diff(a)[1],(diff(a)[1:end-1] + diff(a)[2:end])/2.,diff(a)[end])
        return array2
    end

    function findn2d(array2d)
        if ndims(array2d) ==2
            v1 = findall(array2d.!=0)
            v1len = length(v1)
            if v1len >0
                vx = zeros(Int16,v1len);
                vy = zeros(Int16,v1len);
                for cnt = 1:v1len
                    vx[cnt] = v1[cnt][1];
                    vy[cnt] = v1[cnt][2];
                end
            else
                vx = []
                vy = []
            end
        else
            println("input should be 2D array")
        end
        return vx,vy
    end
            
    function closest_point_estimation(fieldmap,mask)
        sizex,sizey = size(fieldmap);
        fieldmap0 = fieldmap.*mask;
        gx = zeros(sizex,sizey);
        gy = zeros(sizex,sizey);
        for cnty = 1:sizey
        tmp = gradient(mask[:,cnty]);
        gx[:,cnty] = tmp;
        end
        for cntx = 1:sizex
        tmp = gradient(mask[cntx,:]);
        gy[cntx,:] = tmp;
        end
        gx = abs.(gx);
        gy = abs.(gy);
        gxgy = gx+ gy;
        L = findall(mask.==0);
        gxgy[L].=0;
        mask1e = ones(sizex,sizey);
        LL = findall(gxgy.==0);
        mask1e[LL].=0;
        mask1e[1,:].=0;
        mask1e[end,:].=0;
        mask1e[:,1].=0;
        mask1e[:,end].=0;
        mask1eindex_x,mask1eindex_y = findn2d(mask1e); 
        mask1eL = length(mask1eindex_x);
        fieldmap1ext = copy(fieldmap);
        for cnty = 1: sizey 
            for cntx = 1: sizex
                if (mask[cntx,cnty] == 0)
                    distance = (mask1eindex_x.-cntx).^2 + (mask1eindex_y.-cnty).^2;
                    distance_minindex = findall(distance .== minimum(distance[:]));
                    distance_minindex = distance_minindex[1];
                    targetx = mask1eindex_x[distance_minindex];
                    targety = mask1eindex_y[distance_minindex];
                    fieldmap1ext[cntx,cnty] = fieldmap0[targetx,targety];
                end
            end
        end
        return fieldmap1ext
    end

    function twoDimIntegration(mask::Array{Float64,2},boundaryConditionMap::Array{Float64,2},λmap::Array{Float64,2},Mgv::Array{Float64,2},Mgh::Array{Float64,2})
        xdim,ydim = size(mask);
        let
            Gv = Float64[]
            for cntx = 1:xdim
                for cnty = 1:ydim
                    tmp = zeros(xdim,ydim)
                    if cntx == 1
                        tmp[cntx,cnty]=-1
                        tmp[cntx+1,cnty]=1;
                    elseif cntx == xdim
                        tmp[cntx-1,cnty]=-1
                        tmp[cntx,cnty]=1;
                    else
                        tmp[cntx-1,cnty]=-0.5
                        tmp[cntx+1,cnty]=0.5
                    end
                    Gv = vcat(Gv,tmp[:]);
                end
            end
        end
        Gv = reshape(Gv,xdim*ydim,xdim*ydim);
        Gv = transpose(Gv);
        let
            Gh = Float64[]
            for cnty = 1:ydim
                for cntx = 1:xdim
                    tmp = zeros(xdim,ydim)
                    if cnty == 1
                        tmp[cntx,cnty]=-1
                        tmp[cntx,cnty+1]=1;
                    elseif cnty == ydim
                        tmp[cntx,cnty-1]=-1
                        tmp[cntx,cnty]=1;
                    else
                        tmp[cntx,cnty-1]=-0.5
                        tmp[cntx,cnty+1]=0.5;
                    end
                    Gh = vcat(Gh,tmp[:]);
                end
            end
        end
        Gh = reshape(Gh,xdim*ydim,xdim*ydim)
        Gh = transpose(Gh);
        let
            lowPassFilterv = Float64[]
            for cntx = 1:xdim
                for cnty = 1:ydim
                    tmp = zeros(xdim,ydim)
                    if (cntx>1) && (cntx<xdim) && (cnty>1) && (cnty<ydim)
                        tmp[cntx-1,cnty]= -1;
                        tmp[cntx,cnty] = 2;
                        tmp[cntx+1,cnty]= -1;
                    end
                    lowPassFilterv = vcat(lowPassFilterv,tmp[:]);
                end
            end
        end
        lowPassFilterv = reshape(lowPassFilterv,xdim*ydim,xdim*ydim);
        lowPassFilterv = transpose(lowPassFilterv);    
        let
            lowPassFilterh = Float64[]
            for cnty = 1:ydim
                for cntx = 1:xdim
                    tmp = zeros(xdim,ydim)
                    if (cntx>1) && (cntx<xdim) && (cnty>1) && (cnty<ydim)
                        tmp[cntx,cnty-1]=-1
                        tmp[cntx,cnty] = 2;
                        tmp[cntx,cnty+1]=-1;
                    end
                    lowPassFilterh = vcat(lowPassFilterh,tmp[:]);
                end
            end
        end
        lowPassFilterh = reshape(lowPassFilterh,xdim*ydim,xdim*ydim)
        lowPassFilterh = transpose(lowPassFilterh);
        B = diagm(0=>(λmap[:].*mask[:]));
        E = vcat(Gv,Gh,B,lowPassFilterh,lowPassFilterv);
        v = vcat(transpose(Mgv)[:],Mgh[:],boundaryConditionMap[:].*λmap[:].*mask[:],(Mgh[:]*0),(Mgv[:]*0));
        M_recovered = reshape(E\v,xdim,ydim);
        return M_recovered
    end

end
