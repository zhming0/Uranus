#include "UDataset.h"
#include "UList.h"
#include <stdio.h>
#include <stdlib.h>
#include <memory.h>

UDataset::UDataset()
{
    map=0;
    sx=sy=sz=0;
    psx=psy=psz=0;
}

UDataset::UDataset(UDataset& other)
{
    operator =(other);
}

UDataset& UDataset::operator =(UDataset& other)
{
    this->~UDataset();
    other.size(sy,sx,sz);
    other.pixelSize(psx,psy,psz);
    uint len=sx*sy;
    if(len>0)
    {
        map=new Byte*[sz];
        Byte* tmp;
        for(uint i=0;(tmp=other(i+1))>0;i++)
        {
            map[i]=new Byte[len];
            memcpy(map[i],tmp,len);
        }
    }else
    {
        map=0;
        sx=sy=sz=0;
        psx=psy=psz=0;
    }
    return *this;
}

UDataset::UDataset(char const* fname)
{
    map=0;
    sx=sy=sz=0;
    psx=psy=psz=0;
    FILE *fp=fopen(fname,"rb");
    if(fp==0)
    {
        return;
    }
    unsigned short cx,cy;
    fread(&cx,sizeof(short),1,fp);
    fread(&cy,sizeof(short),1,fp);
    sx=cx;
    sy=cy;
    Byte flag=1;
    size_t len=sx*sy;
    map=0;
    if(len>0)
    {
        UList list;
        sz=0;
        while(fread(&flag,1,sizeof(char),fp)&&flag==1)
        {
            Byte* ins=new Byte[len];
            list.append(ins);
            size_t rem=len;
            while(rem>0)
            {
                if(rem>512)
                {
                    fread(ins,1,512,fp);
                    ins+=512;
                    rem-=512;
                }else{
                    fread(ins,sizeof(char),rem,fp);
                    rem=0;
                }
            }
            sz++;
        }
        fread(&psx,sizeof(double),1,fp);
        fread(&psy,sizeof(double),1,fp);
        fread(&psz,sizeof(double),1,fp);
        map=new Byte*[sz];

        for(uint i=0;i<sz;i++){
            map[i]=(Byte*)list.front();
            list.pop_front();
        }
    }
    fclose(fp);
}

UDataset::UDataset(uint cx,uint cy,uint cz)
{
    sx=cx;
    sy=cy;
    sz=cz;
    psx=psy=psz=1;
    uint len=sx*sy;
    if(len>0)
    {
        map=new Byte*[sz];
        for(uint i=0;i<sz;i++)
        {
            static Byte* tmp;
            tmp=new Byte[len];
            map[i]=tmp;
            for(uint j=0;j<len;j++)
                tmp[j]=0;
        }
    }
}

UDataset::~UDataset()
{
    if(map!=0)
    {
        for(uint i=0;i<sz;i++)
        {
            delete[] map[i];
        }
        delete[] map;
    }
}

void UDataset::size(uint& x,uint& y,uint& z)
{
    x=sx;y=sy;z=sz;
}

void UDataset::pixelSize(double& x,double& y,double& z)
{
    x=psx;y=psy;z=psz;
}

void UDataset::setPixelSize(double x,double y,double z)
{
    psx=x;psy=y;psz=z;
}

Byte*& UDataset::operator()(uint z)
{
    if(z<1||z>sz)
    {
        static Byte* nan;
        nan=0;
        return nan;
    }
    return map[z-1];
}

Byte& UDataset::operator()(uint x,uint y,uint,uint z)
{
    return operator()(x,y,z);
}

Byte& UDataset::operator()(uint x,uint y,uint z)
{
    if(map==0||x<1||y<1||z<1||x>sx||y>sy||z>sz)
    {
        static Byte bad;
        bad=0;
        return bad;
    }
    return map[z-1][(x-1)*sy+y-1];
}

bool UDataset::save(char const* fname)
{
    uint len=sx*sy;
    if(len==0)
        return false;
    FILE* fp=fopen(fname,"wb");
    if(fp==0)
        return false;
    unsigned short tmp;
    tmp=sx;
    fwrite(&tmp,1,2,fp);
    tmp=sy;
    fwrite(&tmp,1,2,fp);
    for(uint z=0;z<sz;z++)
    {
        fputc(1,fp);
        uint rem=len;
        Byte* cur=map[z];
        while(rem>0)
        {
            if(rem>512)
            {
                rem-=fwrite(cur,1,512,fp);
                cur+=512;
            }else
            {
                fwrite(cur,1,rem,fp);
                rem=0;
            }
        }
    }
    fputc(0,fp);
    fwrite(&psx,sizeof(double),1,fp);
    fwrite(&psy,sizeof(double),1,fp);
    fwrite(&psz,sizeof(double),1,fp);
    fclose(fp);
    return true;
}

UDataset UDataset::operator +(UDataset& other)
{
    UDataset ret(other);
    uint ox,oy,oz;
    ret.size(ox,oy,oz);
    uint len=sx*sy;
    if(sx==ox&&sy==oy&&sz==oz&&len>0)
    {
        for(uint z=0;z<sz;z++)
        {
            for(uint i=0;i<len;i++)
                ret(z+1)[i]+=map[z][i];
        }
    }
    return ret;
}

UDataset UDataset::operator -(UDataset& other)
{
    UDataset ret(other);
    uint ox,oy,oz;
    ret.size(ox,oy,oz);
    uint len=sx*sy;
    if(sx==ox&&sy==oy&&sz==oz&&len>0)
    {
        for(uint z=0;z<sz;z++)
        {
            for(uint i=0;i<len;i++)
                ret(z+1)[i]=map[z][i]-ret(z+1)[i];
        }
    }
    return ret;
}
