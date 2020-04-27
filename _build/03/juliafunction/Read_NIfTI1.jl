module Read_NIfTI1
 
    export load_nii_header
    export write_nii_header
    export load_nii_data
    export load_niigz_header
    export load_niigz_data
    import GZip

    # See https://nifti.nimh.nih.gov/pub/dist/src/niftilib/nifti1.h 

    function load_nii_header(filename::String)    
        headerinfo = Dict()
        fid = open(filename,"r")
        testvalue = zeros(Int32,1);
        read!(fid,testvalue);
        headerinfo["sizeof_hdr"] = testvalue
        testvalue = zeros(UInt8,10);
        read!(fid,testvalue);
        headerinfo["data_type"] = testvalue
        testvalue = zeros(Int8,18);
        read!(fid,testvalue);
        headerinfo["db_name"] = testvalue
        testvalue = zeros(Int32,1);
        read!(fid,testvalue);
        headerinfo["extents"] = testvalue
        testvalue = zeros(Int16,1);
        read!(fid,testvalue);
        headerinfo["session_error"] = testvalue
        testvalue = zeros(Int8,1);
        read!(fid,testvalue);
        headerinfo["regular"] = testvalue
        testvalue = zeros(Int8,1);
        read!(fid,testvalue);
        headerinfo["dim_info"] = testvalue
        testvalue = zeros(Int16,8);
        read!(fid,testvalue);
        headerinfo["dim"] = testvalue
        testvalue = zeros(Float32,1);
        read!(fid,testvalue);
        headerinfo["intent_p1"] = testvalue
        testvalue = zeros(Float32,1);
        read!(fid,testvalue);
        headerinfo["intent_p2"] = testvalue
        testvalue = zeros(Float32,1);
        read!(fid,testvalue);
        headerinfo["intent_p3"] = testvalue
        testvalue = zeros(Int16,1);
        read!(fid,testvalue);
        headerinfo["intent_code"] = testvalue
        testvalue = zeros(Int16,1);
        read!(fid,testvalue);
        headerinfo["datatype"] = testvalue
        testvalue = zeros(Int16,1);
        read!(fid,testvalue);
        headerinfo["bitpix"] = testvalue
        testvalue = zeros(Int16,1);
        read!(fid,testvalue);
        headerinfo["slice_start"] = testvalue
        testvalue = zeros(Float32,8);
        read!(fid,testvalue);
        headerinfo["pixdim"] = testvalue
        testvalue = zeros(Float32,1);
        read!(fid,testvalue);
        headerinfo["vox_offset"] = testvalue
        testvalue = zeros(Float32,1);
        read!(fid,testvalue);
        headerinfo["scl_slope"] = testvalue
        testvalue = zeros(Float32,1);
        read!(fid,testvalue);
        headerinfo["scl_inter"] = testvalue
        testvalue = zeros(Int16,1);
        read!(fid,testvalue);
        headerinfo["slice_end"] = testvalue
        testvalue = zeros(Int8,1);
        read!(fid,testvalue);
        headerinfo["slice_code"] = testvalue
        testvalue = zeros(Int8,1);
        read!(fid,testvalue);
        headerinfo["xyzt_units"] = testvalue
        testvalue = zeros(Float32,1);
        read!(fid,testvalue);
        headerinfo["cal_max"] = testvalue
        testvalue = zeros(Float32,1);
        read!(fid,testvalue);
        headerinfo["cal_min"] = testvalue
        testvalue = zeros(Float32,1);
        read!(fid,testvalue);
        headerinfo["slice_duration"] = testvalue
        testvalue = zeros(Float32,1);
        read!(fid,testvalue);
        headerinfo["toffset"] = testvalue
        testvalue = zeros(Int32,1);
        read!(fid,testvalue);
        headerinfo["glmax"] = testvalue
        testvalue = zeros(Int32,1);
        read!(fid,testvalue);
        headerinfo["glmin"] = testvalue
        testvalue = zeros(Int8,80);
        read!(fid,testvalue);
        headerinfo["descrip"] = testvalue
        testvalue = zeros(Int8,24);
        read!(fid,testvalue);
        headerinfo["aux_file"] = testvalue
        testvalue = zeros(Int16,1);
        read!(fid,testvalue);
        headerinfo["qform_code"] = testvalue
        testvalue = zeros(Int16,1);
        read!(fid,testvalue);
        headerinfo["sform_code"] = testvalue
        testvalue = zeros(Float32,1);
        read!(fid,testvalue);
        headerinfo["quatern_b"] = testvalue
        testvalue = zeros(Float32,1);
        read!(fid,testvalue);
        headerinfo["quatern_c"] = testvalue
        testvalue = zeros(Float32,1);
        read!(fid,testvalue);
        headerinfo["quatern_d"] = testvalue
        testvalue = zeros(Float32,1);
        read!(fid,testvalue);
        headerinfo["qoffset_x"] = testvalue
        testvalue = zeros(Float32,1);
        read!(fid,testvalue);
        headerinfo["qoffset_y"] = testvalue
        testvalue = zeros(Float32,1);
        read!(fid,testvalue);
        headerinfo["qoffset_z"] = testvalue
        testvalue = zeros(Float32,4);
        read!(fid,testvalue);
        headerinfo["srow_x"] = testvalue
        testvalue = zeros(Float32,4);
        read!(fid,testvalue);
        headerinfo["srow_y"] = testvalue
        testvalue = zeros(Float32,4);
        read!(fid,testvalue);
        headerinfo["srow_z"] = testvalue
        testvalue = zeros(Int8,16);
        read!(fid,testvalue);
        headerinfo["intent_name"] = testvalue
        testvalue = zeros(Int8,4);
        read!(fid,testvalue);
        headerinfo["magic"] = testvalue
        close(fid)
        headerinfo["qfac"] = headerinfo["pixdim"][1];
        headerinfo["filename"]= filename;
        return headerinfo;
    end

    function load_niigz_header(filename::String)    
        headerinfo = Dict()
        fid = GZip.open(filename,"r")
        testvalue = zeros(Int32,1);
        read!(fid,testvalue);
        headerinfo["sizeof_hdr"] = testvalue
        testvalue = zeros(UInt8,10);
        read!(fid,testvalue);
        headerinfo["data_type"] = testvalue
        testvalue = zeros(Int8,18);
        read!(fid,testvalue);
        headerinfo["db_name"] = testvalue
        testvalue = zeros(Int32,1);
        read!(fid,testvalue);
        headerinfo["extents"] = testvalue
        testvalue = zeros(Int16,1);
        read!(fid,testvalue);
        headerinfo["session_error"] = testvalue
        testvalue = zeros(Int8,1);
        read!(fid,testvalue);
        headerinfo["regular"] = testvalue
        testvalue = zeros(Int8,1);
        read!(fid,testvalue);
        headerinfo["dim_info"] = testvalue
        testvalue = zeros(Int16,8);
        read!(fid,testvalue);
        headerinfo["dim"] = testvalue
        testvalue = zeros(Float32,1);
        read!(fid,testvalue);
        headerinfo["intent_p1"] = testvalue
        testvalue = zeros(Float32,1);
        read!(fid,testvalue);
        headerinfo["intent_p2"] = testvalue
        testvalue = zeros(Float32,1);
        read!(fid,testvalue);
        headerinfo["intent_p3"] = testvalue
        testvalue = zeros(Int16,1);
        read!(fid,testvalue);
        headerinfo["intent_code"] = testvalue
        testvalue = zeros(Int16,1);
        read!(fid,testvalue);
        headerinfo["datatype"] = testvalue
        testvalue = zeros(Int16,1);
        read!(fid,testvalue);
        headerinfo["bitpix"] = testvalue
        testvalue = zeros(Int16,1);
        read!(fid,testvalue);
        headerinfo["slice_start"] = testvalue
        testvalue = zeros(Float32,8);
        read!(fid,testvalue);
        headerinfo["pixdim"] = testvalue
        testvalue = zeros(Float32,1);
        read!(fid,testvalue);
        headerinfo["vox_offset"] = testvalue
        testvalue = zeros(Float32,1);
        read!(fid,testvalue);
        headerinfo["scl_slope"] = testvalue
        testvalue = zeros(Float32,1);
        read!(fid,testvalue);
        headerinfo["scl_inter"] = testvalue
        testvalue = zeros(Int16,1);
        read!(fid,testvalue);
        headerinfo["slice_end"] = testvalue
        testvalue = zeros(Int8,1);
        read!(fid,testvalue);
        headerinfo["slice_code"] = testvalue
        testvalue = zeros(Int8,1);
        read!(fid,testvalue);
        headerinfo["xyzt_units"] = testvalue
        testvalue = zeros(Float32,1);
        read!(fid,testvalue);
        headerinfo["cal_max"] = testvalue
        testvalue = zeros(Float32,1);
        read!(fid,testvalue);
        headerinfo["cal_min"] = testvalue
        testvalue = zeros(Float32,1);
        read!(fid,testvalue);
        headerinfo["slice_duration"] = testvalue
        testvalue = zeros(Float32,1);
        read!(fid,testvalue);
        headerinfo["toffset"] = testvalue
        testvalue = zeros(Int32,1);
        read!(fid,testvalue);
        headerinfo["glmax"] = testvalue
        testvalue = zeros(Int32,1);
        read!(fid,testvalue);
        headerinfo["glmin"] = testvalue
        testvalue = zeros(Int8,80);
        read!(fid,testvalue);
        headerinfo["descrip"] = testvalue
        testvalue = zeros(Int8,24);
        read!(fid,testvalue);
        headerinfo["aux_file"] = testvalue
        testvalue = zeros(Int16,1);
        read!(fid,testvalue);
        headerinfo["qform_code"] = testvalue
        testvalue = zeros(Int16,1);
        read!(fid,testvalue);
        headerinfo["sform_code"] = testvalue
        testvalue = zeros(Float32,1);
        read!(fid,testvalue);
        headerinfo["quatern_b"] = testvalue
        testvalue = zeros(Float32,1);
        read!(fid,testvalue);
        headerinfo["quatern_c"] = testvalue
        testvalue = zeros(Float32,1);
        read!(fid,testvalue);
        headerinfo["quatern_d"] = testvalue
        testvalue = zeros(Float32,1);
        read!(fid,testvalue);
        headerinfo["qoffset_x"] = testvalue
        testvalue = zeros(Float32,1);
        read!(fid,testvalue);
        headerinfo["qoffset_y"] = testvalue
        testvalue = zeros(Float32,1);
        read!(fid,testvalue);
        headerinfo["qoffset_z"] = testvalue
        testvalue = zeros(Float32,4);
        read!(fid,testvalue);
        headerinfo["srow_x"] = testvalue
        testvalue = zeros(Float32,4);
        read!(fid,testvalue);
        headerinfo["srow_y"] = testvalue
        testvalue = zeros(Float32,4);
        read!(fid,testvalue);
        headerinfo["srow_z"] = testvalue
        testvalue = zeros(Int8,16);
        read!(fid,testvalue);
        headerinfo["intent_name"] = testvalue
        testvalue = zeros(Int8,4);
        read!(fid,testvalue);
        headerinfo["magic"] = testvalue
        close(fid)
        headerinfo["qfac"] = headerinfo["pixdim"][1];
        headerinfo["filename"]= filename;
        return headerinfo;
    end

    function load_nii_data(filename::String, headerinfo)
        zdim::Int = headerinfo["dim"][4];
        ydim::Int = headerinfo["dim"][3];
        xdim::Int = headerinfo["dim"][2];
        tdim::Int = headerinfo["dim"][5];
        ndim::Int = headerinfo["dim"][1];
        offset::Int = convert(Int,headerinfo["vox_offset"][1]);
        fid = open(filename,"r")
        seek(fid,offset)
        if headerinfo["datatype"][1]  == 2 
            data = zeros(UInt8,xdim*ydim*zdim*tdim)
        elseif headerinfo["datatype"][1]  == 4
            data = zeros(Int16,xdim*ydim*zdim*tdim)
        elseif headerinfo["datatype"][1]  == 8 
            data = zeros(Int32,xdim*ydim*zdim*tdim)
        elseif headerinfo["datatype"][1]  == 16 
            data = zeros(Float32,xdim*ydim*zdim*tdim)
        elseif headerinfo["datatype"][1]  == 64 
            data = zeros(Float64,xdim*ydim*zdim*tdim)
        elseif headerinfo["datatype"][1]  == 256 
            data = zeros(Int8,xdim*ydim*zdim*tdim)
        elseif headerinfo["datatype"][1]  == 512 
            data = zeros(UInt16,xdim*ydim*zdim*tdim)
        elseif headerinfo["datatype"][1]  == 768 
            data = zeros(UInt32,xdim*ydim*zdim*tdim)
        elseif headerinfo["datatype"][1]  == 1024 
            data = zeros(Int64,xdim*ydim*zdim*tdim)
        elseif headerinfo["datatype"][1]  == 1280 
            data = zeros(UInt64,xdim*ydim*zdim*tdim)
        else
            data = [];
            println("-- nii data were not loaded properly --")
        end
        read!(fid,data);
        close(fid);
        if ndim == 4
            data = reshape(data,xdim,ydim,zdim,tdim);
        elseif ndim == 3
            data = reshape(data,xdim,ydim,zdim);
        end
        return data;
    end

    function load_niigz_data(filename::String, headerinfo)
        zdim::Int = headerinfo["dim"][4];
        ydim::Int = headerinfo["dim"][3];
        xdim::Int = headerinfo["dim"][2];
        tdim::Int = headerinfo["dim"][5];
        ndim::Int = headerinfo["dim"][1];
        offset::Int = convert(Int,headerinfo["vox_offset"][1]);
        fid = GZip.open(filename,"r")
        seek(fid,offset)
        if headerinfo["datatype"][1]  == 2 
            data = zeros(UInt8,xdim*ydim*zdim*tdim)
        elseif headerinfo["datatype"][1]  == 4
            data = zeros(Int16,xdim*ydim*zdim*tdim)
        elseif headerinfo["datatype"][1]  == 8 
            data = zeros(Int32,xdim*ydim*zdim*tdim)
        elseif headerinfo["datatype"][1]  == 16 
            data = zeros(Float32,xdim*ydim*zdim*tdim)
        elseif headerinfo["datatype"][1]  == 64 
            data = zeros(Float64,xdim*ydim*zdim*tdim)
        elseif headerinfo["datatype"][1]  == 256 
            data = zeros(Int8,xdim*ydim*zdim*tdim)
        elseif headerinfo["datatype"][1]  == 512 
            data = zeros(UInt16,xdim*ydim*zdim*tdim)
        elseif headerinfo["datatype"][1]  == 768 
            data = zeros(UInt32,xdim*ydim*zdim*tdim)
        elseif headerinfo["datatype"][1]  == 1024 
            data = zeros(Int64,xdim*ydim*zdim*tdim)
        elseif headerinfo["datatype"][1]  == 1280 
            data = zeros(UInt64,xdim*ydim*zdim*tdim)
        else
            data = [];
            println("-- nii data were not loaded properly --")
        end
        read!(fid,data);
        close(fid);
        if ndim == 4
            data = reshape(data,xdim,ydim,zdim,tdim);
        elseif ndim == 3
            data = reshape(data,xdim,ydim,zdim);
        end
        return data;
    end

    function write_nii_header(filename::String, headerinfo)
        fid = open(filename,"w")
        write(fid,headerinfo["sizeof_hdr"]);
        write(fid,headerinfo["data_type"]);
        write(fid,headerinfo["db_name"]);
        write(fid,headerinfo["extents"]);
        write(fid,headerinfo["session_error"]);
        write(fid,headerinfo["regular"]);
        write(fid,headerinfo["dim_info"]);
        write(fid,headerinfo["dim"]);
        write(fid,headerinfo["intent_p1"]);
        write(fid,headerinfo["intent_p2"]);
        write(fid,headerinfo["intent_p3"]);
        write(fid,headerinfo["intent_code"]);
        write(fid,headerinfo["datatype"]);
        write(fid,headerinfo["bitpix"]);
        write(fid,headerinfo["slice_start"]);
        write(fid,headerinfo["pixdim"]);
        write(fid,headerinfo["vox_offset"]);
        write(fid,headerinfo["scl_slope"]);
        write(fid,headerinfo["scl_inter"]);
        write(fid,headerinfo["slice_end"]);
        write(fid,headerinfo["slice_code"]);
        write(fid,headerinfo["xyzt_units"]);
        write(fid,headerinfo["cal_max"]);
        write(fid,headerinfo["cal_min"]);
        write(fid,headerinfo["slice_duration"]);
        write(fid,headerinfo["toffset"]);
        write(fid,headerinfo["glmax"]);
        write(fid,headerinfo["glmin"]);
        write(fid,headerinfo["descrip"]);
        write(fid,headerinfo["aux_file"]);
        write(fid,headerinfo["qform_code"]);
        write(fid,headerinfo["sform_code"]);
        write(fid,headerinfo["quatern_b"]);
        write(fid,headerinfo["quatern_c"]);
        write(fid,headerinfo["quatern_d"]);
        write(fid,headerinfo["qoffset_x"]);
        write(fid,headerinfo["qoffset_y"]);
        write(fid,headerinfo["qoffset_z"]);
        write(fid,headerinfo["srow_x"]);
        write(fid,headerinfo["srow_y"]);
        write(fid,headerinfo["srow_z"]);
        write(fid,headerinfo["intent_name"]);
        write(fid,headerinfo["magic"]);
        write(fid,Int32(0));
        close(fid)
    end

    # datatype:
    #define NIFTI_TYPE_UINT8           2 /! unsigned char. /
    #define NIFTI_TYPE_INT16           4 /! signed short. /
    #define NIFTI_TYPE_INT32           8 /! signed int. /
    #define NIFTI_TYPE_FLOAT32        16 /! 32 bit float. /
    #define NIFTI_TYPE_COMPLEX64      32 /! 64 bit complex = 2 32 bit floats. /
    #define NIFTI_TYPE_FLOAT64        64 /! 64 bit float = double. /
    #define NIFTI_TYPE_RGB24         128 /! 3 8 bit bytes. /
    #define NIFTI_TYPE_INT8          256 /! signed char. /
    #define NIFTI_TYPE_UINT16        512 /! unsigned short. /
    #define NIFTI_TYPE_UINT32        768 /! unsigned int. /
    #define NIFTI_TYPE_INT64        1024 /! signed long long. /
    #define NIFTI_TYPE_UINT64       1280 /! unsigned long long. /
    #define NIFTI_TYPE_FLOAT128     1536 /! 128 bit float = long double. /
    #define NIFTI_TYPE_COMPLEX128   1792 /! 128 bit complex = 2 64 bit floats. /
    #define NIFTI_TYPE_COMPLEX256   2048 /! 256 bit complex = 2 128 bit floats /


end




