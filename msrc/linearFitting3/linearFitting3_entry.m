function [ ] = linearFitting3_entry(  )
%LINEARFITTING3_ENTRY    The entry to linear fitting in 3D function.
%    Input:    
%    Output:    
%    Author:    mjzshd
%    Date:    2012.01.12
%    Reference:    


    inputFile = char(input(''));
    outputFile = char(input(''));
    fprintf(1, '1\n');
    arg = int32(input(''));
    dataset = public_urw2dataset(inputFile);
    if arg ~= public_defaultnumber()
        result = lineSelection3(dataset, arg);
    else
        result = lineSelection3(dataset, 5);
    end
    public_dataset2urw(outputFile, result);
end

