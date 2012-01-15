#include "uprocessitemmodify.h"
#include "ui_uprocessitemmodify.h"
#include <QFileDialog>

UProcessItemModify::UProcessItemModify(QString path,QDialog *parent) :
        QDialog(parent,Qt::Tool),
    ui(new Ui::UProcessItemModify)
{
    ui->setupUi(this);
    ui->filePath->setText(path);
}

UProcessItemModify::~UProcessItemModify()
{
    delete ui;
}

void UProcessItemModify::on_ok_clicked()
{
    path=ui->filePath->text();
    this->accept();
}

void UProcessItemModify::on_cancel_clicked()
{
    close();
}

void UProcessItemModify::on_fileBtn_clicked()
{
    path=QFileDialog::getOpenFileName(0,"Open a process executable");
    if(!path.isEmpty())
        ui->filePath->setText(path);
}
