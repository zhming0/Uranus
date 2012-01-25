inFile='C:\Users\acer\Desktop\CT_segment_only_right_knee.urw';
outFile='C:\Users\acer\Desktop\ctBones.urw';

[ds,ps]=public_urw2dataset(inFile);
sz=size(ds);
for z=1:sz(4)
    for x=1:sz(1)
        for y=1:sz(2)
            if ds(x,y,1,z)<200
                ds(x,y,1,z)=0;
            end
        end
    end
end
public_dataset2urw(outFile,ds,ps);