#include "hinthelper.h"
#include "ui_hinthelper.h"
#include "hintdlg.h"

hintHelper::hintHelper(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::hintHelper)
{
    ui->setupUi(this);
    QPixmap p(16,16);
    p.fill(qRgb(255,0,0));
    menu.addAction(ui->actionAdd_hint);
    menu.addAction(ui->actionRemove_Hint);
    menu.addAction(ui->actionEdit_hint);
    menu.addSeparator();
    menu.addAction(ui->actionClear);
}

hintHelper::~hintHelper()
{
    delete ui;
}

void hintHelper::on_list_customContextMenuRequested(QPoint pos)
{
    ui->actionClear->setEnabled(ui->list->count()>0);
    menuItem=ui->list->itemAt(pos);
    bool itm=menuItem!=0;
    ui->actionRemove_Hint->setEnabled(itm);
    menu.move(ui->list->mapToGlobal(pos));
    menu.show();
}

void hintHelper::on_actionClear_triggered()
{
    ui->list->clear();
    refresh();
}

void hintHelper::on_actionAdd_hint_triggered()
{
    HintDlg dlg;
    if(dlg.exec()==dlg.Accepted)
    {
        QPixmap p(9,9);
        p.fill(dlg.color);
        QListWidgetItem* item=new QListWidgetItem(p,dlg.param,ui->list);
        item->setCheckState(Qt::Checked);
        item->setData(5,dlg.color.rgb());
    }
}

void hintHelper::on_actionEdit_hint_triggered()
{
    on_list_itemDoubleClicked(menuItem);
}

void hintHelper::on_list_itemDoubleClicked(QListWidgetItem* item)
{
    if(item==0)
        return;

    HintDlg dlg;
    dlg.param=item->text();
    dlg.color=QColor(item->data(5).toUInt());
    if(dlg.exec()==dlg.Accepted)
    {
        QPixmap p(9,9);
        p.fill(dlg.color);
        item->setText(dlg.param);
        item->setIcon(p);
        item->setData(5,dlg.color.rgb());
    }
}

void hintHelper::refresh()
{
    QStringList list;
    for(int i=0,c=ui->list->count();i<c;i++)
    {
        QListWidgetItem* item=ui->list->item(i);
        if(item->checkState()&Qt::Checked)
        {
            static QString str;
            str=str.sprintf("%u;",item->data(5).toUInt())+item->text();
            list.append(str);
        }
    }
    emit(changed(list));
}

void hintHelper::on_actionRemove_Hint_triggered()
{
    delete ui->list->takeItem(ui->list->currentRow());
    refresh();
}

void hintHelper::on_list_itemChanged(QListWidgetItem* item)
{
    refresh();
}
