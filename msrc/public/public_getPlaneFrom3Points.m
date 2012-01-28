function planeParams = public_getPlaneFrom3Points( points )
%PUBLIC_GETPLANEFROM3POINTS Get the plane identified using 3 points
%    Input:    a 3x3 matrix representing 3 points in 3D world
%    Output:    the four paramaters of a standard plane function
%    Author:    Davidaq
%    Date:    2012.01.28
%    Reference:    
	sz=size(points);
    if(sz(1)~=3||sz(2)~=3)
        fprintf('Bad function input, requires 3 points\n');
        planeParams=[];
        return;
    end
    v1=points(2,:)-points(1,:);
    v2=points(3,:)-points(1,:);
    norm=cross(v1,v2);
    planeParams=[norm,-dot(norm,points(1,:))];
end

