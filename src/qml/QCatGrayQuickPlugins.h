#ifndef QCATGRAYQUICKPLUGINS_H
#define QCATGRAYQUICKPLUGINS_H

#include <QObject>

class QQmlApplicationEngine;

class QCatGrayQuickPlugins : public QObject
{
    Q_OBJECT
public:
    explicit QCatGrayQuickPlugins(QObject *parent = nullptr);

    void InitQCatGrayQuickPlugins(QQmlApplicationEngine * engine);
signals:
};

#endif // QCATGRAYQUICKPLUGINS_H
