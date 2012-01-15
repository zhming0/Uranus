function [ ] = linearFitting3_entry(  )
%LINEARFITTING3_ENTRY    The entry to linear fitting in 3D function.
%    Input:    
%    Output:    
%    Author:    mjzshd
%    Date:    2012.01.12
%    Reference:    

    inputFile = char(input(''));
    outputFile = char(input(''));
    
    arg = int32(io_prompt(5,'Input an integer'));
    dataset = public_urw2dataset(inputFile);
    result = linearFitting3_lineSelection3(dataset, arg);
    public_dataset2urw(outputFile, result);
end

