function public_dir2urw( path, limit, filename )
%PUBLIC_DIR2URW translate a directory of dicom files into a urw file
%    Input:    Directroy name, limit of taken files number, and the name of
%              the new urw file
%    Output:
%    Author:    Davidaq
%    Date:    2012.01.16
%    Reference:  public_dataset2urw
    if(nargin == 2) 
        filename=limit;
        limit = inf;
    elseif(nargin == 1) 
        filename=strcat(path,'/../new image.urw');
        limit = inf;
    end
    d=dir(path);
    len = size(d);
    len=len(1);
    count = 0;
    first = 1;
    for i = 1 : len
        obj = d(i);
        filePath=strcat([path,'/',obj.name]);
        if ~obj.isdir
            if first>0
                iminfo=dicominfo(filePath);
                first = 0;
            end
            count = count + 1;
            dataset(:,:,1,count) = public_dicom2gray(filePath);
            if(count >= limit) 
                break;
            end
        end
        io_progress(double(i)/double(len));
    end
    
    pixelSize=cat(1,iminfo.PixelSpacing,iminfo.SliceThickness);
    public_dataset2urw(filename,dataset,pixelSize);
end

