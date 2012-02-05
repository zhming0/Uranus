function [shapeMat] = shapeMatricesMatching_calcShapeMatrics(pointset, num_step)
%ShapeMatricsMatching_CALCSHAPEMATRICS    Figure out the shape matrix of a
%                                         shape.
%    Input:    Pointset in the form of (N * 3 matrixs); 
%    Output:    ShapaMat, should be 26*m matrix.
%    Author:    Ming (mjzshd)
%    Date:    2012.02.05
%    Reference: <2-D and 3-D Image Registration>
    [n, ~] = size(pointset);
    result = zeros(26, num_step);
    centerpoint = mean(pointset);
    maxlen = -1;
    for i = 1:n
        dist(i) = sqrt(sum((pointset(i, :) - centerpoint).^2));
        if maxlen<dist
            maxlen = dist;
            idx = i;
        end
    end
    ver_deg = -asin((pointset(idx, 3) - centerpoint(1, 3))/maxlen); 
    if pointset(idx, 1) - centerpoint(1,1) == 0
        hor_deg=90;
    else
        hor_deg = -atan((pointset(idx, 2) - centerpoint(1, 2))/(pointset(idx, 1) - centerpoint(1,1)));
    end
    R1 = [cos(hor_deg) -sin(hor_deg) 0
          sin(hor_deg)  cos(hor_deg) 0
          0             0            1];
    R2 = [cos(ver_deg)  0     sin(ver_deg)
          0             1     0
          -sin(ver_deg) 0     cos(ver_deg)];
    for i = 1:n
        pointset(i, :) = (R2*R1*(pointset(i, :)'))';
    end
    centerpoint = (R2*R1*centerpoint')';  
    step_len = maxlen/(num_step-1);
    for i = 1:num_step
        %(i-1)*step_len;
        tmp_dist = step_len*(i-1);
        result(1, i) = isThere(0, 0, tmp_dist, pointset);
        result(2, i) = isThere(0, 0, -tmp_dist, pointset);
        for j = 3:10
            hor_deg = (j-3) * 45;
            result(j, i) = isThere(tmp_dist*cos(hor_deg), tmp_dist*sin(hor_deg), 0, pointset);
        end
        for j = 11:18
            hor_deg = (j-11) * 45;
            ver_deg = 45;
            result(j, i) = isThere(tmp_dist*cos(hor_deg), tmp_dist*sin(hor_deg), tmp_dist*sin(ver_deg), pointset);
        end
        for j = 19:26
            hor_deg = (j-11) * 45;
            ver_deg = -45;
            result(j, i) = isThere(tmp_dist*cos(ver_deg)*cos(hor_deg), tmp_dist*cos(ver_deg)*sin(hor_deg), tmp_dist*sin(ver_deg), pointset);
        end
    end
end

function [ret] = isThere(x, y, z, pointset)
    [n, ~] = size(pointset);
    eps = 2;
    for i = 1:n
        if abs(x-pointset(:,1)) <= eps && abs(y-pointset(:,2)) <= eps && abs(z-pointset(:,3)) <= eps
            ret = 1;
            return;
        end
    end
    ret = 0;
end