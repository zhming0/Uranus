function dataset = public_NN(A)
%PUCLIC_NN      A resampling function using Nearest Neighbor method
%    Input:    dataset of urw files
%    Output:	resampled dataset of urw files
%    Author:    DYZ
%    Date:    2012.1.24

    tic
    [x,y,~,z] = size(A);
    for c = 1:z
        for a = 1:x
            for b = 1:y
                %Transform function
                u = double(uint8(x));
                v = double(uint8(y));
                w = double(uint8(z));
                if X - u > 0.5
                    u = u + 1;
                end;
                if Y - v > 0.5
                    v = v + 1;
                end;
                if Z - w > 0.5
                    w = w + 1;
                end;
                dataset(a,b,1,c) = A(u,v,1,w);
            end;
        end;
    end;
    toc
end