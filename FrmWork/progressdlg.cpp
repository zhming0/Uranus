#include "progressdlg.h"
#include "ui_progressdlg.h"
#include "sharedmemory.h"

ProgressDlg::ProgressDlg(QDialog *parent) :
        QDialog(parent,Qt::Tool|Qt::WindowStaysOnTopHint),
    ui(new Ui::ProgressDlg)
{
    ui->setupUi(this);
    ui->progressBar->setValue(0);
}

ProgressDlg::~ProgressDlg()
{
    delete ui;
}

void ProgressDlg::setProgress(float progress)
{
    if(progress>=1)
        close();
    ui->progressBar->setValue(progress*100);
}
