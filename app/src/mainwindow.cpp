#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QRect>

MainWindow::MainWindow(QWidget* parent)
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

void MainWindow::onBtnMinClicked()
{
    showMinimized();
}
void MainWindow::onBtnMaxClicked()
{
    if (isMaximized()) showNormal();
    else showMaximized();
}
void MainWindow::onBtnCloseClicked()
{
    close();
}

void MainWindow::onBthFullClicked()
{
    if (isFullScreen()) showNormal();
    else showFullScreen();
}