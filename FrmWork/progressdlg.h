#ifndef PROGRESSDLG_H
#define PROGRESSDLG_H

#include <QDialog>
#include <QTimer>

namespace Ui {
    class ProgressDlg;
}

class ProgressDlg : public QDialog
{
    Q_OBJECT

public:
    explicit ProgressDlg(QDialog *parent = 0);
    ~ProgressDlg();
    void setProgress(float);
private:
    Ui::ProgressDlg *ui;
};

#endif // PROGRESSDLG_H
