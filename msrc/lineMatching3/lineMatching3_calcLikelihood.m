function [result] = lineMatching3_calcLikelihood(linesetA, linesetB, S, R, T)
%lineMatching3_calcLikelihood : To find the likelihood of parameter.
%    Input:     lineSet1, lineSet2, Scaling diff, 
%               Rotation diff, Translate diff.
%    Output:    Name of a function along with some argument.
%    Author:    mjzshd
%    Date:    2012.01.17
%    Reference:
    [num_A tmp] = size(line_A);
    [num_B tmp] = size(line_B);
    midB = zeros(num_B, 3);
    for i = 1:num_B
        tmpA = linesetB(i, 1:3);
        tmpB = linesetB(i, 4:6);
        midB(i) = (tmpA + tmpB)./2;
    end
    num_ok = 0;
    for i = 1:num_B
        midB(i) = (S*R*(midB(i)'))' + T;
        mid = midB(i)';
        for j = 1:num_A
            tmpA = linesetA(i, 1:3)';
            tmpB = linesetB(i, 4:6)';
            a = cross(mid - tmpA, mid - tmpB);
            len_a = sqrt(sum(a.^2));
            b = tmpB-tmpA;
            len_b = sqrt(sum(b.^2));
            dist = len_a/len_b;
            if dist < 2
                num_ok = num_ok+1;
                break
            end
        end
    end
    result = num_ok / num_A;
end