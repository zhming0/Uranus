#include "../public/UDataset.h"
#include "../public/UList.h"
#include <iostream>
#include <stdio.h>

using namespace std;

class Point
{
public:
    uint x,y,z;
    Point(uint _x,uint _y,uint _z)
    {
        x=_x;y=_y;z=_z;
    }
};

void prepare(UDataset &ds)
{
    uint sx,sy,sz;
    ds.size(sx,sy,sz);
    UDataset flag(sx,sy,sz);
    Byte bgc=ds(1,1,1,1)+10;
    Point* pt=new Point(1,1,1);
    flag(1,1,1)=1;
    UList stack;
    stack.append(pt);
    while(stack.count()>0)
    {
        pt=(Point*)stack.back();
        stack.pop_back();
        uint x=pt->x,y=pt->y,z=pt->z;
        if(ds(x,y,z)<=bgc)
        {
            ds(x,y,z)=255;
            for(int dx=-1;dx<=1;dx++)for(int dy=-1;dy<=1;dy++)for(int dz=-1;dz<=1;dz++)
            {
                uint tx=x+dx,ty=y+dy,tz=z+dz;
                if(tx<1||ty<1||tz<1||tx>sx||ty>sy||tz>sz||flag(tx,ty,tz))
                    continue;
                if(ds(tx,ty,tz)<=bgc)
                {
                    stack.append(new Point(tx,ty,tz));
                }
                flag(tx,ty,tz)=1;
            }
        }
        delete pt;
    }


    for(uint x=1;x<=sx;x++)for(uint y=1;y<=sy;y++)for(uint z=1;z<=sz;z++)
    {
        int c=0,m=0,t;
        if(ds(x,y,z))
        {
            int dz=0;
            for(int dx=-1;dx<=1;dx++)for(int dy=-1;dy<=1;dy++)
            {
                uint tx=x+dx,ty=y+dy,tz=z+dz;
                if(tx<1||ty<1||tz<1||tx>sx||ty>sy||tz>sz)
                    continue;
                c++;
                t=ds(tx,ty,tz);
                if(t>180)
                    t=180;
                m+=255*t/180;
            }
            ds(x,y,z)=m/c;
        }
    }
}

void dofcm(UDataset &ds,int clust_c)
{
    void fcm(Byte*,int len,int count,double*& U,double*& center);

    uint sx,sy,sz;
    ds.size(sx,sy,sz);
    int len=sx*sy;
    double* U,*C;
    for(uint z=1;z<=sz;z++)
    {
        printf("%f\r",0.7*z/sz);
        Byte* b=ds(z);
        fcm(b,len,clust_c,U,C);
        int min=0;
        for(int j=1;j<clust_c;j++)
        {
            if(C[j]<C[min])
                min=j;
        }
        for(int i=0;i<len;i++)
        {
            double max=U[i*clust_c];
            int tmp;
            for(int j=1;j<clust_c;j++)
            {
                tmp=i*clust_c+j;
                if(U[tmp]>max)
                    max=U[tmp];
            }
            tmp=i*clust_c+min;
            b[i]=(U[tmp]==max)?255:0;
        }
        delete U;
        delete C;
    }
}

void erode(UDataset &ds)
{
    uint sx,sy,sz;
    ds.size(sx,sy,sz);
    double px,py,pz;
    ds.pixelSize(px,py,pz);
    UDataset ds2(sx,sy,sz);
    ds2.setPixelSize(px,py,pz);
    int mx=sx/35,my=sy/35,mz=sz/35;
    for(uint x=1;x<=sx;x+=2)
    {
        for(uint y=1;y<=sy;y+=2)for(uint z=1;z<=sz;z+=2)
        {
            if(ds(x,y,z))
            {
                bool good=true;
                for(int dx=-mx;dx<=mx;dx++)for(int dy=-my;dy<=my;dy++)for(int dz=-mz;dz<=mz;dz++)
                {
                    uint tx=x+dx,ty=y+dy,tz=z+dz;
                    if(tx<1||ty<1||tz<1||tx>sx||ty>sy||tz>sz)
                        continue;
                    if(ds(tx,ty,tz)==0)
                    {
                        good=false;
                        break;
                    }
                }
                if(good)
                {
                    for(int dx=-mx;dx<=mx;dx++)for(int dy=-my;dy<=my;dy++)for(int dz=-mz;dz<=mz;dz++)
                    {
                        uint tx=x+dx,ty=y+dy,tz=z+dz;
                        if(tx<1||ty<1||tz<1||tx>sx||ty>sy||tz>sz)
                            continue;
                        ds2(tx,ty,tz)=ds(tx,ty,tz);
                    }
                }
            }
        }
        printf("%f\r",0.7+0.3*x/sx);
    }
    //ds2.save("C:/Users/acer/Desktop/mrBone.urw");
    ds=ds2;
}

int main()
{
    UDataset ds("C:/Users/acer/Desktop/mr.urw");
    prepare(ds);
    dofcm(ds,4);
    erode(ds);
    ds.save("C:/Users/acer/Desktop/mrBone.urw");
    return 0;
}
