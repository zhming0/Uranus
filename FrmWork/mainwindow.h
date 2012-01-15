#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QProcess>
#include <QDropEvent>
#include <QDragEnterEvent>
#include "uglview.h"

namespace Ui {
    class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    explicit MainWindow(QWidget *parent = 0);
    ~MainWindow();
    UGLView* view;
    void setTitle(QString);
    friend int main(int,char**);
private:
    Ui::MainWindow *ui;
    QProcess* cproc;
    QString openingFile,openingFileL,inFile,outFile;
private slots:
    void on_actionClear_Log_triggered();
    void on_actionClose_Window_triggered();
    void on_actionLit_up_the_image_toggled(bool );
    void on_actionSave_triggered();
    void cleanProc();
    void on_actionStop_triggered();
    void on_actionRun_triggered();
    void openFile();
    void processError(QProcess::ProcessError);
    void processDone(int);
    void dragEnterEvent(QDragEnterEvent *);
    void dropEvent(QDropEvent *);
    void doneOpening();
    void setLbl(QString);
    void dispLog(QString);
signals:
    void newDlg();
};

#endif // MAINWINDOW_H
