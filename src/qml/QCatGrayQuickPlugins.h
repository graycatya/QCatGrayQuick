#ifndef QCATGRAYQUICKPLUGINS_H
#define QCATGRAYQUICKPLUGINS_H

#include <QObject>

class QQmlApplicationEngine;
class QQmlEngine;

class QCatGrayQuickPlugins : public QObject
{
    Q_OBJECT
public:
    explicit QCatGrayQuickPlugins(QObject *parent = nullptr);

    void InitQCatGrayQuickPlugins(QQmlApplicationEngine * engine);
    void InitQCatGrayQuickPlugins(QQmlEngine * engine);
signals:
};

#endif // QCATGRAYQUICKPLUGINS_H
