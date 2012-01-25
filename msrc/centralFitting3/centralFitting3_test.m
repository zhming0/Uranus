function [] = centralFitting3_test()
    [dataset pixelSize] = public_urw2dataset('F:\IR\urw\ct.urw');
    [dataset, pixelSize] = edgeFilter3(dataset, pixelSize, 10, 0.04, 'ct');
    public_dataset2urw('F:\IR\urw\ct_edge.urw', dataset, pixelSize);
    [dataset, pixelSize] = centralFitting3(dataset, pixelSize);
    public_dataset2urw('F:\IR\urw\ct_axis.urw',dataset, pixelSize);
    
%     [dataset pixelSize] = public_urw2dataset('F:\IR\urw\mr.urw');
%     [dataset, pixelSize] = edgeFilter3(dataset, pixelSize, 10, 0.5, 'mr');
%     public_dataset2urw('F:\IR\urw\mr_edge.urw', dataset, pixelSize);
%     [dataset, pixelSize] = centralFitting3(dataset, pixelSize);
%     public_dataset2urw('F:\IR\urw\mr_axis.urw',dataset, pixelSize); 
end