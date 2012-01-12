#include "uprocessitem.h"
#include "uprocessitemmodify.h"
#include "processtool.h"

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
    setText(path.split(QRegExp("[\\\\\\/]")).last()+" - "+args);
}

void UProcessItem::modify()
{
    UProcessItemModify dlg(path,args);
    if(dlg.exec()==QDialog::Accepted)
    {
        args=dlg.args;
        path=dlg.path;
        updateText();
    }
}

bool UProcessItem::process(QProcess*& ret,QString& inFile,QString& outFile)
{
    if(processed)
        return false;

    ret=new QProcess;
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
    if(p->canReadLine())
    {
        bool ok;
        QString str=p->readLine();
        if(argSent)
        {
            float p=str.toFloat(&ok);
            if(ok)
            {
                ProcessTool* tool=(ProcessTool*)listWidget()->parentWidget();
                tool->setProgress(p);
            }
        }else
        {
            int c=str.toInt(&ok);
            if(ok)
            {
                argSent=true;
                args=args.trimmed();
                p->write(args.toAscii());
                int n;
                if(args.isEmpty())
                    n=-1;
                else
                {
                    QRegExp reg("\\b+");
                    reg.indexIn(args);
                    n=reg.captureCount();
                }
                c=c-n;
                while(c>1)
                {
                    p->write(" -inf");
                    c--;
                }
                p->write("\n");
            }

        }
    }
}
