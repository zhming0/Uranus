#include <stdlib.h>
typedef unsigned char Byte;

inline double abs(double n)
{
    return (n<0)?-n:n;
}

double* distfcm(Byte* data,int len,double* center,int count)
{
    double* dist=new double[len*count];
    for(int j=0;j<count;j++)
    {
        for(int i=0;i<len;i++)
        {
            int tmp=i*count+j;
            dist[tmp]=abs(data[i]-center[j]);
        }
    }
    return dist;
}

double stepfcm(Byte* data,int len,double* U,int count,double *center)
{
    for(int j=0;j<count;j++)
    {
        double s=0;
        for(int i=0;i<len;i++)
        {
            int tmp=i*count+j;
            U[tmp]*=U[tmp];
            s+=U[tmp];
        }
        double n=0;
        for(int i=0;i<len;i++)
        {
            int tmp=i*count+j;
            n+=U[tmp]*data[i];
        }
        center[j]=n/s;
    }

    double* dist=distfcm(data,len,center,count);
    //delete[] center;
    for(int i=0;i<len;i++)
    {
        double s=0;
        for(int j=0;j<count;j++)
        {
            int tmp=i*count+j;
            U[tmp]=1/(dist[tmp]*dist[tmp]);
            s+=U[tmp];
        }
        for(int j=0;j<count;j++)
        {
            int tmp=i*count+j;
            U[tmp]/=s;
        }
    }
    double ret=0;
    for(int i=0;i<len;i++)for(int j=0;j<count;j++)
    {
        int tmp=i*count+j;
        ret+=U[tmp]*dist[tmp]*dist[tmp];
    }
    delete[] dist;
    return ret;
}

void fcm(Byte* data,int len,int count,double*& U,double*& center)
{
    U=new double[len*count];
    for(int i=0;i<len;i++)
    {
        double s=0;
        for(int j=0;j<count;j++)
        {
            int tmp=i*count+j;
            U[tmp]=1.0*rand()/RAND_MAX;
            s+=U[tmp];
        }
        for(int j=0;j<count;j++)
        {
            int tmp=i*count+j;
            U[tmp]/=s;
        }
    }
    center=new double[count];
    for(int m=0;m<100;m++)
    {
        if(stepfcm(data,len,U,count,center)<0.00001)
            break;
    }
}
