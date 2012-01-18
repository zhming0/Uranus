function func = pointSceneCoherence( plist1 , plist2 )
%POINTSCENECOHERENCE main function of point correspondece using scene coherence
%    Input:    2 list of points
%    Output:    
%    Author:    Davidaq
%    Date:    2012.01.17
%    Reference:       
tol=io_prompt(2,'Tolerance exmamining points');

len1=length(plist1);
len2=length(plist2);
count=0;

% brutal force point selection
comb1=combntns(plist1,3);
comb2=combntns(plist2,3);
sel1=1;
sel2=1;

while count<len1/2
    % select points
    pl1=comb1(sel1);
    pl2=comb2(sel2);
    sel1=sel1+1;
    list.a=[];
    list.b=[];
    count=0;
    if(sel1>len1)
        sel1=1;
        sel2=sel2+1;
        if(sel2>len2)
            break;
        end
    end
    % get a transformation function
    [a,b,c,d,e,f,g,h,i,j,k,l]=pointSceneCoherence_transfunc(pl1,pl2);

    % check if this one works
    for m=1:len1
        X=a*plist1(m).x+b*plist1(m).y+c*plist1(m).z+d;
        Y=e*plist1(m).x+f*plist1(m).y+g*plist1(m).z+h;
        Z=i*plist1(m).x+j*plist1(m).y+k*plist1(m).z+l;
        for n=1:len2
            dist=((X-plist2(n).x)^2+(Y-plist2(n).y)^2+(Z-plist2(n).z)^2)^0.5;
            if dist<tol
                count=count+1;
                list.a(count)=plist1(m);
                list.b(count)=plist2(n);
                break;
            end
        end
    end
end

% get a better transformation function using the corresponded points

if(count==0)
    io_alert('Faild to correspond features');
    return;
end
comb=combntns(1:count,3);
len=length(comb);
a=0;b=0;c=0;d=0;e=0;f=0;g=0;h=0;i=0;j=0;k=0;l=0;
for m=1:len
    [a2,b2,c2,d2,e2,f2,g2,h2,i2,j2,k2,l2]=pointSceneCoherence_transfunc(list.a(comb(m)),list.b(comb(m)));
    a=a+(a2-a)/m;
    b=b+(b2-b)/m;
    c=c+(c2-c)/m;
    d=d+(d2-d)/m;
    e=e+(e2-e)/m;
    f=f+(f2-f)/m;
    g=g+(g2-g)/m;
    h=h+(h2-h)/m;
    i=i+(i2-i)/m;
    j=j+(j2-j)/m;
    k=k+(k2-k)/m;
    l=l+(l2-l)/m;
end

func=sprintf('X=%f*x+%f*y+%f*z+%f;%cY=%f*x+%f*y+%f*z+%f;%cZ=%f*x+%f*y+%f*z+%f;',a,b,c,d,10,e,f,g,h,10,i,j,k,l);

end
