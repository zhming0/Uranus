#include "processtool.h"
#include "ui_processtool.h"
#include <QTableWidgetItem>
#include <QFileDialog>

ProcessTool::ProcessTool(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::ProcessTool)
{
    ui->setupUi(this);
    ui->progressBar->hide();
}

void ProcessTool::setInFile(QString file)
{
    inFile=file;
}

void ProcessTool::setOutFile(QString file)
{
    outFile=file;
}

ProcessTool::~ProcessTool()
{
    delete ui;
}

QProcess* ProcessTool::process()
{
    QProcess* ret=0;
    for(int i=0,c=ui->list->count();i<c;i++)
    {
        processing=dynamic_cast<UProcessItem*>(ui->list->item(i));
        if(processing->process(ret,inFile,outFile))
        {
            if(ret)
            {
                connect(ret,SIGNAL(error(QProcess::ProcessError)),SLOT(processError(QProcess::ProcessError)));
                connect(ret,SIGNAL(finished(int)),SLOT(processDone(int)));
                ui->list->setEnabled(false);
                ui->progressBar->setValue(0);
                ui->progressBar->show();
            }else
                return 0;
            break;
        }else
            ret=0;
    }

    if(ret==0)
        QMessageBox::information(0,"Notice","Nothing can be processed");
    return ret;
}

void ProcessTool::processDone(int)
{
    processing->setProcessed(true);
    ui->list->setEnabled(true);
    ui->progressBar->hide();
}

void ProcessTool::processError(QProcess::ProcessError)
{
    disconnect((QProcess*)sender(),SIGNAL(finished(int)),this,SLOT(processDone(int)));
    processing->setProcessed(false);
    ui->list->setEnabled(true);
    ui->progressBar->hide();
}

void ProcessTool::on_list_customContextMenuRequested(QPoint pos)
{
    if(menu.isEmpty())
    {
        menu.addAction(ui->actionAdd);
        menu.addAction(ui->actionModify);
        menu.addAction(ui->actionDelete);
        menu.addAction(ui->actionMark_as_unprocessed);
        menu.addSeparator();
        menu.addAction(ui->actionOpen_List);
        menu.addAction(ui->actionSave_List);
        menu.addSeparator();
        menu.addAction(ui->actionEmpty);
    }
    bool nempty=(ui->list->count()>0);
    ui->actionSave_List->setEnabled(nempty);
    ui->actionEmpty->setEnabled(nempty);
    if(ui->list->itemAt(pos))
    {
        pointingItem=ui->list->currentRow();
    }else
    {
        pointingItem=-1;
    }
    bool pnt=(pointingItem>-1);
    ui->actionModify->setEnabled(pnt);
    ui->actionDelete->setEnabled(pnt);
    ui->actionMark_as_unprocessed->setEnabled(pnt);
    menu.move(ui->list->mapToGlobal(pos));
    menu.show();
}

void ProcessTool::on_actionAdd_triggered()
{
    int i=pointingItem;
    if(i==-1)
        i=ui->list->count();
    if(addList.isEmpty())
        addList=QFileDialog::getOpenFileNames(0,"Open an executable process module");
    foreach(QString file,addList)
    {
        UProcessItem* item=new UProcessItem(file,this);
        ui->list->insertItem(i++,item);
        connect(item,SIGNAL(log(QString)),SIGNAL(log(QString)));
    }
    addList.clear();
}

void ProcessTool::on_actionDelete_triggered()
{
    delete ui->list->takeItem(pointingItem);
}

void ProcessTool::on_actionModify_triggered()
{
    UProcessItem* item=dynamic_cast<UProcessItem*>(ui->list->item(pointingItem));
    if(item)
    {
        item->modify();
    }
}

void ProcessTool::on_list_doubleClicked(QModelIndex index)
{
    int i=index.row();
    if(i==-1)
        return;
    UProcessItem* item=dynamic_cast<UProcessItem*>(ui->list->item(i));
    if(item)
    {
        item->modify();
    }
}

void ProcessTool::on_actionEmpty_triggered()
{
    ui->list->clear();
}

void ProcessTool::on_actionMark_as_unprocessed_triggered()
{
    UProcessItem* item=dynamic_cast<UProcessItem*>(ui->list->item(pointingItem));
    if(item)
    {
        item->setProcessed(false);
    }
}

void ProcessTool::setProgress(float prog)
{
    if(prog>=1)
        ui->progressBar->hide();
    else
        ui->progressBar->show();
    ui->progressBar->setValue(prog*100);
}

void ProcessTool::on_actionSave_List_triggered()
{
    QString f=QFileDialog::getSaveFileName(0,"Save the process list","","List (*.lst)");
    if(!f.isEmpty())
    {
        QFile file(f);
        if(file.open(QFile::WriteOnly))
        {
            for(int i=0,c=ui->list->count();i<c;i++)
            {
                UProcessItem* item=(UProcessItem*)ui->list->item(i);
                file.write((item->path+"\n").toUtf8());
            }
        }
    }
}

void ProcessTool::on_actionOpen_List_triggered()
{
    if(openingList.isEmpty())
        openingList=QFileDialog::getOpenFileName(0,"Open a process list","","List (*.lst)");
    if(!openingList.isEmpty())
    {
        QFile file(openingList);
        if(file.open(QFile::ReadOnly))
        {
            ui->list->clear();
            while(!file.atEnd())
            {
                UProcessItem* item=new UProcessItem(QString::fromUtf8(file.readLine().trimmed()));
                connect(item,SIGNAL(log(QString)),SIGNAL(log(QString)));
                item->updateText();
                ui->list->addItem(item);
            }
        }
    }
    openingList="";
}
