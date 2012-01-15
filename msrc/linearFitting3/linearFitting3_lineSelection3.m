function  matrix  = linearFitting3_lineSelection3(dataset, divideSize )
%LINESELECTION3    Line selecting.
%    Input:    Dataset, the size used to divide lines.
%    Output:    Dataset.
%    Author:    mjzshd
%    Date:    2012.01.12
%    Reference:    


%%***********************************************************************
%
%
%%***********************************************************************
    [row col x h] = size(dataset);
    matrix = zeros(row, col ,x, h);
    for k = 1:divideSize:h-divideSize
        io_progress(double(k)/double(h));
        for i = 1:divideSize:row-divideSize
            for j = 1:divideSize:col-divideSize
                midre = squeeze(dataset(i:i+divideSize, j:j+divideSize, 1, k:k+divideSize));
                matrix(i:i+divideSize, j:j+divideSize, 1, k:k+divideSize) = linearfitting3d(midre);
            end;
        end;
    end;
    matrix = uint8(matrix);

end

