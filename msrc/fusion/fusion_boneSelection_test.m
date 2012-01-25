[ds_in, ps_in] = public_urw2dataset('F:\IR\urw\CT_segment_only_right_knee.urw');
[ds_r, ps_r] = fusion_boneSelection(ds_in, ps_in, 160);
montage(ds_r);