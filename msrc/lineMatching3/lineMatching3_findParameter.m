function [S, tx, ty, tz] = lineMatching3_findParameter(lineA, lineB, horizontal, elevation, hor_degA)
%lineMatching3_findParameter : find the tranform parameter in terms of two
%lines.
%    Input:     Two lines = 4 points.
%    Output:    S, tx, ty, tz
%    Author:    mjzshd
%    Date:    2012.01.17
%    Reference:
    zdir = [0 0 1];
    xdir = [1 0 0];
    p1 = lineA(1:3);
    p2 = lineA(4:6);
    mid1 = (p1 + p2)./2;
    p3 = lineB(1:3);
    p4 = lineB(4:6);
    mid2 = (p3 + p4)./2;
    lengthA = sqrt(sum((p1 - p2).^2));
    lengthB = sqrt(sum((p3 - p4).^2));
    %S is for rescale difference.
    S = lengthA/lengthB;
    %R1, R2, R3 is used to rotate about z axis
    R1 = [cos(horizontal) -sin(horizontal) 0
          sin(horizontal)  cos(horizontal) 0
          0                 0              1];
    R2 = [cos(-hor_degA) -sin(-hor_degA) 0
          sin(-hor_degA)  cos(-hor_degA) 0
          0                 0            1];
    R3 = [cos(hor_degA) -sin(hor_degA) 0
          sin(hor_degA)  cos(hor_degA) 0
          0                 0          1];
    %R4 is to rotate about x axis.
    R4 = [1         0              0
          0 cos(elevation) -sin(elevation)
          0 sin(elevation)  cos(elevation)];
    %R is the true rotation matrix
    R = R4*R3*R2*R1;
    newmid2 = S* (R*mid2');
    tx = newmid2(1) - mid2(1);
    ty = newmid2(2) - mid2(2);
    tz = newmid2(3) - mid2(3);
end