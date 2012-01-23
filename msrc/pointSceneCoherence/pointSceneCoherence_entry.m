function pointSceneCoherence_entry( )
%POINTSCENECOHERENCE_ENTRY entry file of point scene coherence
%    Input:    
%    Output:   
%    Author:    Davidaq
%    Date:    2012.01.19
%    Reference:   

%inFile=char(input(''));
inFile='C:\Users\acer\Desktop\ct_left_centre.urw';
%outFile=char(input(''));
outFile='E:\ElseIf\try.urw';
%sFile=io_getfile('*.urw','Please choose the sample image');
sFile='C:\Users\acer\Desktop\mr_centre.urw';
%tol=io_prompt(2,'Tolerance exmamining points');
tol=2;
pl1=pointSceneCoherence_fetchPoints(inFile);
[pl2,dataset,ps]=pointSceneCoherence_fetchPoints(sFile);
io_progress(0.1);
func=pointSceneCoherence(pl1,pl2,tol,dataset,ps)
fp=fopen(outFile,'w');
fwrite(fp,uint8(zeros(1,5)),'uint8');
fwrite(fp,func);
fclose(fp);
io_progress(1);

end

