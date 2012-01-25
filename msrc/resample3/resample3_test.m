    inFileName = 'F:\IR\urw\CT_segment_only_right_knee.urw';
    outFileName = 'F:\IR\res.urw';
    [in_dataset, in_ps] = public_urw2dataset(inFileName);
    ref = 'F:\IR\urw\mr.urw';
    [ref_dataset, ~] = public_urw2dataset(ref);
    B_size = size(ref_dataset);
   
    
    tform = [0.4972   -0.2722   -0.5375  138.1875;0.2889   -0.6889   -0.1000  174.5000;0.9806    1.0944    0.9875 -272.4375;0 0 0 1];
    [out_dataset, out_ps] = resample3(in_dataset, in_ps, B_size, tform);

    public_dataset2urw(outFileName, out_dataset, []);