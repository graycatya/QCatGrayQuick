#include "QCatGrayQuickPlugins.h"
#include <QQmlApplicationEngine>

#ifdef QCATGRAYQUICKTABLEVIEWMODEL_TARGET
#include "QCatGrayQuickTableViewModel.h"
#include "QCatGrayQuickTableViewModelStruct.h"
#include "QCatGrayQuickTableViewHeaderStruct.h"
#endif

QCatGrayQuickPlugins::QCatGrayQuickPlugins(QObject *parent)
    : QObject{parent}
{
    Q_INIT_RESOURCE(QCatGrayQuick);
}


void QCatGrayQuickPlugins::InitQCatGrayQuickPlugins(QQmlApplicationEngine * engine)
{
    engine->addImportPath(QCatGrayQuickImportPath);
#ifdef QCATGRAYQUICKTABLEVIEWMODEL_TARGET
    qmlRegisterType<QCatGrayQuickTableViewHeaderStruct>("com.catgray.QCatGrayQuickTableViewHeaderStruct", 1, 0, "QCatGrayQuickTableViewHeaderStruct");
    qmlRegisterType<QCatGrayQuickTableViewModelStruct>("com.catgray.QCatGrayQuickTableViewModelStruct", 1, 0, "QCatGrayQuickTableViewModelStruct");
    qmlRegisterType<QCatGrayQuickTableViewModel>("com.catgray.QCatGrayQuickTableViewModel", 1, 0, "QCatGrayQuickTableViewModel");
#endif
}

void QCatGrayQuickPlugins::InitQCatGrayQuickPlugins(QQmlEngine *engine)
{
    engine->addImportPath(QCatGrayQuickImportPath);
#ifdef QCATGRAYQUICKTABLEVIEWMODEL_TARGET
    qmlRegisterType<QCatGrayQuickTableViewHeaderStruct>("com.catgray.QCatGrayQuickTableViewHeaderStruct", 1, 0, "QCatGrayQuickTableViewHeaderStruct");
    qmlRegisterType<QCatGrayQuickTableViewModelStruct>("com.catgray.QCatGrayQuickTableViewModelStruct", 1, 0, "QCatGrayQuickTableViewModelStruct");
    qmlRegisterType<QCatGrayQuickTableViewModel>("com.catgray.QCatGrayQuickTableViewModel", 1, 0, "QCatGrayQuickTableViewModel");
#endif
}
