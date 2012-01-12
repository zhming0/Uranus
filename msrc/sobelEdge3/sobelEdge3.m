function bw = sobelEdge3(dataset)
%SOBELEDGE3    Edge detecting by sobel operator
%    Input:    Dataset.
%    Output:    Black white dataset.
%    Author:    Tsenmu
%    Date:    2012.01.12
%    Reference:    



    thresh = 3100;
    [r, c, ~, h] = size(dataset);
    dataset = int32(dataset);
    box1 = int32(zeros([3, 3, 3]));
    box2 = int32(zeros([3, 3, 3]));
    box3 = int32(zeros([3, 3, 3]));
    sobel = [-1 -2 -1; 0 0 0 ; 1 2 1];
    box1(:, :, 2) = sobel;
    box2(:, 2, :) = sobel;
    box3(2, :, :) = sobel;
    bw = false(r, c, 1, h);
    for x = 2 : r-1
        for y = 2 : c-1
            for z = 2 : h-1
                datasetbox = dataset(x-1:x+1, y-1:y+1,1,z-1:z+1);
                datasetbox = squeeze(datasetbox);
                temp1 = abs(box1.*datasetbox);
                temp2 = abs(box2.*datasetbox);
                temp3 = abs(box3.*datasetbox);
                v = sum([sum(temp1(:)), sum(temp2(:)),sum(temp3(:))]);
                if v > thresh
                    bw(x, y,1,z) = 1;
                end
            end
        end
    end
    bw = uint8(bw) * 255;
end