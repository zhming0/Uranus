function [result] = lineMatching3_locateLine(dataset, pixeldist, divideSize)
%lineMatching3_locateLine : Print lines list from dataset. 
%    Input:    dataset, distance of pixel(1*3 matrix), divideSize(the same with the fiture selected procedure)
%    Output:    A array of pairs of points to represent lines.
%    Author:    mjzshd
%    Date:    2012.01.16
%    Reference:
    [row,col,~,h] = size(dataset);
    result = [-1 -1 -1 -1 -1 -1];
    head = 1;
    
    for k = 1:divideSize:h-divideSize
        %io_progress(double(k)/double(h));
        for i = 1:divideSize:row-divideSize
            for j = 1:divideSize:col-divideSize
                midre = squeeze(dataset(i:i+divideSize, j:j+divideSize, 1, k:k+divideSize));
                [tmp_x, tmp_y, tmp_z] = size(midre);
                for ii = 1:tmp_x
                    for jj = 1:tmp_y
                        flag = false;
                        for kk = 1:tmp_z
                            if midre(ii, jj, kk)~=0
                                start = [ii, jj, kk]; 
                                tmp = lineMatching3_findEnd(start, midre);
                                if tmp(1, :) == tmp(2, :)
                                    continue
                                end
                                %tmp
                                %pixeldist
                                result(head, :) = [tmp(1, :).*pixeldist, tmp(2, :).*pixeldist];
                                head = head+1;
                                flag = true;
                            end
                        end
                        if flag == true
                            break;
                        end
                    end
                    if flag == true
                        break;
                    end
                end
            end;
        end;
    end;
    
end