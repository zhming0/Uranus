#include <QtGui/QApplication>
#include "udlgholder.h"

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    UDlgHolder h;
    MainWindow* wnd=h.openNewDlg();
    if(argc>1)
    {
        wnd->openingFile=argv[1];
        wnd->openFile();
    }
    return a.exec();
}
