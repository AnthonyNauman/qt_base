#pragma once

#include <framelesswindow.h>
#include <QString>

namespace Ui {
class MainWindow;
}

class MainWindow : public CFramelessWindow
{
    Q_OBJECT

public:
    explicit MainWindow(QWidget* parent = 0);
    ~MainWindow();

private slots:
    void onBtnMinClicked();
    void onBtnMaxClicked();
    void onBtnCloseClicked();
    void onBthFullClicked();

private:
    Ui::MainWindow* _ui;
};