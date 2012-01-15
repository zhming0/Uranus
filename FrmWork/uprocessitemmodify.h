#ifndef UPROCESSITEMMODIFY_H
#define UPROCESSITEMMODIFY_H

#include <QDialog>

namespace Ui {
    class UProcessItemModify;
}

class UProcessItemModify : public QDialog
{
    Q_OBJECT
public:
    explicit UProcessItemModify(QString path,QDialog *parent = 0);
    ~UProcessItemModify();
    operator bool();
    QString path;
private:
    Ui::UProcessItemModify *ui;
    bool isOk;

private slots:
    void on_fileBtn_clicked();
    void on_cancel_clicked();
    void on_ok_clicked();
};

#endif // UPROCESSITEMMODIFY_H
