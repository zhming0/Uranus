function [result] = lineMatching3(dataset1, pixeldist1, dataset2, pixeldist2, arg1, arg2)
%lineMatching3_entry : The main function of lineMatching 3D.
%    Input:     dataset1, dataset2, pixeldist1/2 -> 1*3 matrix, arg1, arg2
%    Output:    Name of a function along with some argument(S, R, T).
%    Author:    mjzshd
%    Date:    2012.01.16
%    Reference:
    line_A = lineMatching3_locateLine(dataset1, pixeldist1, arg1);
    line_B = lineMatching3_locateLine(dataset2, pixeldist2, arg2);
    anglerecord_A = zeros(181, 91);
    anglerecord_B = zeros(181, 91);
    
    [num_A, ~] = size(line_A); 
    [num_B, ~] = size(line_B); 
    lineAngle_A = zeros(num_A, 2);
    lineAngle_B = zeros(num_B, 2);
    
    %Notice the degree will be more than original by one!
    
    %Anglerecord is set for remenbering the number of lines take specific
    %angle.
    
    for i = 1:num_A
        [tmp1 tmp2] = lineMatching3_findDegree(line_A(i, 1:3), line_A(i, 4:6));
        lineAngle_A(i, :) = [tmp1-1 tmp2-1];
        anglerecord_A(tmp1, tmp2) = anglerecord_A(tmp1, tmp2)+1;
    end
    for i = 1:num_B
        [tmp1 tmp2] = lineMatching3_findDegree(line_B(i, 1:3), line_B(i, 4:6));
        lineAngle_B(i, :) = [tmp1-1 tmp2-1];
        anglerecord_B(tmp1, tmp2) = anglerecord_B(tmp1, tmp2)+1;
    end
    
    %Find rotation diff in whole pic
    tmp = -1;
    for i = 0 : 179
        for j = 0:90
            tmp_similarity = lineMatching3_calcRotatedSimilarity(num_A, num_B, anglerecord_A, anglerecord_B, i, j);
            if tmp_similarity > tmp
                tmp = tmp_similarity;
                hor_angle = i;
                ele_angle = j;
            end
        end
    end
    
    tmp = -1;
    for i = 1:180
        for j = 1:91
            if anglerecord_A(i, j) > tmp
                tmp = anglerecord_A(i, j);
                mostangle_A = [i-1 j-1];
            end
        end
    end
    
    for i = 1:num_A
        %[lineAngle_A(i, 1) lineAngle_A(i, 2) mostangle_A]
        if lineAngle_A(i, 1) == mostangle_A(:, 1) && lineAngle_A(i, 2) == mostangle_A(:, 2) 
           indexofA = i;
           break;
        end
    end
    result = 0;
    likelihood = -1;
    for i = 1:num_B
        if lineAngle_B(i, 1) == mostangle_A(1)-hor_angle && lineAngle_B(i, 2) == mostangle_A(2)-ele_angle
            %Find parameter and test likelihood!
            %Choose the parameter of biggist likelihood.
            [S R tx ty tz] = lineMatching3_findParameter(line_A(indexofA, :), line_B(i, :), hor_angle, ele_angle, mostangle_A(: ,1));
            T = [tx; ty; tz];
            tmp = lineMatching3_calcLikelihood(line_A, line_B, S, R, T);
            if tmp > likelihood
                likelihood = tmp;
                result = [R.*S , T; 0 0 0 1;];
            end
        end
    end
end