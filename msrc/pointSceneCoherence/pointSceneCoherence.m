function func = pointSceneCoherence( plist1 , plist2 )
%POINTSCENECOHERENCE main function of point correspondece using scene coherence
%    Input:    2 list of points
%    Output:    
%    Author:    Davidaq
%    Date:    2012.01.19
%    Reference:       
tol=io_prompt(2,'Tolerance exmamining points');

len1=length(plist1);
len2=length(plist2);
count=0;

% brutal force point selection
comb1=combntns(1:len1,4);
comb2=combntns(1:len2,4);
sel1=1;
sel2=1;

while count<len1/2
    % select points
    pl1=plist1(comb1(sel1,:));
    pl2=plist2(comb2(sel2,:));
    sel1=sel1+1;
    clist1=[];
    clist2=[];
    count=0;
    if(sel1>len1)
        sel1=1;
        sel2=sel2+1;
        io_progress(0.1+0.8*double(sel2)/double(len2));
        if(sel2>len2)
            break;
        end
    end
    % get a transformation function
    [a,b,c,d,e,f,g,h,i,j,k,l,ok]=pointSceneCoherence_transfunc(pl1,pl2);
    if(~ok)
        continue;
    end
    % check if this one works
    for m=1:len1
        X=a*plist1(m).x+b*plist1(m).y+c*plist1(m).z+d;
        Y=e*plist1(m).x+f*plist1(m).y+g*plist1(m).z+h;
        Z=i*plist1(m).x+j*plist1(m).y+k*plist1(m).z+l;
        for n=1:len2
            dist=((X-plist2(n).x)^2+(Y-plist2(n).y)^2+(Z-plist2(n).z)^2)^0.5;
            if dist<tol
                count=count+1;
                clist1=cat(clist1,plist1(m));
                clist2=cat(clist2,plist2(n));
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
comb=combntns(1:count,4);
len=length(comb);
a=0;b=0;c=0;d=0;e=0;f=0;g=0;h=0;i=0;j=0;k=0;l=0;
n=0;
for m=1:len
    [a2,b2,c2,d2,e2,f2,g2,h2,i2,j2,k2,l2,ok]=pointSceneCoherence_transfunc(clist1(comb(m,:)),clist2(comb(m,:)));
    if(~ok)
        continue;
    end
    n=n+1;
    a=a+(a2-a)/n;
    b=b+(b2-b)/n;
    c=c+(c2-c)/n;
    d=d+(d2-d)/n;
    e=e+(e2-e)/n;
    f=f+(f2-f)/n;
    g=g+(g2-g)/n;
    h=h+(h2-h)/n;
    i=i+(i2-i)/n;
    j=j+(j2-j)/n;
    k=k+(k2-k)/n;
    l=l+(l2-l)/n;
    io_progress(0.9+0.1*double(m)/double(len));
end

func=sprintf('X=%f*x+%f*y+%f*z+%f;%cY=%f*x+%f*y+%f*z+%f;%cZ=%f*x+%f*y+%f*z+%f;',a,b,c,d,10,e,f,g,h,10,i,j,k,l);

end
