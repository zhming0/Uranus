
inFile='C:\Users\acer\Desktop\ct_right_centre.urw';
pls=pointSceneCoherence_fetchPoints(inFile);
len=length(pls);
comb=combntns(1:len,4);
clen=length(comb);
bad=0;
for i=1:clen
    pl=pls(comb(i,:));
    v1=[pl(1).x pl(1).y pl(1).z];
    v2=[pl(2).x pl(2).y pl(2).z]-v1;
    v3=[pl(3).x pl(3).y pl(3).z]-v1;
    v4=[pl(4).x pl(4).y pl(4).z]-v1;
    am=dot(v2,cross(v3,v4));
    if(abs(am)<0.0001)
        bad=bad+1;
    end
end
sprintf('bad %d/%d',bad,clen)