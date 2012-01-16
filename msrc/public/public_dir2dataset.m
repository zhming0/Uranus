function dataset = public_dir2dataset(directory, format, limit)
%PUBLIC_DIR2DATASET    Translate files listed in a directory into dataset.
%    Input:    Directroy name, limit of taken files number.
%    Output:    Dataset.
%    Author:    Tsenmu
%    Date:    2012.01.12
%    Reference:    
    

   
    if(nargin == 1) 
        format = 'png';
        limit = 10000;
    end
    
    [stat, mess] = fileattrib([fileparts(directory), '\*.', format]);

    [~, len] = size(mess)
    count = 0;
    for i = 1 : len
        obj = mess(1, i).Name;
        count = count + 1;
        img = uint8(imread(obj));
        dataset(:,:,1,count) = img;
        if(count >= limit) 
            break;
        end
    end
end