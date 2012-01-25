function [ds_r, ps_r] = fusion_boneSelection(ds_in, ps_in, thresh)
    ps_r = ps_in;
    ds_r = uint8(ds_in > thresh) .* ds_in;
end