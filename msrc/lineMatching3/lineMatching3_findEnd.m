function [pointpair] = lineMatching3_findEnd(start, dataset)
%lineMatching3_findEnd :  To find the end point position. according to
%start point.
%    Input:    postion of start point 1*3 matrix
%               dataset
%    Output:    position of end point 1*3 matrix
%               updated vst array!
%    Author:    mjzshd
%    Date:    2012.01.16
%    Reference:
    count = 1;
    pointpair = [0 0 0; 0 0 0];
    tail = 1;
    front = 1;
    [x,y,~,z] = size(dataset);
    vst = false(x, y, z);
    que = zeros(2 * x * y * z ,3);
    vst(start(1), start(2), start(3)) = true;
    que(tail, :) = [start(1), start(2), start(3)];
    tail = tail + 1;
    while tail > front && count < 3
        current = que(front, :);
        front = front + 1;
        for i = -1:1
            for j = -1:1
                for k = -1:1
                    flag = false;
                    tmp_x = current(1) + i;
                    tmp_y = current(2) + j;
                    tmp_z = current(3) + k;
                    if tmp_x > x || tmp_x<1 || tmp_y > y || tmp_y < 1 || tmp_z > z || tmp_z<1
                        continue
                    end
                    if dataset(tmp_x, tmp_y, 1, tmp_z) == 0 || vst(current(1)+i, current(2)+j, current(3)+k) == true
                        continue
                    end
                    flag = true;
                    vst(tmp_x, tmp_y, tmp_z) = true;
                    que(tail, :) = [tmp_x, tmp_y, tmp_z];
                    tail = tail+1;              
                end
            end
        end
        if flag == false
            pointpair(count, : ) = current;
            count = count+1;
        end
    end
    if count < 3
        pointpair(count, :) = start;
    end
end