#include "uglview.h"
#include <QFile>
#include <QThread>
#include <QImage>
#include <QMessageBox>
#include <QTextCodec>
#include <QLabel>
UGLView::UGLView(QWidget *parent) :
    QGLWidget(parent)
{
    openFile="";
    opening=false;
    down=false;
    listLen=0;
    lighten=false;
}

void UGLView::initializeGL()
{
    glEnable(GL_BLEND);
    glDisable(GL_DEPTH_TEST);
    glEnable(GL_TEXTURE_2D);
    glClearColor(0,0,0,0);
    glBlendFunc(GL_SRC_ALPHA,GL_ONE);
    glEnableClientState(GL_VERTEX_ARRAY);
    glEnableClientState(GL_COLOR_ARRAY);
    listBase=glGenLists(2);
}

void UGLView::resizeGL(int wd,int ht)
{
    int px=0,py=0;
    float ps1=1.5*width()/w,ps2=1.5*height()/h;
    psize=(ps1>ps2)?ps2:ps1;
    if(w>0&&h>0)
    {
        float rat=(float)w/h,trat=(float)wd/ht;
        int tmp;
        if(trat>rat)
        {
            tmp=ht*rat;
            px=(wd-tmp)/2;
            wd=tmp;
        }else
        {
            tmp=wd/rat;
            py=(ht-tmp)/2;
            ht=tmp;
        }
    }
    glViewport(px,py,wd,ht);
}
class UOpenThread : public QThread
{
private:
    UGLView* v;
public:
    UOpenThread(UGLView* view)
    {
        v=view;
    }

    void run()
    {
        main();
        v->status="";
        v->opening=false;
    }

    void main()
    {
        QFile f(v->openFile);
        v->opening=false;
        v->status="Reading file";
        if(f.open(f.ReadOnly)){
            v->opening=true;
            QVector<float*> &map=v->map;
            map.clear();

            int &w=v->w,&h=v->h;
            {
                unsigned short _w,_h;
                f.read((char*)&_w,2);
                f.read((char*)&_h,2);
                w=_w;
                h=_h;
            }

            int len=w*h;
            v->dispStr="";
            if(len==0)
            {
                qDebug()<<"func";
                if(f.atEnd())
                {
                    f.close();
                    return;
                }
                f.read(1);
                QTextCodec *cc=QTextCodec::codecForLocale();
                while(!f.atEnd())
                    v->dispStr+=cc->toUnicode(f.readLine())+"\n";
                qDebug()<<v->dispStr;
                f.close();
                return;
            }
            char b;
            Byte min=255,max=10;
            int n=0;
            QVector<Byte*> box;
            float &prog=v->progress;
            while(f.read(&b,1)&&b>0)
            {
                if(prog<0.3)
                    prog+=0.001;
                Byte *img=new Byte[len+10];
                f.read((char*)img,len);
                for(int i=0;i<len;i++)
                {
                    if(img[i]>=10&&img[i]<min)
                    {
                        min=img[i];
                    }else if(img[i]>max)
                    {
                        max=img[i];
                    }
                    n++;
                }
                box.append(img);
            }
            bool mono=(min==max);
            if(mono)
                min=0;
            if(min>100)
                min=100;
            v->status="Analyzing data";
            int c=box.count();

            //make the vertex arrays
            float _w=(float)2/w,
                  _h=(float)2/h,
                  inc=2.0f/box.count();

            int &vSize=v->vertexLastSize;
            vSize=vertexListMax+1;
            float *coord,*color;
            n=0;
            for(int z=0;z<c;z++)
            {
                v->progress=0.3+0.4*z/c;
                Byte* img=box.at(z);
                for(int i=0;i<len;i++)
                {
                    Byte t=img[i];
                    if(t>min)
                    {
                        float col=(float)(t-min)/(max-min);
                        if(col>0.05)
                        {
                            n++;
                            if(vSize>=vertexListMax)
                            {
                                vSize=0;
                                v->vertexCoord.append((coord=new float[3*vertexListMax]));
                                v->vertexColor.append((color=new float[4*vertexListMax]));
                            }
                            const static int SHAKE=1000;
                            float rd=(qrand()%SHAKE/1.0f)/SHAKE;
                            coord[vSize*3]=_w*(i/h+rd/10)-1;
                            coord[vSize*3+1]=_h*(i%h+rd/10)-1;
                            coord[vSize*3+2]=inc*(z+rd)-1;
                            color[vSize*4]=color[vSize*4+1]=color[vSize*4+2]=1;
                            if(!mono)
                                col=col*inc*0.7;
                            else
                                col*=0.1;
                            if(col>1)
                                col=1;
                            color[vSize*4+3]=col;
                            vSize++;
                        }
                    }
                }
                delete[] img;
            }
            f.read(&b,1);
            f.close();
        }
    }
};

