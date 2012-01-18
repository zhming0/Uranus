function [dataset_res, pixelSize_res] = centralFitting(dataset, pixelSize)
%CENTRALFITTING    CENTRALFITTING
%    Input:    Dataset and pixelSize
%    Output:    Dataset and pixelSize
%    Author:    Tsenmu
%    Date:    2012.01.12
%    Reference:    
    pixelSize_res = pixelSize;
    [r, c, ~, h] = size(dataset);
    dataset_res = uint8(zeros([r c 1 h]));
    for z = 1 : h
        dataset_res(:, :, 1, z) = centralFitting_calcCenter(dataset(:, :, 1, z));
    end
end