#include "mainwindow.h"
#include <QApplication>
#include <QIcon>

#ifdef Q_OS_WIN
#include <windows.h>
#endif

int main(int argc, char* argv[])
{
#ifdef Q_OS_WIN
    FreeConsole();
#endif
    QApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QApplication a(argc, argv);

    QIcon appIcon(":/icons/app-icon");

    if (appIcon.isNull()) {
        appIcon = QIcon(":/icons/app-icon");
    }

    MainWindow w;
    w.setWindowIcon(appIcon);
    w.show();

    return a.exec();
}