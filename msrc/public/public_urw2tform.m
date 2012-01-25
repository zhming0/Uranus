function [tform] = public_urw2tform(filename)
%PUBLIC_URW2TFORM    Translate urw files into a transform matrix 
%    Input:    A urw file.
%    Output:    A 4 * 4 transform matrix.
%    Author:    Tsenmu
%    Date:    2012.01.24
%    Reference:    
    fid = fopen(filename, 'r');
    fread(fid, 5, 'uint8');
    tform = double(fread(fid, [4 4]));
    fclose(fid);
end