#ifndef UPROCESSITEM_H
#define UPROCESSITEM_H

#include <QListWidgetItem>
#include <QProcess>
#include <QMessageBox>
#include <QObject>

class UProcessItem : public QObject,public QListWidgetItem
{
    Q_OBJECT
public:
    UProcessItem(QString,QObject* parent=0);
    void modify();
    bool process(QProcess*&,QString&,QString&);
    void setProcessed(bool);
    QString path;
    void updateText();
private:
    bool processed,argSent;
private slots:
    void request();
signals:
    void log(QString);
};

#endif // UPROCESSITEM_H
