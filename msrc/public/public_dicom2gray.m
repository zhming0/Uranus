function res = public_dicom2gray(filename, WindowSelection)
%PUBLIC_DICOM2GRAY    Translate a DICOM file into a gray scale image.
%    Input:    A DICOM file.
%    Output:    A gray scale image, i.e. 2D matrix.
%    Author:    Tsenmu
%    Date:    2012.01.12
%    Reference:    

	if(length(nargin) == 1) 
		WindowSelection = 1;
	end
    img = dicomread(filename);
    info = dicominfo(filename);

	rsri = 0;
	if isfield(info, 'RescaleSlope') && isfield(info, 'RescaleIntercept')
		rsri = 1;
    end
    
	if rsri
		RescaleSlope = info.RescaleSlope;
		RescaleIntercept = info.RescaleIntercept;
		W = info.WindowWidth(WindowSelection);	%WindowWidth may be a struct.
		C = info.WindowCenter(WindowSelection); 	%WindowCenter may be a struct. 
		C = (C  - RescaleIntercept) / RescaleSlope;	
        W = W / RescaleSlope;
		%C = C * RescaleSlope + RescaleIntercept;
	else
		W = info.WindowWidth(WindowSelection);	%WindowWidth may be a struct.
		C = info.WindowCenter(WindowSelection); 	%WindowCenter may be a struct. 
    end
    
	[r, c] = size(img);
	res = uint8(zeros(r, c));

    for i = 1 : r
        for j = 1 : c
            V = double(img(i, j));
			if (V <= (C - W /2)) resV = 0;
			elseif(V > (C+W/2)) resV = 255;
			else   resV = (V - C + W/2) / W * 255;
			end
			res(i, j) = uint8(resV);	
        end
    end
    
end