function [ds_r, ps_r] = public_datasetRotate(ds_in, ps_in, orientation)
%PUBLIC_DATASETROTATE    The function rotates the dataset.
%    Input:    Dataset and pixel size and orientation, where the
%              orientation can be 'left', 'right', 'up', 'down', 'cw'
%              and 'ccw'. (Assume that you are watching in front of 
%              dataset.)
%    Output:    Dataset and pixel size.
%    Author:    Tsenmu
%    Date:    2012.01.25
%    Reference:    
    ps_r = ps_in;
    ds_in = squeeze(ds_in);
    [r c h] = size(ds_in);
    switch(orientation)
        case 'up'
            ds_r = uint8(zeros([h, c, r]));
            for ri = 1 : r
                for ci = 1 : c
                    for z = 1 : h
                        ds_r(z, ci, ri) = ds_in(ri, ci, z);
                    end
                end
            end
        case 'down'
            ds_r = uint8(zeros([h, c, r]));
            for ri = 1 : r
                for ci = 1 : c
                    for z = 1 : h
                        ds_r(z, ci, r - ri + 1) = ds_in(ri, ci, z);
                    end
                end
            end
        case 'left'
            ds_r = uint8(zeros([c, r, h]));
            for ri = 1 : r
                for ci = 1 : c
                    for z = 1 : h
                        ds_r(c - ci + 1, ri, z) = ds_in(ri, ci, z);
                    end
                end
            end
        case 'right'
            ds_r = uint8(zeros([c, r, h]));
            for ri = 1 : r
                for ci = 1 : c
                    for z = 1 : h
                        ds_r(ci, r - ri + 1, z) = ds_in(ri, ci, z);
                    end
                end
            end
        case 'cw'
            ds_r = uint8(zeros([r, h, c]));
            for ri = 1 : r
                for ci = 1 : c
                    for z = 1 : h
                        ds_r(ri, z, c - ci + 1) = ds_in(ri, ci, z);
                    end
                end
            end
        case 'ccw'
            ds_r = uint8(zeros([r, h, c]));
            for ri = 1 : r
                for ci = 1 : c
                    for z = 1 : h
                        ds_r(ri, z, ci) = ds_in(ri, ci, z);
                    end
                end
            end
    end
    ds_r = public_expand(ds_r);
end