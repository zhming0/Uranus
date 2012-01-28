function [dataset] = public_double2dataset(dataset_double)
%PUBLIC_DOUBLE2DATASET    This function converts double dataset back to
%                         uint8 dataset which is standard.
%    Input:   double dataset.
%    Output:    uint8 dataset.
%    Author:    Tsenmu
%    Date:    2012.01.29
%    Reference:    
    [r, c, ~, h] = size(dataset_double);
    dataset = uint8(zeros([r c 1 h]));
    for z = 1 : h 
        dataset(:, :, 1, z) = im2uint8(dataset_double(:, :, 1, z));
    end
end