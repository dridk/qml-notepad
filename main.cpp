#include <QApplication>
#include <QQmlContext>
#include <QQmlApplicationEngine>
#include "notepad.h"
int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("notepad", new Notepad);
    engine.load(QUrl(QStringLiteral("qrc:///main.qml")));


    return app.exec();
}
