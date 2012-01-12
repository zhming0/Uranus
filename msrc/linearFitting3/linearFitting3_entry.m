function [ ] = linearFitting3_entry(  )
%LINEARFITTING3_ENTRY    The entry to the line correspondence function
%    Input:    
%    Output:    
%    Author:    Tsenmu
%    Date:    2012.01.12
%    Reference:    
%                1.www.google.com
%                2.www.wikepedia.com

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

