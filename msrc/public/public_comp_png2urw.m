function [urw] = public_comp_png2urw(directory,srcpixel,zheight,filename)
%PUBLIC_DICOMREWRITE    Translate dicom files from source directory to
%                       png in target directory
%    Input:    Source directory(Such as CT), Source pixel(Such as 512),Urw
%              height(Such 32: a urw file contains 32 pngs),Urw name(Such
%              as ct.urw)
%    Output:    Urw files
%    Author:    ZHM
%    Date:    2012.01.16
%    Reference:    
%                1.www.google.com
%                2.www.wikepedia.com
    y = srcpixel;
    dataset = uint8([srcpixel y 1 zheight]);
    cd(directory);
    d = dir;
    len = size(d);
    jianju = len/zheight;
    count = 1;
    data = 1;
    for i = 1:len
        obj = d(count);
        if ~obj.isdir      
%--------------------DCT Compressed---------------------            
            I = imread(obj.name);
            I=im2double(I);
            T=dctmtx(8);
            B=blkproc(I,[8 8],'P1*x*P2',T,T');
        mask = [1   1   1   1   0   0   0   0
                1   1   1   0   0   0   0   0
                1   1   0   0   0   0   0   0
                1   0   0   0   0   0   0   0
                0   0   0   0   0   0   0   0
                0   0   0   0   0   0   0   0
                0   0   0   0   0   0   0   0
                0   0   0   0   0   0   0   0];
            B2 = blkproc(B,[8 8],@(x)mask.* x);
            I2 = blkproc(B2,[8 8],'P1*x*P2',T',T);
%--------------------Compressed End---------------------
            dataset(:,:,1,data) =uint8(I2);%!!!!!!BUG
            data = data+1;
            count = count+jianju;
        else
            count = count+1;
    end
    end
    urw = public_dataset2urw(filename,dataset);