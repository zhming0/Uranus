function [res, level] = centralFitting_histeq(img, level)
    if nargin == 1
        level = centralFitting_histeq_findLevel(img);
    end
    [r c] = size(img);
    mask = false(r, c);
    for i = 1 : r
        for j = 1 : c
            if img(i, j) > level;
                mask(i, j) = 1;
            end
        end
    end
    summation = 0;
    n = uint32(zeros(256));
    for i = 1 : r
        for j = 1 : c
            if mask(i, j)
                summation = summation + 1;
                n(img(i, j)+1) = n(img(i,j)+1) + 1;
            end
        end
    end
    n_res  = single(256) / single(summation) .* cumsum(single(n));
    res = uint8(zeros(r, c));
    for i = 1 : r
        for j = 1 : c
            if mask(i, j)
                res(i, j) = n_res(img(i, j));
            else 
                res(i, j) = 0;
            end
        end
    end
end