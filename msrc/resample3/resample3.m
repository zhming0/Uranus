function [out_dataset, out_ps] = resample3(in_dataset, in_ps, B_size, tform)
%RESAMPLE3    this function outputs the resampled dataset.
%    Input:    Dataset, Pixel Size, The size to be resampled([r c 1 h]), A
%              4 * 4 transform matrix.
%    Output:    Dataset and Pixel size.
%    Author:    Tsenmu
%    Date:    2012.01.24
%    Reference:    
    out_ps = in_ps;
    out_r = B_size(1); out_c = B_size(2); out_h = B_size(4);
    T = maketform('affine', tform);
    R = makeresampler('cubic', 'fill');
    out_dataset = uint8(tformarray(in_dataset, T, R, [1 2 4], [1 2 4], [out_r, out_c, 1, out_h], [], []));
    prog = 0.50; io_progress(prog);
end