function [ds_r, ps_r] = public_datasetFlip(ds_in, ps_in, orientation)
    ps_r = ps_in;
    ds_in = squeeze(ds_in);
    [r c h] = size(ds_in);
    switch(orientation)
        case 'up'
            ds_r = uint8(zeros([h, c, r]));
            for ri = 1 : r
                for ci = 1 : c
                    for z = 1 : h
                        ds_r(z, ci, ri) = ps_in(ri, ci, z);
                    end
                end
            end
        case 'down'
            ds_r = uint8(zeros([h, c, r]));
            for ri = 1 : r
                for ci = 1 : c
                    for z = 1 : h
                        ds_r(z, ci, r - ri + 1) = ps_in(ri, ci, z);
                    end
                end
            end
        case 'left'
            ds_r = uint8(zeros([c, r, h]));
            for ri = 1 : r
                for ci = 1 : c
                    for z = 1 : h
                        ds_r(c - ci + 1, ri, z) = ps_in(ri, ci, z);
                    end
                end
            end
        case 'right'
            ds_r = uint8(zeros([c, r, h]));
            for ri = 1 : r
                for ci = 1 : c
                    for z = 1 : h
                        ds_r(ci, r - ri + 1, z) = ps_in(ri, ci, z);
                    end
                end
            end
    end
    ds_r = public_expand(ds_r);
end