void UGLView::showUrw(QString path)
{
    openFile=path;
    UOpenThread* t=new UOpenThread(this);
    t->start();
    connect(t,SIGNAL(finished()),SLOT(doneReading()));
    QTimer tm;
    tm.setInterval(100);
    progress=0;
    tm.start();
    connect(&tm,SIGNAL(timeout()),SLOT(updateProg()));
    pdlg.setProgress(0);
    pdlg.exec();
}

void UGLView::updateProg()
{
    if(opening)
    {
        pdlg.setProgress(progress);
        pdlg.setWindowTitle(status);
    }else
    {
        ((QTimer*)sender())->stop();
    }
}

void UGLView::doneReading()
{
    delete sender();
    if(vertexCoord.empty())
    {
        if(!dispStr.isEmpty()){
            emit(setLbl(dispStr));
            hide();
            emit(doneGenerating());
        }
        pdlg.setProgress(2);
    }else{
        emit(setLbl(""));
        show();
        float r1=(float)w/width(),r2=(float)h/height();
        zoom=(r1>r2)?r2:r1;
        resizeGL(width(),height());
        updateGL();
    }
}

void UGLView::setLighten(bool b)
{
    lighten=b;
}

void UGLView::paintGL()
{
    glClear(GL_COLOR_BUFFER_BIT);
    bool raw=false;
    if(!opening&&!vertexCoord.empty())
    {
        generate();
    }else
        raw=view();
    glPushMatrix();
    glScalef(zoom,zoom,zoom);
    glPointSize(psize*zoom+pzoom);

    static uint s=0;
    if(down||raw)
        s=(s+1)%2;
    else
        s=100;

    int n=1;
    if(lighten)
        n+=5;
    if(listLen<10)
    {
        n+=(10-listLen)/5;
    }
    while(n--)
        for(uint i=0;i<listLen;i++)
        {
            glCallList(listBase+i);
        }
    glPopMatrix();
}

void UGLView::generate()
{
    static int total=0,cc;
    if(status.isEmpty())
    {
        glLoadIdentity();
        glRotatef(45,1,1,1);
        pdlg.setWindowTitle("Rendering image");
        status="r";
        total=vertexCoord.count();
        if(listLen>0)
        {
            glDeleteLists(listBase,listLen);
            listLen=0;
        }
        cc=total;
    }
    glNewList(listBase+listLen,GL_COMPILE);
    for(int i=0;cc>0&&i<30;i++)
    {
        glVertexPointer(3,GL_FLOAT,0,vertexCoord.last());
        glColorPointer(4,GL_FLOAT,0,vertexColor.last());

        int pc;
        if(cc==1)
        {
            pc=vertexLastSize;
        }else
            pc=vertexListMax;
        glDrawArrays(GL_POINTS,0,pc);
        delete[] vertexCoord.last();
        delete[] vertexColor.last();
        vertexCoord.pop_back();
        vertexColor.pop_back();
        cc--;
    }
    listLen++;
    glEndList();
    if(vertexCoord.empty()){
        emit(doneGenerating());
    }else
        QTimer::singleShot(0,this,SLOT(updateGL()));
    pdlg.setProgress(1.01-0.3*vertexCoord.count()/total);

}

void UGLView::mouseReleaseEvent(QMouseEvent* e)
{
    down=false;
    rotate=false;
    updateGL();
}

void UGLView::mousePressEvent(QMouseEvent *e)
{
    down=true;
    curr=prev=e->pos();
    rotate=(e->button()==Qt::RightButton);
}

void UGLView::mouseMoveEvent(QMouseEvent *e)
{
    if(down){
        curr=e->pos();
        updateGL();
    }
}

void UGLView::wheelEvent(QWheelEvent *e)
{
    int d=e->delta();
    if(e->modifiers()&Qt::ControlModifier)
    {
        if(d>0)
            pzoom+=0.1;
        else
            pzoom-=0.1;
        if(pzoom<-0.9)
            pzoom=-0.9;
    }else
    {
        if(d>0)
            zoom+=0.1;
        else
            zoom-=0.1;
        if(zoom<0.1)
            zoom=0.1;
    }
    updateGL();
}

#include<math.h>
bool UGLView::view()
{
    if(down&&curr!=prev){
        double alpha;
        QVector3D n;
        if(rotate)
        {
            n=QVector3D(0,0,1);
            QPoint mid(width()/2,height()/2);
            QLineF v1(mid,curr),v2(mid,prev);
            alpha=-v1.angleTo(v2);
        }else
        {
            QPoint l=curr-prev;
            n=QVector3D(l.y(),l.x(),0);
            float r1=(float)l.x()/width(),r2=(float)l.y()/height();
            alpha=sqrt(r1*r1+r2*r2);
            if(alpha<0.1)
                alpha*=100;
            else if(alpha<0.2)
                alpha*=120;
            else
                alpha*=180;
            alpha/=zoom;
        }
        prev=curr;
        double matv[16];
        glGetDoublev(GL_MODELVIEW_MATRIX,matv);
        n=n*QMatrix4x4(matv).inverted();
        glRotated(alpha,n.x(),n.y(),n.z());
        return true;
    }
    return false;
}
