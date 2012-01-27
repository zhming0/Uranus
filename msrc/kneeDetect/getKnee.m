inFile='C:\Users\acer\Desktop\ctBones.urw';
outFile='C:\Users\acer\Desktop\ctOnlyKnee.urw';

[ds,ps]=public_urw2dataset(inFile);
sz=size(ds);
idt=ones(1,sz(1));
newDs=zeros(sz);
pnts=0;
for z=1:4:sz(2)
    io_progress(double(y)/double(sz(2)));
    for y=1:4:sz(4)
        for x=1:4:sz(1)
            if ds(x,y,1,z)>0
                cc=1;
                lst=zeros(10000,3);
                lst(1,:)=[x,y,z];
                while cc>0
                    zx=lst(cc,1);
                    zy=lst(cc,2);
                    zz=lst(cc,3);
                    cc=cc-1;
                    if(ds(zx,zy,1,z)==0)
                        continue;
                    end
                    newDs(zx,zy,1,zz)=255;%ds(zx,zy,1,zz);
                    ds(zx,zy,1,z)=0;
                    pnts=pnts+1;
                    for dx=-2:2
                        for dy=-2:2
                            for dz=-2:2
                                vx=zx+dx;
                                vy=zy+dy;
                                vz=zz+dz;
                                try
                                    if ds(vx,vy,1,vz)>0
                                        cc=cc+1;
                                        lst(cc,:)=[vx,vy,vz];
                                    end
                                catch
                                end
                            end
                        end
                    end
                end
                break;
            end
        end
        if pnts>10
            break;
        end
    end
    if pnts>10
        break;
    end
end
montage(newDs);
public_dataset2urw(outFile,newDs,ps);