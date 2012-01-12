#ifndef UDLGHOLDER_H
#define UDLGHOLDER_H

#include <QObject>
#include <QVector>
#include "mainwindow.h"

class UDlgHolder : public QObject
{
    Q_OBJECT
public:
    explicit UDlgHolder(QObject *parent = 0);
    ~UDlgHolder();
private:
    QVector<MainWindow*> list;
signals:

public slots:
    MainWindow* openNewDlg();
};

#endif // UDLGHOLDER_H
