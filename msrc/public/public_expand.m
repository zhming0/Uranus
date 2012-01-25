function [res] = public_expand(data_3d)
%PUBLIC_EXPAND    transform 3d data into 4d dataset
%    Input:    3D data.
%    Output:    Dataset.
%    Author:    Tsenmu
%    Date:    2012.01.25
%    Reference:    
    [r c h] = size(data_3d);
    res = uint8([r, c, 1, h]);
    for z = 1 : h
        for ri = 1 : r
            for ci = 1 : c
                res(ri, ci, 1, z) = data_3d(ri, ci, z);
            end
        end
    end
end
