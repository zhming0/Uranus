#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QResizeEvent>
#include <QFileDialog>
#include <QFile>
#include <time.h>
#include <QScrollBar>
#include "sharedmemory.h"

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    connect(ui->actionOpen,SIGNAL(triggered()),SLOT(openFile()));
    connect(ui->actionNew_Window,SIGNAL(triggered()),SIGNAL(newDlg()));
    connect(ui->disp,SIGNAL(doneGenerating()),SLOT(doneOpening()));
    connect(ui->disp,SIGNAL(setLbl(QString)),SLOT(setLbl(QString)));
    connect(ui->processToolContent,SIGNAL(log(QString)),SLOT(dispLog(QString)));
    connect(ui->hintContents,SIGNAL(changed(QStringList)),ui->disp,SLOT(setHint(QStringList)));
    dispLog("<b>''Welcome!''</b>");

    ui->lbl->hide();
    view=ui->disp;

    ui->actionStop->setEnabled(false);
    cproc=0;

    setWindowIcon(QIcon(":/icons/icon.png"));

    outFile=QDir(QDir::currentPath()).absoluteFilePath(QString().sprintf("temp_%ld.urw",time(0)));
    ui->processToolContent->setOutFile(outFile);
    ui->actionSave->setEnabled(false);
}

MainWindow::~MainWindow()
{
    delete ui;
    QFile::remove(outFile);
}

void MainWindow::openFile()
{
    if(!view->opening)
    {
        if(openingFile.isEmpty())
            openingFile=QFileDialog::getOpenFileName(this,"Choose an URW File","","URW File (*.urw)");
        if(!openingFile.isEmpty())
        {
            openingFileL=openingFile;
            view->showUrw(openingFile);
        }
    }
    openingFile="";
}

void MainWindow::doneOpening()
{
    inFile=openingFileL;
    ui->actionSave->setEnabled(true);
    ui->processToolContent->setInFile(inFile);
    setTitle(openingFileL.split(QRegExp("[\\\\\\/]")).last());
}

void MainWindow::on_actionRun_triggered()
{
    QProcess* p=ui->processToolContent->process();
    if(p)
    {
        ui->actionRun->setEnabled(false);
        ui->actionStop->setEnabled(true);
        connect(p,SIGNAL(error(QProcess::ProcessError)),SLOT(processError(QProcess::ProcessError)));
        connect(p,SIGNAL(finished(int)),SLOT(processDone(int)));
        connect(p,SIGNAL(aboutToClose()),SLOT(cleanProc()));
        cproc=p;
    }
}

void MainWindow::cleanProc()
{
    disconnect(cproc,0,0,0);
    cproc->deleteLater();
}

void MainWindow::on_actionStop_triggered()
{
    if(cproc)
    {
        cproc->kill();
    }
}

void MainWindow::processError(QProcess::ProcessError e)
{
    QMessageBox::critical(0,"Error",cproc->errorString());
    ui->actionRun->setEnabled(true);
    ui->actionStop->setEnabled(false);
    disconnect((QProcess*)sender(),SIGNAL(finished(int)),this,SIGNAL(processDone(int)));
}

void MainWindow::processDone(int)
{
    ui->actionRun->setEnabled(true);
    ui->actionStop->setEnabled(false);
    cleanProc();
    openingFile=outFile;
    openFile();
}

void MainWindow::setTitle(QString tt)
{
    static QString str;
    if(str.isEmpty())
        str=windowTitle();
    setWindowTitle(tt+" - "+str);
}

void MainWindow::dispLog(QString str)
{
    QScrollBar *scr=ui->logText->horizontalScrollBar();
    bool scroll=(scr->value()>=scr->maximum());
    ui->logText->append(str);
    if(scroll)
        scr->setValue(scr->maximum());
}

void MainWindow::setLbl(QString str)
{
    if(str.isEmpty())
        ui->lbl->hide();
    else
    {
        ui->lbl->setText(str);
        ui->lbl->show();
    }
}

void MainWindow::dragEnterEvent(QDragEnterEvent *e)
{
    if(e->mimeData()->hasUrls())
    {
        e->acceptProposedAction();
    }
}

void MainWindow::dropEvent(QDropEvent *e)
{
    if(e->mimeData()->hasUrls())
    {
        QString urls=e->encodedData("text/uri-list");
        bool urw=false,lst=false;
        QStringList list=urls.split('\n');
        ProcessTool* tool=ui->processToolContent;
        tool->addList.clear();
        foreach(QString url,list)
        {
            if(url.isEmpty())
                continue;
            url=url.trimmed().split("///").last();
            url=QUrl::fromEncoded(url.toAscii()).toString();
            int pos=url.lastIndexOf('.');
            QString ext=(pos==-1)?"":url.mid(pos+1);
            if(ext=="urw")
            {
                if(urw)
                    continue;
                urw=true;
                openingFile=url;
                QTimer::singleShot(10,this,SLOT(openFile()));
            }else if(ext=="lst")
            {
                if(lst)
                    continue;
                lst=true;
                ui->processToolContent->openingList=url;
                QTimer::singleShot(10,ui->processToolContent,SLOT(on_actionOpen_List_triggered()));
            }else if(!lst)
            {
                tool->addList.append(url);
            }
        }
        if(!tool->addList.isEmpty())
            QTimer::singleShot(0,tool,SLOT(on_actionAdd_triggered()));
    }
}

void MainWindow::on_actionSave_triggered()
{
    if(inFile.isEmpty())
        return;
    QString file=QFileDialog::getSaveFileName(0,"Save the current urw","","URW File (*.urw)");
    if(!file.isEmpty())
    {
        QFile::remove(file);
        QFile::copy(inFile,file);
    }
}

void MainWindow::on_actionLit_up_the_image_toggled(bool b)
{
    ui->disp->setLighten(b);
    ui->disp->updateGL();
}

void MainWindow::on_actionClose_Window_triggered()
{
    close();
}

void MainWindow::on_actionClear_Log_triggered()
{
    ui->logText->clear();
}

void MainWindow::on_actionShow_Frame_triggered(bool b)
{
    ui->disp->showFrame=b;
    ui->disp->updateGL();
}

void MainWindow::on_action2nd_Blend_Method_triggered(bool b)
{
    ui->disp->blend2=b;
    ui->disp->updateGL();
}
