function res = robertsEdge3ByLayer(dataset, argv)
%ROBERTSEDGE3DBYLAYER    Edge detecting by roberts operator.
%    Input:    Dataset.
%    Output:    Dataset.
%    Author:    Tsenmu
%    Date:    2012.01.12
%    Reference:    
    [row, col, ~, h] = size(dataset);
    res = false([row, col, 1, h]);
    
    process = 0.1;
    inc = 0.8 / single(h);
    
    for z = 1 : h
        bw = edge(dataset(:, :, 1, z), 'roberts', argv);
        res(:, :, 1, z) = bw;
        process = process + inc;
        io_progress(process);
    end
    
    res = uint8(res) * 255;
end
