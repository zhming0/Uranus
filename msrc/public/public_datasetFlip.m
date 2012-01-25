function [ds_r, ps_r] = public_datasetFlip(ds_in, ps_in, orientation)
%PUBLIC_DATASETROTATE    The function flips the dataset.
%    Input:    Dataset and pixel size and orientation, where the
%              orientation can be 'updown', 'leftright', 'updown'.
%              (Assume that you are watching in front of 
%              dataset.)
%    Output:    Dataset and pixel size.
%    Author:    Tsenmu
%    Date:    2012.01.25
%    Reference:    
    ps_r = ps_in;
    ds_in = squeeze(ds_in);
    [r c h] = size(ds_in);
    ds_r = uint8(zeros([r c h]));
        for ri = 1 : r
            for ci = 1 : c
                for z = 1 : h
                    switch(lower(orientation))
                        case 'updown'
                            ds_r(ri, ci, h - z + 1) = ds_in(ri, ci, z);
                        case 'leftright'
                            ds_r(ri, c - ci + 1, z) = ds_in(ri, ci, z);
                        case 'frontback'
                            ds_r(r - ri + 1, ci, z) = ds_in(ri, ci, z);
                    end
                end
            end
        end
    ds_r = public_expand(ds_r);
end