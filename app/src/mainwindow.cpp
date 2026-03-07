#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QRect>

MainWindow::MainWindow(QWidget *parent) 
: CFramelessWindow(parent)
, _ui(new Ui::MainWindow)
{
    _ui->setupUi(this);
#ifdef Q_OS_WIN
    setResizeableAreaWidth(8);
    setTitleBar(_ui->widgetTitlebar);
    addIgnoreWidget(_ui->labelTitleText);
#endif
}

MainWindow::~MainWindow()
{
    delete _ui;
}

void MainWindow::on_btnMin_clicked()
{
    showMinimized();
}
void MainWindow::on_btnMax_clicked()
{
    if (isMaximized()) showNormal();
    else showMaximized();
}
void MainWindow::on_btnClose_clicked()
{
    close();
}

void MainWindow::on_bthFull_clicked()
{
    if (isFullScreen()) showNormal();
    else showFullScreen();
}