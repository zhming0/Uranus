function boneFromMri
    inFile='C:\Users\acer\Desktop\mr2.urw';
    outFile='C:\Users\acer\Desktop\mrBone.urw';
    [ds,ps]=public_urw2dataset(inFile);
    ds=double(ds);
    [~,~,d]=size(ds);
    for i=1:d
        io_progress(i,d);
        ds(:,:,1,i)=dofcm(ds(:,:,1,i));
    end
    montage(ds);
    public_dataset2urw(outFile,uint8(ds),ps);
end

function res=dofcm(pic)
    [m,n] = size(pic);
    data(1:m*n,1) = reshape(pic,m*n,1);
    options = [2 200 1e-5 0];
    cluster_n = 7;
    [~, U, ~] = fcm(data, cluster_n, options);
    [~,maxi]=max(U);
    ll=ones(cluster_n,1)*255;
    for i = 1:cluster_n
        ll(i)=data(find( maxi==i,1));
    end
    [~,i]=min(ll);
    res=double(maxi==i).*255;
    res = reshape(res,m,n,1);
end
