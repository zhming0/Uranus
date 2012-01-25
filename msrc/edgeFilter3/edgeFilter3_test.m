    inFileName = 'F:\IR\urw\CT_segment_only_right_knee.urw';
%     outFileName = 'F:\IR\urw\res.urw';
    [dataset, pixelSize] = public_urw2dataset(inFileName);
    diskSize = 1;
    thresh = 0.05;
    [res, rps] = edgeFilter3(dataset, pixelSize, diskSize, thresh, 'ct');
    montage(res);
%     public_dataset2urw(outFileName, res, rps);
