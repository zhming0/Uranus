function [res] = imageShrink(dataset,post_x,post_y,post_z)
%public_urw2urw    Compressed urw from urw files
%    Input:    Filename1: urw file name before compressing, filename2: urw file name after
%              compressing, height: picture numbers after compressing 
%    Output:    Compressed urw files
%    Author:    ZHM + mjzshd
%    Date:    2012.01.18
%    Reference:    
    [l1 l2 l3 l4] = size(dataset);
    count_x = 1;
    count_y = 1;
    count_z = 1;
    gap_x = uint16(l1/post_x);
    gap_y = uint16(l2/post_y);
    gap_z = uint16(l4/post_z);
    if mod(l1, post_x)~=0
        gap_x = gap_x + 1;
    end
    if mod(l2, post_y)~=0
        gap_y = gap_y + 1;
    end
    if mod(l4, post_z)~=0
        gap_z = gap_z + 1;
    end
    
    b = zeros(post_x,post_y,1,post_z);
    
    for i = 1:post_x
        io_progress(double(i)/double(post_x));
        for j = 1:post_y
            for k = 1:post_z
                tmp_x = mod(count_x, l1);
                tmp_y = mod(count_y, l2);
                tmp_z = mod(count_z, l4);
                if tmp_x == 0
                    tmp_x = l1;
                end
                if tmp_y == 0
                    tmp_y = l2;
                end
                if tmp_z == 0
                    tmp_z = l4;
                end
                b(i, j, 1, k) = dataset(tmp_x, tmp_y, 1, tmp_z);
                count_x = count_x+gap_x;
            end
            count_y = count_y+gap_y;
        end
        count_z = count_z+gap_z;
    end
    res = b;
end

