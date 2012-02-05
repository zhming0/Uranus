function [] = shapeMatricesMatching_entry()
%ShapeMatricsMatching_ENTRY    Entry for shape matrices matching of region
%                              matching
%    Input:    
%    Output:    
%    Author:    Ming (mjzshd)
%    Date:    2012.02.05
%    Reference: <2-D and 3-D Image Registration>
    inputFile1 = char(input(''));
    outFile = char(input(''));
    
    inputFile2 = io_getfile('*.urw', 'Please choose one more processed urw file');
    
    [dataset1 pixeldist1]= public_urw2dataset(inputFile1);
    [dataset2 pixeldist2]= public_urw2dataset(inputFile2);
    
    %pixeldist1 = [1; 1; 1;];
    %pixeldist2 = [1; 1; 1;];
    
    arg1 = io_prompt(20, 'Set the number of step.');
end