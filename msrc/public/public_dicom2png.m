function varout = public_dicom2png(filename, WindowSelection)
%PUBLIC_DICOM2PNG    Translate a DICOM file into a png file.
%    Input:    A dicom file.
%    Output:    A png file.
%    Author:    Tsenmu
%    Date:    2012.01.12
%    Reference:    

    if(nargin == 2)
        varout = public_dicom2gray(filename, WindowSelection);
    else
        varout = public_dicom2gray(filename);
    end
    fn = java.lang.String(filename);
    nfn = java.lang.String('');
    if (fn.endsWith('.dcm'))
        pos = fn.length() - 4;
        if (pos >= 1)
            nfn = fn.substring(0, pos);
            nfn = nfn.concat('.png');
        end
    else
        nfn = fn.concat('.png');
    end
    nfilename = char(nfn);
    imwrite(varout, nfilename, 'png');
end
