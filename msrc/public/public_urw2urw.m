function [  ] = public_urw2urw(filename1,filename2,height)
%public_urw2urw    Compressed urw from urw files
%    Input:    Filename1: urw file name before compressing, filename2: urw file name after
%              compressing, height: picture numbers after compressing 
%    Output:    Compressed urw files
%    Author:    ZHM
%    Date:    2012.01.18
%    Reference:    
    a(:,:,:,:) = public_urw2dataset(filename1);
    [l1 l2 l3 l4] = size(a);
    data = 1;
    count = 1;
    jianju = uint8(l4/height)-1;
      for i = 1:height
          if count>l4
            b(:,:,1,data) = a(:,:,1,l4);
          else
            b(:,:,1,data) = a(:,:,1,count);  
          end
         data = data+1;
         count = count+jianju;
    end
     public_dataset2urw(filename2,b);
end

