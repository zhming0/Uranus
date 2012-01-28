function [ds_double] = public_dataset2double(ds)
%PUBLIC_DATASET2DOUBLE    This function converts a uint8 dataset to double
%                         for the convenience of calculation.
%    Input:   uint8 dataset.
%    Output:    double dataset.
%    Author:    Tsenmu
%    Date:    2012.01.29
%    Reference:    
    [r, c, ~, h] = size(ds);
    ds_double = double(zeros([r, c, 1, h]));
    for z = 1 : h
        ds_double(:, :, 1, z) = im2double(ds(:, :, 1, z));
    end
end
