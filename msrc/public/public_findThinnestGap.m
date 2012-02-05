function [result] = public_findThinnestGap(dataset)
%PUBLIC_DRAWGAP   To find the thinest gap.
%    Input:    Dataset(N * N * 1 * N)
%    Output:   Dataset
%    Author:    Ming (mjzshd)
%    Date:    2012.02.04
%    Reference: Nothing!
    squeeze(dataset);
    [r, c, h] = size(dataset);
    tmpstartpoint = zeros(1, 3);
    tmpendpoint = zeros(1, 3);
    startpoint = zeros(1, 3);
    endpoint = zeros(1, 3);
    minlen = 10000;
    for x = 1:r
        for y = 1:c
            state = 0;
            len = 0;
            for z = 1:h
                if state==0 && dataset(x, y, z) == 255
                    tmpstartpoint = [x, y, z];
                    len = 1;
                    state = 1;
                elseif state == 1 && dataset(x, y, z) == 255
                    len = len+1;
                    tmpendpoint = [x, y, z];
                elseif state == 1 && dataset(x, y, z) == 0
                    if len > 10 && len < minlen
                        minlen = len;
                        startpoint = tmpstartpoint;
                        endpoint = tmpendpoint;
                    end
                    state = 0;
                    len = 0;
                end
            end
        end
    end
    result = [startpoint; endpoint];
end