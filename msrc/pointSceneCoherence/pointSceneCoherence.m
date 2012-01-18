function pointSceneCoherence( plist1 , plist2 )
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
    list=[];
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
                list=cat(1,list,[plist1(m),plist2(n)]);
                break;
            end
        end
    end
end

% get a better transformation function using the corresponded points
len=length(list);
if(len==0)
    io_alert('Can''t correspond feature using points scene coherence');
    return;
end



end
