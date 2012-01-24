function [res, ps] = public_datasetFrame(dataset, pixelSize)
%PUBLIC_DATASETFRAME    The function adds a frame to the dataset.
%    Input:    Dataset and pixel size.
%    Output:    Dataset and pixel size.
%    Author:    Tsenmu
%    Date:    2012.01.24
%    Reference:    

    ps = pixelSize;
    [r, c, ~, h] = size(dataset);
    res = uint8(zeros([r c 1 h]));
    for i = 1 : h
        res(1, 1, 1, i) = 255;
        res(r, 1, 1, i) = 255;
        res(1, c, 1, i) = 255;
        res(r, c, 1, i) = 255;
    end
    for i = 1 : c
        res(1, i, 1, 1) = 255;
        res(r, i, 1, 1) = 255;
    end
    for i = 1 : r
        res(i, 1, 1, 1) = 255;
        res(i, c, 1, 1) = 255;
    end
end