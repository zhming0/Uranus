#ifndef HINTDLG_H
#define HINTDLG_H

#include <QDialog>

namespace Ui {
    class HintDlg;
}

class HintDlg : public QDialog
{
    Q_OBJECT

public:
    explicit HintDlg(QWidget *parent = 0);
    ~HintDlg();
    QColor color;
    QString param;
    int exec();

private:
    Ui::HintDlg *ui;

private slots:
    void on_ok_clicked();
    void on_colorBtn_clicked();
public slots:
};

#endif // HINTDLG_H
