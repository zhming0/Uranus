function [horizontal elevation] = lineMatching3_findDegree(pint1, pint2)
%lineMatching3_findDegree : Calculate the degree of a line which is decided
%by two points in 3D space.
%    Input:     pint1 and pint2 = (1*3 matrix) * 2
%    Output:    horizontal degree and elevation degree.
%    Author:    mjzshd
%    Date:    2012.01.16
%    Reference:
    x1 = pint1(1);
    y1 = pint1(2);
    z1 = pint1(3);
    x2 = pint2(1);
    y2 = pint2(2);
    z2 = pint2(3);
    if x1-x2==0
        horizontal = 90;
    elseif y1-y2==0
        horizontal = 0;    
    else
        value_tan = (y1 - y2)/(x1-x2);
        horizontal = atan(value_tan);
        horizontal = horizontal*180/pi;
        if horizontal < 0
            horizontal = horizontal + 180;
        end
    end
    if z1 - z2 == 0
        elevation = 0;
    elseif x1==x2 && y1==y2
        elevation = 90;
    else
        dis = sqrt((x1-x2).^2 + (y1-y2).^2);
        value_tan = (z2 - z1)/dis;
        elevation = atan(value_tan)*180/pi;
        if elevation < 0
            elevation = elevation+90;
        end
    end
    elevation = int8(elevation+1);
    horizontal = int8(horizontal+1);
end