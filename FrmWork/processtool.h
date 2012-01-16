#ifndef PROCESSTOOL_H
#define PROCESSTOOL_H

#include <QWidget>
#include <QDropEvent>
#include "uprocessitem.h"
#include <QMenu>

namespace Ui {
    class ProcessTool;
}

/*
    This class provided ui for process area.
*/

class ProcessTool : public QWidget
{
    Q_OBJECT

public:
    explicit ProcessTool(QWidget *parent = 0);
    ~ProcessTool();
    QProcess* process();
    QStringList addList;
    void setProgress(float);
    void setInFile(QString);
    void setOutFile(QString);
    QString openingList;
private:
    QMenu menu;
    QString inFile,outFile;
    Ui::ProcessTool *ui;
    int pointingItem;
    UProcessItem* processing;
public slots:
    void on_actionAdd_triggered();
private slots:
    void on_actionOpen_List_triggered();
    void on_actionSave_List_triggered();
    void on_actionMark_as_unprocessed_triggered();
    void on_actionEmpty_triggered();
    void on_actionModify_triggered();
    void on_list_doubleClicked(QModelIndex index);
    void on_actionDelete_triggered();
    void on_list_customContextMenuRequested(QPoint pos);
    void processError(QProcess::ProcessError);
    void processDone(int);
signals:
    void log(QString);
};

#endif // PROCESSTOOL_H
