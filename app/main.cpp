#include <QApplication>
#include <QWidget>
#include <QLabel>
#include <QVBoxLayout>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QWidget window;
    
    window.setWindowTitle("1.0.0");
    window.setMinimumSize(300, 200);

    QLabel label("Hello, Qt!");
    label.setAlignment(Qt::AlignCenter);

    QVBoxLayout layout;
    layout.addWidget(&label);
    window.setLayout(&layout);

    window.show();

    return app.exec();
}