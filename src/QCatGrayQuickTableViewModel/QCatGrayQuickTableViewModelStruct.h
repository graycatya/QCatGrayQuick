#pragma once

#include <QObject>
#include <QVariant>
#include <QJsonObject>
#include <QJsonArray>

class QCatGrayQuickTableViewModelStruct : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QJsonObject data READ data WRITE setdata NOTIFY dataChanged FINAL)
    Q_PROPERTY(int length READ length NOTIFY lengthChanged FINAL)
public:
    using QObject::QObject;

    QCatGrayQuickTableViewModelStruct();
    ~QCatGrayQuickTableViewModelStruct();

    Q_INVOKABLE void setdata(QJsonObject data);
    QJsonObject data() const { return m_Data; }

    Q_INVOKABLE int length() const { return m_Data.keys().length(); }

signals:
    void dataChanged();
    void lengthChanged();


protected:
    QJsonObject m_Data;
};

