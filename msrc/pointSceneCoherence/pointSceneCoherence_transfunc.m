function [ a,b,c,d,e,f,g,h,i,j,k,l,bad ] = pointSceneCoherence_transfunc( pointList1 , pointList2 )
%POINTSCENECOHERENCE_TRANSFUNC get the paramaters of a function using 4
%       pairs of points
%    Input:    2 point lists
%    Output:    a transformation function maping from list1 to list2
%    Author:    Davidaq
%    Date:    2012.01.19
%    Reference:   
%    X=ax+by+cz+d
%    Y=ex+fy+gz+h
%    Z=ix+jy+kz+l
a=0;b=0;c=0;d=0;e=0;f=0;g=0;h=0;i=0;j=0;k=0;l=0;
bad=0;

v1=[pointList1(1).x pointList1(1).y pointList1(1).z];
v2=[pointList1(2).x pointList1(2).y pointList1(2).z]-v1;
v3=[pointList1(3).x pointList1(3).y pointList1(3).z]-v1;
v4=[pointList1(4).x pointList1(4).y pointList1(4).z]-v1;
am=dot(v2,cross(v3,v4));
if(abs(am)<0.0001)
    bad=1;
end
v1=[pointList2(1).x pointList2(1).y pointList2(1).z];
v2=[pointList2(2).x pointList2(2).y pointList2(2).z]-v1;
v3=[pointList2(3).x pointList2(3).y pointList2(3).z]-v1;
v4=[pointList2(4).x pointList2(4).y pointList2(4).z]-v1;
am=dot(v2,cross(v3,v4));
if(abs(am)<0.0001)
    bad=bad+2;
end
if(bad>0)
    return;
end

lt=[pointList1(1).x,pointList1(1).y,pointList1(1).z,1;
    pointList1(2).x,pointList1(2).y,pointList1(2).z,1;
    pointList1(3).x,pointList1(3).y,pointList1(3).z,1;
    pointList1(4).x,pointList1(4).y,pointList1(4).z,1;
    ];

rt=[pointList2(1).x;pointList2(2).x;pointList2(3).x;pointList2(4).x];
res=lt\rt;
a=res(1);
b=res(2);
c=res(3);
d=res(4);
rt=[pointList2(1).y;pointList2(2).y;pointList2(3).y;pointList2(4).y];
res=lt\rt;
e=res(1);
f=res(2);
g=res(3);
h=res(4);
rt=[pointList2(1).z;pointList2(2).z;pointList2(3).z;pointList2(4).z];
res=lt\rt;
i=res(1);
j=res(2);
k=res(3);
l=res(4);
end
