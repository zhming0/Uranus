function bw = KRCorner(I)
%KRCORNER    Picking up focal spot
%    Input:    
%    Output:    
%    Author:    Tsenmu
%    Date:    2012.01.12
%    Reference:    
%                1.www.google.com
%                2.www.wikepedia.com

    %H = fspecial('prewitt');
    %I = filter2(H, I);
    I = int32(I);
    [r c] = size(I);
    img = int32(zeros(r+2, c+2));
    KR = double(zeros(r, c));
    img(2:r+1, 2:c+1) = I;
    
    bw = false(r+2, c+2);
    img_x = int32(zeros(r+2, c+2));
    img_y = int32(zeros(r+2, c+2));
    img_xx = int32(zeros(r+2, c+2));
    img_xy = int32(zeros(r+2, c+2));
    img_yy = int32(zeros(r+2, c+2));
    img_yx = int32(zeros(r+2, c+2));
    
    op_x = int32([-1 0 1]);
    op_y = int32([-1 0 1]');
    
    for y = 2 : r+1
        for x = 2 : c+1
            img_x(y, x) = sum(img(y, x-1:x+1) .* op_x);
            img_y(y, x) = sum(img(y-1:y+1, x) .* op_y);
        end
    end
    
    for y = 2 : r+1
        for x = 2 : c+1
            img_xx(y, x) = sum(img(y, x-1:x+1) .* op_x);
            img_xy(y, x) = sum(img(y-1:y+1, x) .* op_y);
            img_yy(y, x) = sum(img(y-1:y+1, x) .* op_y);
            img_yx(y, x) = sum(img(y, x-1:x+1) .* op_x);
        end
    end
    
    for y = 2 : r+1
        for x = 2: c+1
            KR(y-1, x-1) = double((img_x(y, x))^2*img_yy(y,x) ...
                - 2*img_x(y,x)*img_y(y,x)*img_xy(y,x) ...
                + (img_y(y, x)^2*img_xx(y, x))) / ...
                (double(img_x(y, x)^2 + img_y(y, x)^2) ^ 1.5);
        end
    end           
    for y = 1 :r
        for x = 1 :c
            if KR(y, x) == 0
                bw(y+1, x+1) = 1;
            end
        end
    end
    bw = uint8(bw) * 255;
    
    [posr, posc] = find(bw == 255);
    %KR
        
%     bw_1 = uint8(zeros(r+2, c+2));
%     bw_1 = bw;
%     for y = 2 : r+1
%         for x = 2: c+1
%             count = 0;            
%             if bw_1(y-1,x) == 255 
%                 count = count + 1;
%             end
%             if bw_1(y+1,x) == 255
%                 count = count + 1;
%             end
%             if bw_1(y,x+1) == 255
%                 count = count + 1;
%             end
%             if bw_1(y,x-1) == 255
%                 count = count + 1;
%             end
%             if bw_1(y+1,x+1) == 255
%                 count = count + 1;
%             end
%             if bw_1(y+1,x-1) == 255
%                 count = count + 1;
%             end
%             if bw_1(y-1,x+1) == 255
%                 count = count + 1;
%             end
%             if bw_1(y-1,x-1) == 255
%                 count = count + 1;
%             end
%            % count
%             if count 
%                 bw(y, x) = 0;
%             end
%          end
%     end
    bw = bw(2:r+1, 2:c+1);
    figure; imshow(bw);
    hold on;
   % plot(posc, posr, 'r+');
end