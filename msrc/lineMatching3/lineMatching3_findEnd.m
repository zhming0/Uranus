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
    que = zeros(x * y * z ,3);
    vst(start(1), start(2), start(3)) = true;
    que(tail, :) = [start(1), start(2), start(3)];
    tail = tail + 1;
    while tail > front
        front = front + 1;
        current = que(front, :);
        for i = -1:1
            for j = -1:1
                for k = -1:1
                    flag = false;
                    if dataset(current(1)+i, current(2)+j, 1, current(3)+k) == 0 || vst(current(1)+i, current(2)+j, current(3)+k) == true
                        continue
                    end
                    flag = true;
                    vst(current(1)+i, current(2)+j, current(3)+k) = true;
                    que(tail, :) = [current(1)+i, current(2)+j, current(3)+k];
                    tail = tail+1;              
                end
            end
        end
        if flag == false
            pointpair(count+1, : ) = current;
        end
    end
    
end