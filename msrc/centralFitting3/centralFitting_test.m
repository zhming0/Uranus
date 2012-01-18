function [] = centralFitting_test()
    [dataset pixelSize] = public_urw2dataset('F:\IR\urw\CT_segment_only_left_knee.urw');
    [dr, pr] = centralFitting(dataset, pixelSize);
  %  montage(dr);
    public_dataset2urw('F:\IR\Uranus\msrc\centralFitting3\ct_left_centre.urw',dr, pr);
end