function [] = imageShrink_entry()
%imageShrink_entry : The entry function of lineMatching 3D.
%    Input:     
%    Output:    
%    Author:    mjzshd + ZHM
%    Date:    2012.01.16
%    Reference:
    inFileName = char(input(''));
    outFileName = char(input(''));
    x = io_prompt(64, 'Please tell me the width of shrinked data.(x)');
    y = io_prompt(64, 'Tell me the length of shrinked data. (y)');
    z = io_prompt(32, 'Tell me the height of shrinked data. (z)');
    [source pixel] = public_urw2dataset(inFileName);
    result = imageShrink(source, x, y, z);
    [r c tmp h] = size(source);
    pixel(1) = pixel(1) * double(r)/double(x);
    pixel(2) = pixel(2) * double(c)/double(y);
    pixel(3) = pixel(3) * double(h)/double(z);
    
    public_dataset2urw(outFileName, result, pixel);
end