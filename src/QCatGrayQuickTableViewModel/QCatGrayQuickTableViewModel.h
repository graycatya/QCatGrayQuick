#pragma once


#include <QAbstractListModel>
#include "QCatGrayQuickTableViewModelStruct.h"


class QCatGrayQuickTableViewModel : public QAbstractListModel
{
    Q_OBJECT

public:
    explicit QCatGrayQuickTableViewModel(QObject *parent = nullptr);
    ~QCatGrayQuickTableViewModel();
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    int columnCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;


private:
    QList<QSharedPointer<QCatGrayQuickTableViewModelStruct>> m_StructList;

};
