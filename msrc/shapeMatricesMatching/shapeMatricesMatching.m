function [ret] = shapeMatricesMatching(ctset, mrset, arg1);
    num_point = 0;
    num_shape_ct = 0;
    num_shape_mr = 0;
    que = zeros(10000, 3);
    head = 0;
    tail = 0;
    [ct_r, ct_c, ~, ct_h] = size(ctset);
    ct_vst = false(ct_r, ct_c, ct_h);
    squeeze(ctset);
    [mr_r, mr_c, ~, mr_h] = size(mrset);
    mr_vst = false(mr_r, mr_c, mr_h);
    squeeze(mrset);
    %ct_shapeMat = zeros(100, 26, num_step);
    %mr_shapeMat = zeros(100, 26, num_step);
    %Locate ct region and determin shapeMat
    for x = 1:ct_r
        for y=1:ct_c
            for z = 1:ct_h
                if ctset(x, y, z) == 0 || ct_vst(x, y, z) == true
                    continue;
                end
                pointset = 0;
                ct_vst(x, y, z) = true;
                tail = 0; head = 0;
                que(tail, :) = [x, y, z];
                tail = tail + 1;
                num_point = 1;
                pointset(num_point, :) = [x, y, z];
                %BFS
                while tail > head
                    [tmp_x, tmp_y, tmp_z] = que(head, :);
                    head = head+1;
                    for i = -1:1
                        for j = -1:1
                            for k = -1:1
                                new_x = tmp_x + i;
                                new_y = tmp_y + j;
                                new_z = tmp_z + k;
                                if ctset(new_x, new_y, new_z)==255 && ct_vst(new_x, new_y, new_z)==false
                                    num_point = num_point+1;
                                    pointset(num_point, :) = [new_x, new_y, new_z];
                                    ct_vst(new_x, new_y, new_z) = true;
                                    que(tail, :) = [new_x, new_y, new_z];
                                    tail = tail + 1;
                                end
                            end
                        end
                    end                   
                end
                
                if num_point < 50 %Filter small piece noise.
                    continue;
                end
                num_shape_ct = num_shape_ct+1;
                [ct_shape(num_shape_ct) ct_centroid(num_shape_ct)] = shapeMatricesMatching_calcShapeMatrics(pointset, arg1);
            end
        end
    end
    %Locate mr region and find correspond point.
    for x = 1:mr_r
        for y=1:mr_c
            for z = 1:mr_h
                if mrset(x, y, z) == 0 || mr_vst(x, y, z) == true
                    continue;
                end
                pointset = 0;
                tail = 0; head = 0;
                mr_vst(x, y, z) = true;
                que(tail, :) = [x, y, z];
                tail = tail + 1;
                num_point = 1;
                pointset(num_point, :) = [x, y, z];
                %BFS
                while tail > head
                    [tmp_x, tmp_y, tmp_z] = que(head, :);
                    head = head+1;
                    for i = -1:1
                        for j = -1:1
                            for k = -1:1
                                new_x = tmp_x + i;
                                new_y = tmp_y + j;
                                new_z = tmp_z + k;
                                if mrset(new_x, new_y, new_z)==255 && mr_vst(new_x, new_y, new_z)==false
                                    num_point = num_point+1;
                                    pointset(num_point, :) = [new_x, new_y, new_z];
                                    mr_vst(new_x, new_y, new_z) = true;
                                    que(tail, :) = [new_x, new_y, new_z];
                                    tail = tail + 1;
                                end
                            end
                        end
                    end                   
                end
                
                if num_point < 50 %Filter small piece noise.
                    continue;
                end
                num_shape_mr = num_shape_mr+1;
                [mr_shape(num_shape_mr) mr_centroid(num_shape_mr)]= shapeMatricesMatching_calcShapeMatrics(pointset, arg1);
            end
        end
    end
    
    for i= 1:num_shape_mr
        tmp_max = -100;
        for j = 1:num_shape_ct
            tmp = shapeMatricesMatching_calcSimilarity(mr_shape(i), ct_shape(j));
            if tmp>tmp_max
                idx = j;
                tmp_max = tmp;
            end
        end
        ret(i) = [ct_centroid(i), mr_centroid(j)];
    end
    
end