function planeParams = public_getPlaneFrom2Points( points )
%PUBLIC_GETPLANEFROM3POINTS Get the plane identified using 2 points
%    Input:    a 2x3 matrix representing 2 points in 3D world
%    Output:    the four paramaters of a standard plane function
%    Author:    Davidaq
%    Date:    2012.01.28
%    Reference:    
	sz=size(points);
    if(sz(1)~=2||sz(2)~=3)
        fprintf('Bad function input, requires 2 points\n');
        planeParams=[];
        return;
    end
    norm=points(2,:);
    planeParams=[norm,-dot(norm,points(1,:))];
end

