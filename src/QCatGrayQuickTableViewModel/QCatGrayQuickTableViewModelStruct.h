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
    Q_PROPERTY(int preferredHeight READ preferredHeight WRITE setPreferredHeight NOTIFY preferredHeightChanged)
    Q_PROPERTY(int minimumHeight READ minimumHeight WRITE setMinimumHeight NOTIFY minimumHeightChanged)
    Q_PROPERTY(int maximumHeight READ maximumHeight WRITE setMaximumHeight NOTIFY maximumHeightChanged)
public:
    using QObject::QObject;

    explicit QCatGrayQuickTableViewModelStruct(QObject *parent = nullptr);
    ~QCatGrayQuickTableViewModelStruct();

    Q_INVOKABLE void setdata(QJsonObject data);
    QJsonObject data() const { return m_Data; }

    virtual Q_INVOKABLE QVariant columnData(quint32 column) {
        Q_UNUSED(column)
        if(m_Data.keys().length() <= column && column < 0)
        {
            return QVariant();
        }
        return m_Data.value(m_Data.keys().value(column));
    }

    Q_INVOKABLE int length() const { return m_Data.keys().length(); }

    int preferredHeight() const { return m_PreferredHeight; }
    void setPreferredHeight(int height);

    int minimumHeight() const { return m_MinimumHeight; }
    void setMinimumHeight(int height);

    int maximumHeight() const { return m_MaximumHeight; }
    void setMaximumHeight(int height);

signals:
    void dataChanged();
    void lengthChanged();
    void preferredHeightChanged();
    void minimumHeightChanged();
    void maximumHeightChanged();


protected:
    QJsonObject m_Data;
    int m_PreferredHeight = 30;
    int m_MinimumHeight = 30;
    int m_MaximumHeight = 30;
};

