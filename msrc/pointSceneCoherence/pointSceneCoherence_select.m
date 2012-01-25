function pairs = pointSceneCoherence_select( listN1 , listN2 , len )
%POINTSCENECOHERENCE_SELECT Summary of this function goes here
%   Detailed explanation goes here

%%random selection
c=0;
ll=min(listN1,listN2);
list1=[];
list2=[];
while c<len
    lst=randperm(listN1);
    list1=[list1,lst(1:ll)];
    lst=randperm(listN2);
    list2=[list2,lst(1:ll)];
    c=c+ll;
end
pairs=[];
while c>3
    pairs=[pairs;list1(c-3:c),list2(c-3:c)];
    c=c-4;
end

end

