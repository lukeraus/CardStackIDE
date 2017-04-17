#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlEngine>
#include <QQmlContext>
#include "mousememory.h"


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QScopedPointer<MouseMemory> mouse(new MouseMemory);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    engine.rootContext()->setContextProperty("mouse", mouse.data());


    return app.exec();
}
