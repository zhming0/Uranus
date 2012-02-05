function [ret] = shapeMatricesMatching_calcSimilarity(mat1, mat2)
    [x, y] = size(mat1);
    ret = 0;
    for i=1 : x
        for j=1:y
            if mat1(i,j)==mat2(i,j)
                ret = ret + double(ret)/double(x*y);
            end
        end
    end
end