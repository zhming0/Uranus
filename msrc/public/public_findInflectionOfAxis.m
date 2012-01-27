function [result] = public_findInflectionOfAxis(pointset)
%PUBLIC_PLANARFITTING    Planar Fitting of 3D Points of Form (x,y,f(x,y))
%    Input:    Point set in the form (N*3) matrix.
%    Output:    The x, y, z in form of inflection.
%    Author:    Ming (mjzshd)
%    Date:    2012.01.27
%    Reference: Tsenmu's temporary code.
    [n, ~] = size(pointset);
    xy = pointset(:, 1:2);
    meanxy = mean(xy);
    distsqrt = (xy(:,1) - meanxy(:,1)).^2 + (xy(:,2) - meanxy(:,2)).^2;
    dist = sqrt(distsqrt);
    %meandist = mean(meandist);
    tmp_max = -100000000;
    for i = 1:n
        if dist(i) > tmp_max
            tmp_max = dist(i);
            index_max = i;
        end
    end
    result = pointset(i, :);
end