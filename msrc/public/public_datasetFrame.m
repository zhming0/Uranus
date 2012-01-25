function [res, ps] = public_datasetFrame(dataset, pixelSize)
%PUBLIC_DATASETFRAME    The function adds a frame to the dataset.
%    Input:    Dataset and pixel size.
%    Output:    Dataset and pixel size.
%    Author:    Tsenmu
%    Date:    2012.01.24
%    Reference:    

    ps = pixelSize;
    [r, c, ~, h] = size(dataset);
    res = dataset;
    for i = 1 : h
        res(1:3, 1:3, 1, i) = 255; 
        res(r-3:r, 1:3, 1, i) = 255;
        res(1:3, c-3:c, 1, i) = 255;
        res(r-3:r, c-3:c, 1, i) = 255;
    end
    for i = 1 : c
        res(1:3, i, 1, 1:3) = 255;
        res(r-3:r, i, 1, 1:3) = 255;
        res(1:3, i, 1, h-3:h) = 255;
        res(r-3:r, i, 1, h-3:h) = 255;
    end
    for i = 1 : r
        res(i, 1:3, 1, 1:3) = 255;
        res(i, c-3:c, 1, 1:3) = 255;
        res(i, 1:3, 1, h-3:h) = 255;
        res(i, c-3:c, 1, h-3:h) = 255;
    end
end