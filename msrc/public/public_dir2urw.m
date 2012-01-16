function public_dir2urw( dirpath, limit, filename )
%PUBLIC_DIR2URW translate a directory of dicom files into a urw file
%    Input:    Directroy name, limit of taken files number, and the name of
%              the new urw file
%    Output:
%    Author:    Davidaq
%    Date:    2012.01.16
%    Reference:  public_dataset2urw

if(nargin == 2) 
    filename=limit;
    limit = 10000000;
elseif(nargin == 1) 
    filename=strcat(dirpath,'../new image.urw');
    limit = 10000000;
end
%TODO: finish this

public_dataset2urw(filename,dataset,pixelSize);

end

