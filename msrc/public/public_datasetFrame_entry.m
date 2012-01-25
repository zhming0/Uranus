function [] = public_datasetFrame_entry()
    inFileName = input('');
    outFileName = input('');
    [ds_in, ps_in] = public_urw2dataset(inFileName);
    io_progress(0.2);
    [ds_in, ps_in] = public_datasetFrame(ds_in, ps_in);
    io_progress(0.5);
    public_dataset2urw(outFileName, ds_in, ps_in);
    io_progress(1.0);
end