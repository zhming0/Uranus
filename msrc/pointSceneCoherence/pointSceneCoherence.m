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

while count<len1/2
    % select points

    % get a transformation function
    [a,b,c,d,e,f,g,h,i,j,k,l]=pointSceneCoherence_transfunc(pl1,pl2);

    % check if this one works
    count=0;
    list=[];
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

end
