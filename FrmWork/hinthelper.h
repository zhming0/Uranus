#ifndef HINTHELPER_H
#define HINTHELPER_H

#include <QWidget>
#include <QMenu>
#include <QListWidgetItem>

namespace Ui {
    class hintHelper;
}

class hintHelper : public QWidget
{
    Q_OBJECT

public:
    explicit hintHelper(QWidget *parent = 0);
    ~hintHelper();
    QMenu menu;
private:
    Ui::hintHelper *ui;
    QListWidgetItem* menuItem;
    void refresh();

private slots:
    void on_list_itemChanged(QListWidgetItem* item);
    void on_actionRemove_Hint_triggered();
    void on_list_itemDoubleClicked(QListWidgetItem* item);
    void on_actionEdit_hint_triggered();
    void on_actionAdd_hint_triggered();
    void on_actionClear_triggered();
    void on_list_customContextMenuRequested(QPoint pos);
signals:
    void changed(QStringList);
};

#endif // HINTHELPER_H
