function func = pointSceneCoherence( plist1 , plist2 , tol )
%POINTSCENECOHERENCE main function of point correspondece using scene
%                   coherence
%    Input:    2 list of points and a point distance error tolerance
%    Output:    
%    Author:    Davidaq
%    Date:    2012.01.19
%    Reference:       
tol=tol*tol;

len1=length(plist1);
len2=length(plist2);
func='';

% brutal force point selection
comb1=combntns(1:len1,4);
comb2=combntns(1:len2,4);
clen1=length(comb1);
clen2=length(comb2);

minLen=min([len1 len2]);
maxLen=max([len1 len2]);
leastCount=3*minLen-2*maxLen;
resCount=0;
resList1=[];
resList2=[];
    % select points
    for sel1=1:clen1
        pl1=plist1(comb1(sel1,:));
        for sel2=1:clen2
            pl2=plist2(comb2(sel2,:));
            clist1=[];
            clist2=[];
            count=0;
            % get a transformation function
            [a,b,c,d,e,f,g,h,i,j,k,l,bad]=pointSceneCoherence_transfunc(pl1,pl2);
            if(err>0)
                if(bitand(bad,1))
                    break;
                end
                if(bitand(bad,2))
                    continue;
                end
            end
            % check if this one works
            for m=1:len1
                X=a*plist1(m).x+b*plist1(m).y+c*plist1(m).z+d;
                Y=e*plist1(m).x+f*plist1(m).y+g*plist1(m).z+h;
                Z=i*plist1(m).x+j*plist1(m).y+k*plist1(m).z+l;
                for n=1:len2
                    dist=(X-plist2(n).x)^2+(Y-plist2(n).y)^2+(Z-plist2(n).z)^2;
                    if dist<tol
                        count=count+1;
                        clist1=cat(1,clist1,plist1(m));
                        clist2=cat(1,clist2,plist2(n));
                        break;
                    end
                end
            end
            if(count>resCount)
                resList1=clist1;
                resList2=clist2;
                resCount=count;
            end
            if(count>leastCount)
                break;
            end
        end
    end
% get a better transformation function using the corresponded points
count=resCount;
sprintf('good %d/%d',count,len1)
clist1=resList1;
clist2=resList2;
if(count==0)
    io_alert('Faild to correspond features');
    return;
end
comb=combntns(1:count,4);
len=length(comb);
a=0;b=0;c=0;d=0;e=0;f=0;g=0;h=0;i=0;j=0;k=0;l=0;
n=0;
io_progress(0.9);
for m=1:len
    [a2,b2,c2,d2,e2,f2,g2,h2,i2,j2,k2,l2,bad]=pointSceneCoherence_transfunc(clist1(comb(m,:)),clist2(comb(m,:)));
    if(bad)
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
end

func=sprintf('X=%f*x+%f*y+%f*z+%f;%cY=%f*x+%f*y+%f*z+%f;%cZ=%f*x+%f*y+%f*z+%f;',a,b,c,d,10,e,f,g,h,10,i,j,k,l);

end
