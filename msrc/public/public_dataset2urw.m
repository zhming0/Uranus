function [] = public_dataset2urw(filename, dataset)
%PUBLIC_DATASET2URW    Translate dataset files into urw files
%    Input:    Output urw file full path and the dataset.
%    Output:    
%    Author:    Tsenmu
%    Date:    2012.01.12
%    Reference:    

  %  filename = native2unicode(uint8(filename));
    fid = fopen(filename, 'w');
	dataset = squeeze(dataset);
    [r, c, t] = size(dataset);
    fwrite(fid, [c, r], 'uint16');
    for z = 1 :t
        fwrite(fid, 1);
        fwrite(fid, dataset(:, :, z));
    end
    fwrite(fid, 0);
    fclose(fid);
end