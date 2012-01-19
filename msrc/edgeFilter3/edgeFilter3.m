function [res, rps] = edgeFilter3(dataset, pixelSize, imcloseDiskSize)
%EDGEFILTER3    Find the edge of the dataset by layer.
%    Input:    Dataset, pixelSize, disk size used in imclose()
%    Output:    Dataset pixelSize
%    Author:    Tsenmu
%    Date:    2012.01.19
%    Reference:    
    if(nargin ~=3)
        imcloseDiskSize = 10;
    end
    rps = pixelSize;
    [r, c, ~, h] = size(dataset);
    res = uint8(zeros([r, c, 1, h]));
    prog = 0.06; io_progress(prog); inc = (0.90-0.06) / double(h);
    for i = 1: h
        im = dataset(:, :, 1, i);
        im = centralFitting3_histeq(im);
        g = im2bw(im, graythresh(im));
        g = imclose(g, strel('disk', imcloseDiskSize));
        g = imfill(g, 'holes');
        g = edge(g, 'roberts');
        g = uint8(g) * 255;
        res(:,:, 1, i) = g;
        prog = prog + inc; io_progress(prog);
    end
end