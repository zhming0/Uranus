function result = linearFitting3( dataset )
%LINEARFITTING3    Linear fitting in 3D.
%    Input:    Dataset.
%    Output:    Dataset.
%    Author:    mjzshd
%    Date:    2012.01.12
%    Reference:    


%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    [row, column, height] = size(dataset);
    n = row * column * height;
    
    %row;
    %column;
    %height;
    
    %tic;
    A = single([0; 0; 0]); 
    
    for x = 1:row
        for y = 1 : column
            for z = 1 : height
                if dataset(x, y, z) ~= 0
                    A(1) = A(1) + x;
                    A(2) = A(2) + y;
                    A(3) = A(3) + z;
                end
            end
        end
    end
    A(1) = A(1)/n;
    A(2) = A(2)/n;
    A(3) = A(3)/n;
    sigma_xx = single(0);
    sigma_yy = single(0);
    sigma_zz = single(0);
    sigma_xy = single(0);
    sigma_xz = single(0);
    sigma_yz = single(0);
    sigma = single(0);
    
    for x = 1:row
        for y = 1 : column
            for z = 1 : height
                if dataset(x, y, z) ~= 0
                    sigma_xx = sigma_xx + (x -  A(1)) * (x -  A(1));
                    sigma_yy = sigma_yy + (y -  A(2)) * (y -  A(2));
                    sigma_zz = sigma_zz + (z -  A(3)) * (z -  A(3));
                    sigma_xy = sigma_xy + (x -  A(1)) * (y - A(2));
                    sigma_xz = sigma_xz + (x -  A(1)) * (z - A(3));
                    sigma_yz = sigma_yz + (y -  A(2)) * (z - A(3));
                end
            end
        end
    end
    
    sigma = sigma_xx + sigma_yy + sigma_zz;
    
    M  = [sigma - sigma_xx, -sigma_xy, -sigma_xz;
          -sigma_xy, sigma - sigma_yy, -sigma_yz;
          -sigma_xz, -sigma_yz, sigma - sigma_zz];
    
    [evec, eval] = eig(M);
    
    eigenvalue = eval(1, 1);
    target = 1;
    if(eval(2, 2) < eigenvalue)
        target = 2;
        eigenvalue = eval(2, 2);
    end
    if(eval(3, 3) < eigenvalue)
        target = 3;
    end
    
    D = evec(:, target);
    
    result = false(row, column, 1, height);
    for x = 1:row
        for y = 1 : column
            for z = 1 : height
                X = [x; y; z];
                
                %t1 = (X(1) - A(1))/D(1);
                %t2 = (X(2) - A(2))/D(2);
                %t3 = (X(3) - A(3))/D(3);
                
                di = (D'*(X - A));
                
                Yi = X - A;
                dis = (Yi - di * D);
                
                dis = single(dis(1)*dis(1) + dis(2)*dis(2) + dis(3)*dis(3));
                
                %[x y z dis;t1 t2 t3 0;]
                
                if dis<=0.25 && dataset(x, y, z)~=0
                    result(x, y, 1, z) = true;
                end
            end
        end
    end
    
    result = uint8(result) * 255;
    
    %toc
end

