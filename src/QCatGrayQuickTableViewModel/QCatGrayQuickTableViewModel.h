#pragma once


#include <QAbstractListModel>
#include "QCatGrayQuickTableViewModelStruct.h"


class QCatGrayQuickTableViewModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(uint headerCount READ headerCount WRITE setHeaderCount NOTIFY headerCountChanged FINAL)
public:
    explicit QCatGrayQuickTableViewModel(QObject *parent = nullptr);
    ~QCatGrayQuickTableViewModel();
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    int columnCount(const QModelIndex &parent = QModelIndex()) const override;
    virtual QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    Q_INVOKABLE QCatGrayQuickTableViewModelStruct* appendStruct(QJsonObject object);
    Q_INVOKABLE QCatGrayQuickTableViewModelStruct* getStruct(int index);
    Q_INVOKABLE int getStructSize();

    Q_INVOKABLE void removeStruct(int index);
    Q_INVOKABLE void clearModel();

    int headerCount() const { return m_HeaderCount; }
    Q_INVOKABLE void setHeaderCount(int headerCount);

signals:
    void headerCountChanged();

private:
    QList<QSharedPointer<QCatGrayQuickTableViewModelStruct>> m_StructList;
    uint m_HeaderCount = 0;
};
