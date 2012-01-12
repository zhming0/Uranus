function res = centralFitting_calcCenter(bw)
%CENTRALFITTING_CALCCENTER    Calculate center to finish central fitting
%    Input:    Binary text image
%    Output:    The center of the binary text image
%    Author:    Tsenmu
%    Date:    2012.01.12
%    Reference:    
%                1.www.google.com
%                2.www.wikepedia.com

    [r c] = size(bw);
    res = false(r, c);
    [ri, ci] = find(bw ~= 0);
    r_mean = mean(ri);
    c_mean = mean(ci);
    res(uint32(r_mean), uint32(c_mean)) = 1;
    figure; imshow(bw);
    figure; imshow(res);
end