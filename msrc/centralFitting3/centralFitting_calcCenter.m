function res = centralFitting_calcCenter(bw)
%CENTRALFITTING_CALCCENTER    Calculate central.
%    Input:    Black white image.
%    Output:    The center of the black white image.
%    Author:    Tsenmu
%    Date:    2012.01.12
%    Reference:    
    [r c] = size(bw);
    res = false(r, c);
    [ri, ci] = find(bw ~= 0);
    r_mean = mean(ri);
    c_mean = mean(ci);
    res(uint32(r_mean), uint32(c_mean)) = 1;
    figure; imshow(bw);
    figure; imshow(res);
end