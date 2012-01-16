function [dataset,pixelSize] = public_urw2dataset(filename)
%PUBLIC_URW2DATASET    Translate urw files into dataset.
%    Input:    A urw file.
%    Output:    Dataset. spaces between the pixels
%    Author:    Tsenmu
%    Date:    2012.01.12
%    Reference:    

    fid = fopen(filename, 'r');
    vec = fread(fid,  2, 'uint16');
    c = vec(1); r = vec(2);
    layercount = 0;
    if r*c>0
        while 1 
            flag = fread(fid, 1);
            if flag == 0
                break;
            end
            layercount = layercount + 1;
            dataset(:, :, 1, layercount) = fread(fid, [r c]);
        end
        pixelSize=fread(fid, 3 , 'double');
    else
        dataset=[];
        pixelSize=double([0,0,0]);
    end
    fclose(fid);
end