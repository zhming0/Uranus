function [ret] = lineMatching3_calcRotatedSimilarity(num_A, num_B,recordA, recordB, horizontal, elevation)
%lineMatching3_calcRotatedSimilarity : This function can find the angle
%similarity of two sets of line in which one set is rotated by a specifid
%angle.
%    Input:     angleRecord of two sets (a[181][91]), 
%               number of lines in two sets,
%               rotaion angle in 3D.
%    Output:    Value of similarity
%    Author:    mjzshd
%    Date:    2012.01.17
%    Reference:
    ret = double(1);
    for i = 0 : 179
        for j = 0 : 90
            rotated_hor = mod(i+horizontal, 180);
            rotated_ele = j+elevation;
            if rotated_ele > 90
                rotated_ele = 180 - rotated_ele;
            end
            ret = ret - abs((double(recordA(i+1, j+1))/double(num_A) - double(recordB(rotated_hor+1, rotated_ele+1))/double(num_B)));
        end
    end
end