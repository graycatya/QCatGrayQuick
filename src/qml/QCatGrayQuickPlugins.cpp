#include "QCatGrayQuickPlugins.h"
#include <QQmlApplicationEngine>

QCatGrayQuickPlugins::QCatGrayQuickPlugins(QObject *parent)
    : QObject{parent}
{
    Q_INIT_RESOURCE(QCatGrayQuick);
}


void QCatGrayQuickPlugins::InitQCatGrayQuickPlugins(QQmlApplicationEngine * engine)
{
    engine->addImportPath(QCatGrayQuickImportPath);
}

void QCatGrayQuickPlugins::InitQCatGrayQuickPlugins(QQmlEngine *engine)
{
    engine->addImportPath(QCatGrayQuickImportPath);
}
