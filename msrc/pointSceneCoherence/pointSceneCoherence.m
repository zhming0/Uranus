function func = pointSceneCoherence( plist1 , plist2 , dataset , ps )
%POINTSCENECOHERENCE main function of point correspondece using scene
%                   coherence
%    Input:    2 list of points and a point distance error tolerance
%    Output:    
%    Author:    Davidaq
%    Date:    2012.01.19
%    Reference: 

len1=length(plist1);
len2=length(plist2);
func='';

% random point selection
clen=min([len1 len2]);
max=10000;
perm1=[];
perm2=[];
perm1=randperm(clen);
perm2=randperm(clen);

if(clen>25)
    lll=25;
else
    lll=clen;
end
comb=combntns(1:lll,4);
clen=length(comb);

resCount=0;
resList1=[];
resList2=[];
    % select points
    for sel=1:clen
        io_progress(0.1+0.75*double(sel)/double(clen));
        cb=comb(sel,:);
        pl1=plist1(perm1(cb));
        pl2=plist2(perm2(cb));
        clist1=[];
        clist2=[];
        count=0;
        % get a transformation function
        [a,b,c,d,e,f,g,h,i,j,k,l,bad]=pointSceneCoherence_transfunc(pl1,pl2);
        if(bad)
            continue;
        end
        % check if this one works
        for m=1:len1
            X=a*plist1(m).x+b*plist1(m).y+c*plist1(m).z+d;
            Y=e*plist1(m).x+f*plist1(m).y+g*plist1(m).z+h;
            Z=i*plist1(m).x+j*plist1(m).y+k*plist1(m).z+l;
            X=uint32(X/ps(1)+0.5);
            Y=uint32(Y/ps(2)+0.5);
            Z=uint32(Z/ps(3)+0.5);
            try
                if dataset(X,Y,1,Z)>0
                    count=count+1;
                    clist1=cat(1,clist1,plist1(m));
                    clist2=cat(1,clist2,struct('x',double(X)*ps(1),'y',double(Y)*ps(2),'z',double(Z)*ps(3)));
                    dataset(X,Y,1,Z)=dataset(X,Y,1,Z)-150;
                else
                    br=false;
                    for x=-1:1
                        for y=-1:1
                            for z=-1:1
                                try
                                    if dataset(X+x,Y+y,1,Z+z)
                                        count=count+1;
                                        clist1=cat(1,clist1,plist1(m));
                                        clist2=cat(1,clist2,struct('x',double(X)*ps(1),'y',double(Y)*ps(2),'z',double(Z)*ps(3)));
                                        dataset(X+x,Y+y,1,Z+z)=dataset(X+x,Y+y,1,Z+z)-150;
                                        br=true;
                                    end
                                catch
                                end
                                if br
                                    break;
                                end
                            end
                            if br
                                break;
                            end
                        end
                        if br
                            break;
                        end
                    end
                end
            catch
            end
        end
        if(count>resCount)
            resList1=clist1;
            resList2=clist2;
            resCount=count;
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
if(count>20)
    len=20;
else
    len=count;
end
perm=randperm(count);
comb=nchoosek(perm(1:len),4);
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
