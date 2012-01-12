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
    
    argc = 1; fprintf('%d\n', argc);
    
    argv(1) = input(''); 
    if argv(1) == public_defaultNumber()
        argv(1) = 0.1;
    end
    dataset = public_urw2dataset(inFileName);
    
    process = 0.1;
    fprintf('%f\n', process);
    
    robertsEdge3ByLayer(dataset, argv(0));
    
    public_dataset2urw(outFileName, res);
    
    process = 1.0;
    fprintf('%f\n', process);
end