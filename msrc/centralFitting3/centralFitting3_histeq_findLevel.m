function level = centralFitting3_histeq_findLevel (img)
    [y, x] = imhist(img);
%     figure; imhist(img);
    x_ne_0 = find(y ~= 0);
    px = x(x_ne_0(1) : 255);
    py = y(x_ne_0(1) : 255);
    p = polyfit(px, py, 30);
    x_fit = x_ne_0 : 255;
    y_fit = polyval(p, x_fit);
%     figure; plot(x_fit, y_fit);
    y_fit_diff = [0, diff(y_fit)];
    len = length(y_fit_diff);
    for i = 1 : len-1
        if  y_fit_diff(i) * y_fit_diff(i+1) < 0
            level = x_fit(i);
            break;
        end
    end
    level = level + 3;
end