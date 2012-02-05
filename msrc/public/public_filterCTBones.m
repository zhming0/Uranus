function [result] = public_filterCTBones(dataset, threshold)
%PUBLIC_FILTERCTBONES    Take out bones in CT urw for better use.
%    Input:    dataset(r*c*1*h), a threshold, 200 is recommended.
%    Output:    result(r*c*1*h)
%    Author:    Ming (mjzshd)
%    Date:    2012.02.05
%    Reference: 
    [r, c, ~, h] = size(dataset);
    squeeze(dataset);
    result = zeros(r, c, 1, h);
    for x = 1:r
        for y= 1:c
            for z = 1: h
                if dataset(x, y, z) > threshold
                    result(x, y, 1, z) = 255;
                end
            end
        end
    end
end