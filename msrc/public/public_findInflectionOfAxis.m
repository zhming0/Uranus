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
    %meanxy
    distsqrt = (xy(:,1) - meanxy(:,1)).^2 + (xy(:,2) - meanxy(:,2)).^2;
    dist = sqrt(distsqrt);
    meandist = mean(dist);
    dist = (dist-meandist).^2;
    plot(dist, 'blue'), hold on;
    dist = simple_denoise([0.0625, 0.1875, 0.5, 0.1875, 0.0625], dist);
    plot(dist, 'red'), hold off;
%     for i = 1:n
%         if dist(i) > tmp_max
%             tmp_max = dist(i);
%             index_max = i;
%         end
%     end
    tmp_max = -100000000;
    for i=2:n-1
        if dist(i-1)<dist(i)>dist(i+1) && dist(i) > tmp_max
            tmp_max = dist(i);
            index_res = i;
        end
    end
    result = pointset(index_res, :);
end

function [res] = simple_denoise(core ,list)
    %Core should must odd number. Example [0.25 0.5 0.25]
    [n,~] = size(list);
    res = double(zeros(n,1));
    [~,m] = size(core);
    m = floor(m/2)-1;
    for i = m+1:n-m
        k = 1;
        %[i-m i+m]
        for j = i-m:i+m
            res(i, :) = res(i, :) + core(:,k).*list(j,:);
            k = k+1;
        end
    end
    for i=1:m
        res(i,:) = res(m+1);
    end
    for i = n-m+1:n
        res(i,:) = res(n-m,:);
    end
end