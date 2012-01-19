function [] = centralFitting3_test()
    [dataset pixelSize] = public_urw2dataset('F:\IR\urw\CT_segment_only_right_knee.urw');
    [dr, pr] = centralFitting3(dataset, pixelSize);
    public_dataset2urw('F:\IR\urw\ct_right_centre.urw',dr, pr);
end