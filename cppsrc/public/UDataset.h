#ifndef URANUS_DATASET_INC
#define URANUS_DATASET_INC

#include "common.h"

class UDataset
{
public:
    UDataset();
    UDataset(uint,uint,uint);
    UDataset(UDataset&);
    UDataset(char const *);
    ~UDataset();
    Byte& operator()(uint,uint,uint,uint);
    Byte& operator()(uint,uint,uint);
    Byte*& operator()(uint);
    UDataset operator +(UDataset&);
    UDataset operator -(UDataset&);
    UDataset& operator =(UDataset&);
    void size(unsigned int&,unsigned int&,unsigned int&);
    void pixelSize(double&,double&,double&);
    bool save(char const *);
    void setPixelSize(double,double,double);
private:
    Byte **map;
    unsigned int sx,sy,sz;
    double psx,psy,psz;
};

#endif
