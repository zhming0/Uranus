function [dataset_res, pixelSize_res] = centralFitting3(dataset, pixelSize)
%CENTRALFITTING3    CENTRALFITTING
%    Input:    Dataset and pixelSize
%    Output:    Dataset and pixelSize
%    Author:    Tsenmu
%    Date:    2012.01.12
%    Reference:    
    pixelSize_res = pixelSize;
    [r, c, ~, h] = size(dataset);
    dataset_res = uint8(zeros([r c 1 h]));
    prog = 0.06; io_progress(prog); inc = double(0.90-0.06)/double(h);
    for z = 1 : h
        im = dataset(:, :, 1, z);
        im = centralFitting3_calcEdge(im);
        dataset_res(:, :, 1, z) = centralFitting3_calcCenter(im);
        prog = prog + inc; io_progress(prog);
    end
end