function [res, rps] = edgeFilter3(dataset, pixelSize, imcloseDiskSize, thresh, type)
%EDGEFILTER3    Find the edge of the dataset by layer.
%    Input:    Dataset, pixelSize, disk size used in imclose()
%    Output:    Dataset pixelSize
%    Author:    Tsenmu
%    Date:    2012.01.19
%    Reference:    

    rps = pixelSize;
    [r, c, ~, h] = size(dataset);
    res = uint8(zeros([r, c, 1, h]));
    prog = 0.06; io_progress(prog); inc = (0.90-0.06) / double(h);
    switch lower(type)
        case 'mr'
            for i = 1: h
                im = dataset(:, :, 1, i);
                im = edgeFilter3_histeq(im);
                g = im2bw(im, thresh);
                g = imclose(g, strel('disk', imcloseDiskSize));
                g = imfill(g, 'holes');
                g = edge(g, 'roberts');
                g = uint8(g) * 255;
                res(:,:, 1, i) = g;
                prog = prog + inc; io_progress(prog);
            end
        case 'ct'
            for i = 1 : h
                im = dataset(:, :, 1, i);
%                  im = histeq(im);
                  im = imadjust(im);
                  im  =im2bw (im, thresh);
                 im  =imfill(im, 'holes'); 
                 im = bwareaopen(im, 50);
                 im = edge(im, 'roberts');
                 im = uint8(im) * 255;
                res(:, :, 1, i) = im;
                prog = prog + inc; io_progress(prog);
            end
    end
end