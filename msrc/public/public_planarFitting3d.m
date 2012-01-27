function [result] = public_planarFitting3d(pointset)
%PUBLIC_PLANARFITTING    Planar Fitting of 3D Points of Form (x,y,f(x,y))
%    Input:    Point set in the form (N*3) matrix.
%    Output:    The A, B, C in form of 3*1 matrix, which represent Ax + By + C = z
%    Author:    Ming (mjzshd)
%    Date:    2012.01.27
%    Reference: Least Squares Fitting of Data
%               David Eberly
%               Geometric Tools, LLC http://www.geometrictools.com/
%               Copyright ?c 1998-2008. All Rights Reserved.
%               Created: July 15, 1999
%               Last Modified: February 9, 2008
    [n, m] = size(pointset);
    M = double(zeros(3, 3));
    P = double(zeros(3, 1));
    for i = 1:n
        M(1, 1) = M(1, 1) + pointset(i, 1).*pointset(i, 1);
        M(1, 2) = M(1, 2) + pointset(i, 1).*pointset(i, 2);
        M(1, 3) = M(1, 3) + pointset(i, 1);
        M(2, 1) = M(1, 2);
        M(2, 2) = M(2, 2) + pointset(i, 2).*pointset(i, 2);
        M(2, 3) = M(2, 3) + pointset(i, 2);
        M(3, 1) = M(1, 3);
        M(3, 2) = M(2, 3);
        
        P(1, 1) = P(1, 1) + pointset(i, 1).*pointset(i, 3);
        P(2, 1) = P(2, 1) + pointset(i, 2).*pointset(i, 3);
        P(3, 1) = P(3, 1) + pointset(i, 3);
    end
    M(3, 3) = n;
    result = (M^-1)*P;
end