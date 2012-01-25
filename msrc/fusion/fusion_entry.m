function [] = fusion_entry()
    mr_image_path = input('');
    fusion_result_path = input('');
    ct_image_path = io_getfile('*.urw', 'Please select the CT urw file:');
    io_progress(0.3);
    [mr_image, mr_ps] = public_urw2dataset(mr_image_path);
    [ct_image, ct_ps] = public_urw2dataset(ct_image_path);
    ct_thresh = io_prompt(160, 'Please set the value as the threshold to segment CT image:');
    io_progress(0.5);
    [ds_F, ~] = fusion(ct_image, ct_ps, mr_image, mr_ps, ct_thresh);
    io_progress(0.8);
    public_dataset2urw(fusion_result_path, ds_F, []);
    io_prgress(1.0);
end