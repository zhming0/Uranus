function [ds_F, ps_F] = fusion(ds_CT, ps_CT, ds_MR, ps_MR, CT_Thresh)
    ps_F = [];
    warn = false;
    if(size(ds_CT) ~= size(ds_MR)) 
       io_alert('The size of two images is not the same.'); 
       warn = true;
    end
    if(~warn) 
        [ds_CT, ~] = fusion_boneSelection(ds_CT,ps_CT, CT_Thresh);
        ds_F = uint8(double(ds_CT) * 0.8 + double(ds_MR));
    end
end