#include "udlgholder.h"

UDlgHolder::UDlgHolder(QObject *parent) :
    QObject(parent)
{
}

UDlgHolder::~UDlgHolder()
{
    while(!list.empty())
    {
        delete list.first();
        list.pop_front();
    }
}

MainWindow* UDlgHolder::openNewDlg()
{
    MainWindow* wnd=new MainWindow;
    list.append(wnd);
    wnd->show();
    connect(wnd,SIGNAL(newDlg()),SLOT(openNewDlg()));
    return wnd;
}
