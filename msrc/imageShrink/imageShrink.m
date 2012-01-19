function [res] = imageShrink(dataset,post_x,post_y,post_z)
%public_urw2urw    Compressed urw from urw files
%    Input:    Filename1: urw file name before compressing, filename2: urw file name after
%              compressing, height: picture numbers after compressing 
%    Output:    Compressed urw files
%    Author:    ZHM + mjzshd
%    Date:    2012.01.18
%    Reference:    
    [l1 l2 l3 l4] = size(dataset);
    
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
    
    res = uint8(zeros(post_x, post_y, 1, post_z));
    
    count_x = 1;
    for i = 1:post_x
        count_y = 1;
        for j = 1:post_y
            count_z = 1;
            for k = 1:post_z
                if count_x > l1
                    count_x = l1;
                end
                if count_y > l2
                    count_y = l2;
                end
                if count_z > l4
                    count_z = l4;
                end
                res(i, j, 1, k) = dataset(count_x, count_y, 1, count_z);
                %[res(i, j, 1, k) count_x count_y count_z]
                count_z = count_z+gap_z;
            end
            count_y = count_y + gap_y;
        end
        count_x = count_x+gap_x;
        io_progress(double(i)/double(post_x));
    end
    
end

