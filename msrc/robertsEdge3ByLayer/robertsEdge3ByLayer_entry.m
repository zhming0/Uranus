function [] = robertsEdge3ByLayer_entry()
%ROBERTSEDGE3DBYLAYER_ENTRY    The entry to edge detecting program by
%                              roberts operator.
%    Input:    
%    Output:    
%    Author:    Tsenmu
%    Date:    2012.01.12
%    Reference:    
    inFileName = char(input(''));
    outFileName = char(input(''));
        
    argv(1) = io_prompt(0.1,'');%input(''); 
    dataset = public_urw2dataset(inFileName);
    
    io_progress(0.1);
    
    res=robertsEdge3ByLayer(dataset, argv(1));
    
    public_dataset2urw(outFileName, res);
    
    io_progress(1);
end