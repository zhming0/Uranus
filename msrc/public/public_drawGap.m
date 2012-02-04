function [result] = public_drawGap(dataset, threshold)
%PUBLIC_DRAWGAP    draw out the black area betweens two biggist bones.
%                   This function is specially designed for AQ's processed
%                   image.
%    Input:    Dataset(N * N * 1 * N), a threshold for determine the
%               thickness of the twos bound of gap(5~10 is recommended).
%    Output:   Dataset
%    Author:    Ming (mjzshd)
%    Date:    2012.02.04
%    Reference: Nothing!
    squeeze(dataset);
    [r, c, h] = size(dataset);
    result = double(zeros(r, c, 1, h));
    %1
    hasboundup = zeros(r, c, h);
    hasbounddown = zeros(r, c, h);
    for z = h:-1:1
        %[r c h]
        for x = 1:r
            for y = 1:c
                if dataset(x, y, z) == 255 && z+1<=h && dataset(x, y, z+1)==255
                    hasboundup(x, y, z) = hasboundup(x, y, z+1)+1;
                elseif dataset(x, y, z) == 255
                    hasboundup(x, y, z) = 1;
                elseif z+1<=h && hasboundup(x, y, z+1) > 0
                    hasboundup(x, y, z) = hasboundup(x, y, z+1);
                end
            end
        end
    end
    for z = 1:h
        %[r c h]
        for x = 1:r
            for y = 1:c
                if dataset(x, y, z) == 255 && z-1>=1 && dataset(x, y, z-1)==255
                    hasbounddown(x, y, z) = hasbounddown(x, y, z-1)+1;
                elseif dataset(x, y, z) == 255
                    hasbounddown(x, y, z) = 1;
                elseif z-1>=1 && hasbounddown(x, y, z-1) > 0
                    hasbounddown(x, y, z) = hasbounddown(x, y, z-1);
                end
            end
        end
    end
    
    for z = 1:h
        for x = 1:r
            for y = 1:c
                if hasboundup(x, y, z) > threshold && hasbounddown(x, y, z) > threshold && dataset(x, y, z) == 0 
                    result(x, y, 1, z) = 255;
                end
            end
        end
    end
    
%     %2
%     hasboundleft = false(r, c, h);
%     hasboundright = false(r, c, h);
%     for x = r:1
%         for z = 1:h
%             for y = 1:c
%                 if dataset(x, y, z) == 255
%                     hasboundright(x, y, z) = true;
%                 elseif x+1<=r && hasboundright(x+1, y, z) == true
%                     hasboundright(x, y, z) = true;
%                 end
%             end
%         end
%     end
%     for x = 1:r
%         for z = 1:h
%             for y = 1:c
%                 if dataset(x, y, z) == 255
%                     hasboundleft(x, y, z) = true;
%                 elseif x-1>=1 && hasboundleft(x-1, y, z) == true
%                     hasboundleft(x, y, z) = true;
%                 end
%             end
%         end
%     end
%     
%     for z = 1:h
%         for x = 1:r
%             for y = 1:c
%                 if hasboundleft(x, y, z) == true && hasboundright(x, y, z) == true && dataset(x, y, z) == 0
%                     result(x, y, 1, z) = 255;
%                 end
%             end
%         end
%     end
%     
%     %3
%     hasboundforward = false(r, c, h);
%     hasboundbackward = false(r, c, h);
%     for y = c:1
%         for x = 1:r
%             for z = 1:h
%                 if dataset(x, y, z) == 255
%                     hasboundbackward(x, y, z) = true;
%                 elseif y+1<=c && hasboundbackward(x, y+1, z) == true
%                     hasboundbackward(x, y, z) = true;
%                 end
%             end
%         end
%     end
%     for y = 1:c
%         for x = 1:r
%             for z = 1:h
%                 if dataset(x, y, z) == 255
%                     hasboundforward(x, y, z) = true;
%                 elseif y-1>=1 && hasboundforward(x, y-1, z) == true
%                     hasboundforward(x, y, z) = true;
%                 end
%             end
%         end
%     end
%     
%     for z = 1:h
%         for x = 1:r
%             for y = 1:c
%                 if hasboundforward(x, y, z) == true && hasboundbackward(x, y, z) == true && dataset(x, y, z) == 0
%                     result(x, y, 1, z) = 255;
%                 end
%             end
%         end
%     end
end