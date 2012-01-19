function [] = edgeFilter3_entry()
%EDGEFILTER3_ENTRY    The entry to function edgeFilter3
%    Input:
%    Output:    
%    Author:    Tsenmu
%    Date:    2012.01.19
%    Reference:    

    inFileName = input('');
    outFileName = input('');
    [dataset, pixelSize] = public_urw2dataset(inFileName);
    prog = 0.05; io_progress(prog);
    diskSize = io_prompt(10, 'Please input the the size of disk used as a SE: ');
    [res, rps] = edgeFilter3(dataset, pixelSize, diskSize);
    prog = 0.95; io_progress(prog);
    public_dataset2urw(outFileName, res, rps);
    prog = 1.0; io_progress(prog);
end