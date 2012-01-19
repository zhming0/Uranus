function [] = centralFitting3_entry()
%CENTRALFITTING3_ENTRY    The entry to centralFitting3 function.
%    Input:    
%    Output:    
%    Author:    Tsenmu
%    Date:    2012.01.19
%    Reference:    
    inFileName = input('');
    outFileName = input('');
    [dataset pixelSize] = public_urw2dataset(inFileName);
    prog = 0.05; io_progress(prog);
    [dr, pr] = centralFitting3(dataset, pixelSize);
    prog = 0.95; io_progress(prog);
    public_dataset2urw(outFileName,dr, pr);
    prog = 1.0; io_progress(prog);
end
    