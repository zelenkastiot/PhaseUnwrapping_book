function M_recovered=twoDimIntegration(mask,boundaryConditionMap,Lmap,Mgv,Mgh)
    [xdim,ydim] = size(mask);
    Gv = [];
    for cntx = 1:xdim
        for cnty = 1:ydim
            tmp = zeros(xdim,ydim);
            if cntx == 1
                tmp(cntx,cnty)=-1;
                tmp(cntx+1,cnty)=1;
            elseif cntx == xdim
                tmp(cntx-1,cnty)=-1;
                tmp(cntx,cnty)=1;
            else
                tmp(cntx-1,cnty)=-0.5;
                tmp(cntx+1,cnty)=0.5;
            end
            Gv = cat(1,Gv,tmp(:));
        end
    end
    Gv = reshape(Gv,xdim*ydim,xdim*ydim);
    Gv = transpose(Gv);
    Gh = [];
    for cnty = 1:ydim
        for cntx = 1:xdim
            tmp = zeros(xdim,ydim);
            if cnty == 1
                tmp(cntx,cnty)=-1;
                tmp(cntx,cnty+1)=1;
            elseif cnty == ydim
                tmp(cntx,cnty-1)=-1;
                tmp(cntx,cnty)=1;
            else
                tmp(cntx,cnty-1)=-0.5;
                tmp(cntx,cnty+1)=0.5;
            end
            Gh = cat(1,Gh,tmp(:));
        end
    end
    Gh = reshape(Gh,xdim*ydim,xdim*ydim);
    Gh = transpose(Gh);

    lowPassFilterv = [];
    for cntx = 1:xdim
        for cnty = 1:ydim
            tmp = zeros(xdim,ydim);
            if (cntx>1) && (cntx<xdim) && (cnty>1) && (cnty<ydim)
                tmp(cntx-1,cnty)=-1;
                tmp(cntx,cnty)=2;
                tmp(cntx+1,cnty)=-1;
            end
            lowPassFilterv = cat(1,lowPassFilterv,tmp(:));
        end
    end
    lowPassFilterv = reshape(lowPassFilterv,xdim*ydim,xdim*ydim);
    lowPassFilterv = transpose(lowPassFilterv);
    lowPassFilterh = [];
    for cnty = 1:ydim
        for cntx = 1:xdim
            tmp = zeros(xdim,ydim);
            if (cntx>1) && (cntx<xdim) && (cnty>1) && (cnty<ydim)
                tmp(cntx,cnty-1)=-1;
                tmp(cntx,cnty)=2;
                tmp(cntx,cnty+1)=-1;
            end
            lowPassFilterh = cat(1,lowPassFilterh,tmp(:));
        end
    end
    lowPassFilterh = reshape(lowPassFilterh,xdim*ydim,xdim*ydim);
    lowPassFilterh = transpose(lowPassFilterh);

    B = diag(Lmap(:).*mask(:));
    E = cat(1,Gv,Gh,B,lowPassFilterh,lowPassFilterv);
    MgvT = transpose(Mgv);
    v = cat(1,MgvT(:),Mgh(:),boundaryConditionMap(:).*Lmap(:).*mask(:),MgvT(:)*0,Mgh(:)*0);
    M_recovered = reshape(E\v,xdim,ydim);
return
