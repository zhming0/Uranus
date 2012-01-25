inFile='C:\Users\acer\Desktop\ctBones.urw';
outFile='C:\Users\acer\Desktop\ctOnlyKnee.urw';

[ds,ps]=public_urw2dataset(inFile);
sz=size(ds)
idt=ones(1,sz(1));
for z=1:4:sz(4)
    br=0;
    for y=sz(2):-4:1
        for x=1:4:sz(1)
            if ds(x,y,1,z)>10
                cc=1;
                lst=[x,y];
                while cc>0
                    zx=lst(cc,1);
                    zy=lst(cc,2);
                    ds(zx,zy,1,z)=0;
                    cc=cc-1;
                    if ds(zx+1,zy,1,z)>0
                        cc=cc+1;
                        lst=[lst;zx+1,zy];
                    end
                    if ds(zx-1,zy,1,z)>0
                        cc=cc+1;
                        lst=[lst;zx-1,zy];
                    end
                    if ds(zx,zy+1,1,z)>0
                        cc=cc+1;
                        lst=[lst;zx,zy+1];
                    end
                    if ds(zx,zy-1,1,z)>0
                        cc=cc+1;
                        lst=[lst;zx,zy-1];
                    end
                end
                br=1;
                break;
            end
        end
        if br
            io_progress(double(z)/double(sz(4)));
            break;
        end
    end
end
public_dataset2urw(outFile,ds,ps);