function pointList = pointSceneCoherence_fetchPoints( inFile )
%POINTSCENECOHERENCE_FETCHPOINTS get the list of points in a urw file
%    Input:    the input file inFile
%    Output:    a list of points
%    Author:    Davidaq
%    Date:    2012.01.19
%    Reference:   

[dataset,ps]=public_urw2dataset(inFile);
[c,r,t,h]=size(dataset);
pointList=[];
for z=1:h
    for x=1:c
        for y=1:r
            if dataset(x,y,1,z)>100
                pointList=cat(pointList,struct('x',x,'y',y,'z',z));
            end
        end
    end
end

