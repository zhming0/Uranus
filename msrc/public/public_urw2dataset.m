function [dataset] = public_urw2dataset(filename)
%PUBLIC_URW2DATASET    Translate urw files into dataset.
%    Input:    A urw file.
%    Output:    Dataset.
%    Author:    Tsenmu
%    Date:    2012.01.12
%    Reference:    

    fid = fopen(filename, 'r');
    vec = fread(fid,  2, 'uint16');
    c = vec(1); r = vec(2);
    layercount = 0;
    while 1 
        flag = fread(fid, 1);
        if flag == 0
            break;
        end
        layercount = layercount + 1;
        dataset(:, :, 1, layercount) = fread(fid, [r c]);
    end
    fclose(fid);
end