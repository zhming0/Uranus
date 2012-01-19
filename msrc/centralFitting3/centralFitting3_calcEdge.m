function res = centralFitting3_calcEdge(img)
%CENTRALFITTING3_CALCEDGE    Calculate edge.
%    Input:    Gray scale image.
%    Output:    The edge of the region of interest
%    Author:    Tsenmu
%    Date:    2012.01.12
%    Reference:    
    [img level] = centralFitting3_histeq(img);
    bw = im2bw(img, single(level/256));
    bw = imclose(bw, strel('disk', 10));
    res = uint8(edge(bw)) .* 255;
end