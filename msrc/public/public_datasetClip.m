function [dataset_res, pixelSize_res] = public_datasetClip(dataset, pixelSize, x, y, z)
%PUBLIC_DATASETCLIP    cliping a dataset.
%    Input:    Directroy name, limit of taken files number, and the name of
%              the new urw file
%    Output:
%    Author:    Tsenmu
%    Date:    2012.01.17
%    Reference:  
%    Example:    
%                CT right  [d1, ps1] = public_datasetClip(d, ps,  [50, 250],[150, 410], []);
    pixelSize_res = pixelSize;
    [r, c, ~, h] = size(dataset);
    if isempty(x)
        x = [1 c];
    end
    if isempty(y)
        y = [1 r];
    end
    if isempty(z)
        z = [1 h];
    end
    if length(x) ~= 2 || length(y) ~= 2 || length(z) ~= 2
        fprintf('Error in size.\n');
        return;
    end
    x1 = x(1); x2 = x(2); y1 = y(1); y2 = y(2); z1 = z(1); z2 = z(2);

    if(x1 > x2 || y1>y2 || z1>z2 || x2 > c || x1 < 1 || y2 > r || y1 < 1 || ...
        z2 > h || z2 < 1)
        fprintf('Error in size.\n');
        return;
    end
    dataset_res = dataset(y1:y2, x1:x2, 1, z1:z2);
end