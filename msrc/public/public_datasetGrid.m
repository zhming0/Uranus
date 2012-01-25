function [res, ps] = public_datasetGrid(dataset, pixelSize, increment)
%PUBLIC_DATASETFRAME    The function adds girds to the original dataset.
%    Input:    Dataset and pixel size.
%    Output:    Dataset and pixel size.
%    Author:    Tsenmu
%    Date:    2012.01.25s
%    Reference:    
    [r, c, ~, h] = size(dataset);
    [res, ps] = public_datasetFrame(dataset, pixelSize);
    for z = 1 : increment: h
        for ci = 1 : increment : c
            for i = 1 : r
                res(i, ci, 1, z) = 255;
            end
        end
        for ri = 1 : increment : r
            for i = 1 : c
                res(ri, i, 1, z) = 255;
            end
        end
        for i = 1 : r
            res(i, 1, 1, z) = 255;
            res(i, c, 1, z) = 255;
        end
        for i = 1 : c
            res(1, i, 1, z) = 255;
            res(r, i, 1, z) = 255;
        end
    end
    for z = 1 : h
        for ri = 1 : increment : r
            for ci = 1 : increment : c
                res(ri, ci, 1, z) = 255;
            end
        end
    end
end