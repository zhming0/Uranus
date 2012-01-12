function Fostner = FostnerCorner(I)
%FOSTNERCORNER    Picking up focal spot
%    Input:    
%    Output:    
%    Author:    Tsenmu
%    Date:    2012.01.12
%    Reference:    
%                1.www.google.com
%                2.www.wikepedia.com

    I = int32(I);
    [r c] = size(I);
    img = double(zeros(r+2, c+2));
    Fostner = double(zeros(r, c));
    img(2:r+1, 2:c+1) = I;
    
    bw = false(r+2, c+2);
    img_x = double(zeros(r+2, c+2));
    img_y = double(zeros(r+2, c+2));
    
    op_x = double([-1 0 1]);
    op_y = double([-1 0 1]');
    
    for y = 2 : r+1
        for x = 2 : c+1
            img_x(y, x) = sum(img(y, x-1:x+1) .* op_x);
            img_y(y, x) = sum(img(y-1:y+1, x) .* op_y);
        end
    end
    
    
    for y = 2 : r+1
        for x = 2: c+1
            gx2 = mean(mean(img_x(y-1:y+1,x-1:x+1).^2));
            gy2 = mean(mean(img_y(y-1:y+1,x-1:x+1).^2));
            gx = mean(mean(img_x(y-1:y+1,x-1:x+1)));
            gy = mean(mean(img_y(y-1:y+1,x-1:x+1)));
            Fostner(y-1, x-1) = (gx2*gy2 - (gx*gy)^2) ...
                / gx2 + gy2;
        end
    end           
    for y = 1 :r
        for x = 1 :c
            if Fostner(y, x) >1000 && ~isnan(Fostner(y, x)) 
                bw(y+1, x+1) = 1;
            end
        end
    end
    
    bw = uint8(bw) * 255;
    
   % Fostner;
    [posr, posc] = find(bw == 255);
    bw = bw(2:r+1, 2:c+1);
    figure; imshow(bw);
    hold on;
  %  plot(posc, posr, 'r+');
end