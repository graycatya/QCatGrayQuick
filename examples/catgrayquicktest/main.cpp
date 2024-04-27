#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDebug>
#include <QResource>
#include "QCatGrayQuickPlugins.h"


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    QCatGrayQuickPlugins catgrayquickplugins;
    catgrayquickplugins.InitQCatGrayQuickPlugins(&engine);
    const QUrl mainQmlUrl(QStringLiteral("qrc:///qml/main.qml"));

    qDebug() << "importPathList: " << engine.importPathList() ;

    const QMetaObject::Connection connection = QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [&mainQmlUrl, &connection](QObject *object, const QUrl &url) {
            if (url != mainQmlUrl) {
                return;
            }
            if (!object) {
                QGuiApplication::exit(-1);
            } else {
                QObject::disconnect(connection);
            }
        },
        Qt::QueuedConnection);

    engine.load(mainQmlUrl);

    return app.exec();
}
