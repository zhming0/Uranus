
inFile='C:\Users\acer\Desktop\mrBone.urw';
outFile='C:\Users\acer\Desktop\mrBones2.urw';
[ds,ps]=public_urw2dataset(inFile);
[ds,ps]=public_datasetRotate(ds,ps,'up');
[~,~,d]=size(ds);
rg=strel('disk', 2);
for i=1:d
    im=ds(:,:,1,i)>0;
    im=bwmorph(im,'clean',2);
    ds(:,:,1,i)=imopen(imclose(double(im)*255,rg),rg);
end
[ds,ps]=public_datasetRotate(ds,ps,'down');
[sr,sc,d]=size(ds);
rg=strel('disk', 1);
onem=ones(sr,sc);
for i=1:d
    io_progress(i,d);
    im=ds(:,:,1,i)>0;
    im=bwmorph(im,'clean',2);
    im=imopen(imclose(double(im)*255,rg),rg);
    ds(:,:,1,i)=im;
end
montage(ds);
public_dataset2urw(outFile,ds,ps);