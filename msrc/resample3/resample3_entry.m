function [] = resample3_entry()
%RESAMPLE3_ENTRY    The entry to function RESAMPLE3
%    Input:    
%    Output:    
%    Author:    Tsenmu
%    Date:    2012.01.24
%    Reference:    
    inFileName = input('');
    outFileName = input('');
    [in_dataset, in_ps] = public_urw2dataset(inFileName);
    prog = 0.05; io_progress(prog);
    
    ref = io_getfile('*.urw', 'Please select the reference image');
    prog = 0.10; io_progress(prog);
    ref_dataset = public_urw2dataset(ref);
    B_size = size(ref_dataset);
    prog = 0.15;io_progress(prog);
    tform_path = io_getfile('*.urw', 'Please select the transform matrix');
    tform = public_urw2tform(tform_path);
    prog = 0.20; io_progress(prog);
    [out_dataset, out_ps] = resample3(in_dataset, in_ps, B_size, tform);
    prog = 0.90; io_progress(prog);
    public_dataset2urw(outFileName, out_dataset, out_ps);
    prog = 1.00; io_progress(prog);
end