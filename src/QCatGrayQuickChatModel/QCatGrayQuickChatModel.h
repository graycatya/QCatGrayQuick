#pragma once

#include <QAbstractListModel>
#include "QCatGrayChatStruct.h"


class QCatGrayQuickChatModel : public QAbstractListModel
{
    Q_OBJECT

public:
    explicit QCatGrayQuickChatModel(QObject *parent = nullptr);
    ~QCatGrayQuickChatModel();

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;

    Q_INVOKABLE QCatGrayChatStruct* appendStruct(qint64 id, QString username, QString sender,
                            QString recipient, quint64 datetime,
                            QVariant data, int type);

    Q_INVOKABLE void removeStruct(int index);
    Q_INVOKABLE void clearModel();


private:

    QList<QSharedPointer<QCatGrayChatStruct>> m_ChatStructList;
};
