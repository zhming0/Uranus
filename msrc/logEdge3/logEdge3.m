function bw = logEdge3(data, sigma, s, rfactor)
%LOGEDGE3    Edge detecting 3D algorithm
%    Input:    
%    Output:    
%    Author:    Tsenmu
%    Date:    2012.01.12
%    Reference:    
%                1.www.google.com
%                2.www.wikepedia.com

    [row, col, ~, h] = size(data);

    % s = 3 sigma = 0.5 rfactor = 0.477
    
        s =3;
        sigma = 0.5;
        rfactor = 0.477;
    
    c = (s+1)/2; 
    dif = c-1;
    box = single(zeros([s, s, s])); 
    for x = 1 : s
        for y = 1 : s
            for z = 1 : s
                rsq = rfactor* ((x-c)^2 + (y-c)^2+(z-c)^2);
             box(x,y, z) = 1/(2*pi*sigma^2)*exp( - rsq / (2*sigma^2) );
            end
        end
    end
    
    for x = c : s-dif
        for y = c : s-dif
            for z = c : s-dif
                box(x, y, z) = box(x+1, y, z) + ...
                    box(x-1, y, z) + box(x, y+1, z)+ ...
                    box(x, y-1, z) + box(x, y, z+1) + ...
                    box(x, y, z-1) - 6*box(x, y, z);
            end
        end
    end
    
    dataset = true([row, col, 1, h]);
    for x = c : row-dif
        for y = c : col-dif
            for z = c :h-dif         
                scanbox = single(data(x-dif:x+dif, y-dif:y+dif, z-dif:z+dif));
                res =scanbox.*box;
                if sum(sum(sum(res, 3),2), 1) < 0
                    dataset(x, y,1, z) = 0;
                end
            end
        end
    end
    bw = false([row, col, 1, h]);
    for x = c:row-dif
        for y = c:col-dif
            for z = c:h-dif
                if xor(dataset(x-1,y,z),dataset(x+1, y,z)) || ...
                        xor(dataset(x, y-1, z),dataset(x, y+1, z)) || ...
                        xor(dataset(x, y, z-1), dataset(x, y, z+1))
                    bw(x, y, 1,z) = 1;
                end
            end
        end
    end
    bw = uint8(bw) * 255;
    figure; montage(bw);
end
