function res = logEdge3ByLayer(dataset)
%LOGEDGE3BYLAYER    Edge detecting algorithm by layer
%    Input:    Dataset files
%    Output:    
%    Author:    Tsenmu
%    Date:    2012.01.12
%    Reference:    
%                1.www.google.com
%                2.www.wikepedia.com

    [row, col, ~, h] = size(dataset);
    res = false([row, col, 1, h]);
    for z = 1 : h
        bw = edge(dataset(:, :, 1, z), 'log', 1.2, 0.49);
        res(:, :, 1, z) = bw;
    end
    res = uint8(res) * 255;
end
