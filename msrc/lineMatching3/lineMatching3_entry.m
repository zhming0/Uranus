function [ ] = lineMatching3_entry( )
%lineMatching3_entry : The entry to linear matching function in 3D.
%    Input:    
%    Output:    
%    Author:    mjzshd
%    Date:    2012.01.16
%    Reference:
    inputFile1 = char(input(''));
    outFile = char(input(''));
    
    inputFile2 = io_getfile('*.urw', 'Please choose one more processed urw file');
    
    dataset1 = public_urw2dataset(inputFile1);
    dataset2 = public_urw2dataset(inputFile2);
    
    pixeldist1 = [1 1 1];
    pixeldist2 = [1 1 1];
    
    arg1 = io_prompt(5, 'Set argument. Better to be the same with last procedure');
    arg2 = io_prompt(5, 'Set argument. Better to be the same with last procedure');
    
    result = lineMatching3(dataset1, pixeldist1, dataset2, pixeldist2, arg1, arg2);
    
    %public_dataset2urw(outFile, result);
    %waiting to be modified!
end