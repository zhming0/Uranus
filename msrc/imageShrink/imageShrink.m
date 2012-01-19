function [res] = imageShrink(dataset,post_x,post_y,post_z)
%public_urw2urw    Compressed urw from urw files
%    Input:    Filename1: urw file name before compressing, filename2: urw file name after
%              compressing, height: picture numbers after compressing 
%    Output:    Compressed urw files
%    Author:    ZHM
%    Date:    2012.01.18
%    Reference:    
    [l1 l2 l3 l4] = size(dataset);
    data_x = 1;
    data_y = 1;
    data_z = 1;
    count_x = 1;
    count_y = 1;
    count_z = 1;
    gap_x = uint8(l1/post_x)-1;
    gap_y = uint8(l1/post_y)-1;
    gap_z = uint8(l1/post_z)-1;
    b = ones(post_x,post_y,1,post_z);
      for i = 1:post_x
          for j = 1:post_y
            for k = 1:post_z
              if count_x>l1
                b(data_x,data_y,1,data_z) = dataset(l1,count_y,1,count_z);
              if count_y>l2
                b(data_x,data_y,1,data_z) = dataset(count_x,l2,1,count_z);
              if count_z>l4
                b(data_x,data_y,1,data_z) = dataset(count_x,count_y,1,l4);
              else
                b(data_x,data_y,1,data_z) = dataset(count_x,count_y,1,count_z);  
              end
              end
            data_x = data_x+1;
            count_x = count_x+gap_x;
            end
           data_y = data_y+1;
           count_y = count_y+gap_y;
          end
         data_z = data_z+1;
         count_z = count_z+gap_z;
     end
    res = b;
end

