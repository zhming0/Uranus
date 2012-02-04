 [ds_in, ps_in] = public_urw2dataset('F:\IR\urw\mr_axis.urw');

[ds_out, ps_out] = KRCorner3(ds_in, ps_in);
public_dataset2urw('mr_axis.urw', ds_out, ps_out);
montage(ds_out);
% ds_out