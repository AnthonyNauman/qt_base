#include "mainwindow.h"
#include <QApplication>

#ifdef Q_OS_WIN
#include <windows.h>
#endif

int main(int argc, char *argv[])
{
#ifdef Q_OS_WIN
    FreeConsole();
#endif
    QApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QApplication a(argc, argv);
    MainWindow w;
    w.show();

    return a.exec();
}