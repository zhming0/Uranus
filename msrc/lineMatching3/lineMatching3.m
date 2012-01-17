function [result] = lineMatching3(dataset1, pixeldist1, dataset2, pixeldist2, arg1, arg2)
%lineMatching3_entry : The main function of lineMatching 3D.
%    Input:     dataset1, dataset2, pixeldist1/2 -> 1*3 matrix, arg1, arg2
%    Output:    Name of a function along with some argument.
%    Author:    mjzshd
%    Date:    2012.01.16
%    Reference:
    line_A = lineMatching3_locateLine(dataset1, pixeldist1, arg1);
    line_B = lineMatching3_locateLine(dataset2, pixeldist2, arg2);
    anglerecord_A = zeros(181, 91);
    anglerecord_B = zeros(181, 91);
    
    [num_A tmp] = size(line_A); 
    [num_B tmp] = size(line_B); 
    
    for i = 1:num_A
        tmp = lineMatching3_findDegree(line_A(i, 1:3), line_A(i, 4:6));
        anglerecord_A(tmp(1), tmp(2)) = degrecord_A(tmp(1), tmp(2))+1;
    end
    for i = 1:num_B
        tmp = lineMatching3_findDegree(line_B(i, 1:3), line_B(i, 4:6));
        anglerecord_B(tmp(1), tmp(2)) = degrecord_B(tmp(1), tmp(2))+1;
    end
    
    for i = 0 : 179
        for j = 0:90
            
        end
    end
    
end