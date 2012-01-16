#include "uprocessitem.h"
#include "uprocessitemmodify.h"
#include "processtool.h"
#include "mainwindow.h"
#include <QInputDialog>

UProcessItem::UProcessItem(QString file,QObject* parent):
    QObject(parent)
{
    path=file;
    setIcon(QIcon(":/icons/gray.png"));
    processed=false;
    updateText();
}

void UProcessItem::updateText()
{
    setText(path.split(QRegExp("[\\\\\\/]")).last());
}

void UProcessItem::modify()
{
    UProcessItemModify dlg(path);
    if(dlg.exec()==QDialog::Accepted)
    {
        path=dlg.path;
        updateText();
        dlg.close();        //Click ok, than dlg should be close
    }
}

bool UProcessItem::process(QProcess*& ret,QString& inFile,QString& outFile)
{
    if(processed)
        return false;

    ret=new QProcess;

    #if defined(__APPLE__) || defined(MACOSX)
    if (path[0]!='/')           //Fix path bug for mac os
        path.prepend("/");
    #endif

    ret->start(path);
    setIcon(QIcon(":/icons/red.png"));
    if(ret->waitForStarted())
    {
        QString cmd="'"+inFile+"'\n'"+outFile+"'\n";
        ret->write(cmd.toAscii());
        argSent=false;
        connect(ret,SIGNAL(readyRead()),SLOT(request()));
    }else
    {
        QMessageBox::critical(0,"Error",ret->errorString());
        setIcon(QIcon(":/icons/gray.png"));
        delete ret;
        ret=0;
    }
    return true;
}

void UProcessItem::setProcessed(bool b)
{
    processed=b;
    if(b)
        setIcon(QIcon(":/icons/green.png"));
    else
        setIcon(QIcon(":/icons/gray.png"));
}

void UProcessItem::request()
{
    QProcess *p=(QProcess *)sender();
    while(p->canReadLine())
    {
        bool ok;
        QString cmd=p->readLine();
        if(cmd.left(2)=="''")
        {
            switch(cmd.at(2).toAscii())
            {
                case 'i':
                {
                    QStringList prompt=cmd.mid(4).split('\'');
                    if(prompt.length()<3)
                        continue;
                    QString ret,def=prompt[2];
                    if(prompt[1]=="s")
                    {
                        ret=QInputDialog::getText(0,"Prompt",prompt[0],QLineEdit::Normal,def,&ok);
                        def="'"+def.replace('\'',"''")+"'";
                        ret="'"+ret.replace('\'',"''")+"'";
                    }else
                    {
                        double num=def.toDouble(&ok);
                        if(!ok)
                            continue;
                        ret=ret.number(QInputDialog::getDouble(0,"Prompt",prompt[0],num,-2147483647,2147483647,1,&ok));
                    }
                    if(!ok)
                    {
                        ret=def;
                    }
                    ret+=+"\n";
                    p->write(ret.toAscii());
                    break;
                }
                case 'p':
                {
                    float prog=cmd.mid(4).toFloat(&ok);
                    if(!ok)
                        continue;
                    ProcessTool* pt=(ProcessTool*)this->listWidget()->parentWidget();
                    pt->setProgress(prog);
                    break;
                }
                default:
                    emit(log(cmd));
            }
        }else
        {
            emit(log(cmd));
        }
    }
}
