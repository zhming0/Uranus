#include "hintdlg.h"
#include "ui_hintdlg.h"
#include <QColorDialog>
#include <QDebug>

HintDlg::HintDlg(QWidget *parent) :
        QDialog(parent,Qt::Tool),
    ui(new Ui::HintDlg)
{
    ui->setupUi(this);
    color=QColor(0,255,0);
    param="";
}

HintDlg::~HintDlg()
{
    delete ui;
}

void HintDlg::on_colorBtn_clicked()
{
    QColor color=QColorDialog::getColor();//getRgba(0xFF0000,&ok);
    if(color.isValid())
    {
        this->color=color;
        QString col;
        col.sprintf("%x",color.rgb());
        col=col.mid(2);
        ui->colorBtn->setStyleSheet("border:2px solid black;background:#"+col);
    }
}

void HintDlg::on_ok_clicked()
{
    param=ui->lineEdit->text();
    accept();
}

int HintDlg::exec()
{
    QString col;
    col.sprintf("%x",color.rgb());
    col=col.mid(2);
    ui->colorBtn->setStyleSheet("border:2px solid black;background:#"+col);
    ui->lineEdit->setText(param);
    return QDialog::exec();
}
