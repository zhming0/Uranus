function [] = public_datasetGrid_entry()
    inFileName = input('');
    outFileName = input('');
    increment =  io_prompt(5.0, 'Please enter the increment of grids');
    [ds_in, ps_in] = public_urw2dataset(inFileName);
    io_progress(0.2);
    [ds_in, ps_in] = public_datasetGrid(ds_in, ps_in, increment);
    io_progress(0.5);
    public_dataset2urw(outFileName, ds_in, ps_in);
    io_progress(1.0);
%         [0.4972   -0.2722   -0.5375  138.1875;0.2889   -0.6889   -0.1000  174.5000;  0.9806    1.0944    0.9875 -272.4375]
end