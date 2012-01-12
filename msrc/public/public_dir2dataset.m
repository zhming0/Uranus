function dataset = public_dir2dataset(directory, limit)
%PUBLIC_DIR2DATASET    Translate files listed in a directory into dataset.
%    Input:    Directroy name, limit of taken files number.
%    Output:    Dataset.
%    Author:    Tsenmu
%    Date:    2012.01.12
%    Reference:    

    cd(directory);
    if(nargin == 1) 
        limit = 10000000;
    end
    
    d = dir;
    len = size(d);
    count = 0;
    for i = 1 : len
        obj = d(i);
        if ~obj.isdir
            count = count + 1;
            img = uint8(imread(obj.name));
            dataset(:,:,1,count) = img;
            if(count >= limit) 
                break;
            end
        end
    end
end