#ifndef UGLVIEW_H
#define UGLVIEW_H

#include <QGLWidget>
#include <QVector>
#include <QVector3D>
#include <QMatrix4x4>
#include <QMouseEvent>
#include <QWheelEvent>
#include "progressdlg.h"


typedef unsigned char Byte;
class UGLView : public QGLWidget
{
    Q_OBJECT
public:
    explicit UGLView(QWidget *parent = 0);
    void showUrw(QString path);
    bool opening;
    void setPrev(int x,int y);
    void setCurr(int x,int y);
    void setLighten(bool);
private:
    ProgressDlg pdlg;
    bool lighten;
    friend class UOpenThread;
    void initializeGL();
    void paintGL();
    void resizeGL(int w,int h);
    void generate();
    QString openFile;
    void mousePressEvent(QMouseEvent *e);
    void mouseMoveEvent(QMouseEvent *);
    void mouseReleaseEvent(QMouseEvent* e);
    void wheelEvent(QWheelEvent *);
    bool down;
    bool rotate;

    QVector<float*> map;
    int w,h,sw,sh;
    QPoint prev,curr;
    GLuint listBase,listLen;
    GLfloat psize,pzoom,zoom;
    bool view();
    QVector<float*> vertexCoord,vertexColor;
    int vertexLastSize;
#define vertexListMax 1000

    QString status;
    float progress;
public slots:
    void doneReading();
    void updateProg();
signals:
    void doneGenerating();
};

#endif // UGLVIEW_H
