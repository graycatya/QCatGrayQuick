#pragma once

#include <QAbstractItemModel>
#include "QCatGrayChatStruct.h"


class QCatGrayQuickChatModel : public QAbstractItemModel
{
    Q_OBJECT

public:
    explicit QCatGrayQuickChatModel(QObject *parent = nullptr);
    ~QCatGrayQuickChatModel();

    Q_INVOKABLE QCatGrayChatStruct* appendStruct(qint64 id, QString sender,
                            QString recipient, quint64 datetime,
                            QVariant data, QCatGrayChatStruct::ChatType type);

    Q_INVOKABLE void removeStruct(qint64 id);
    Q_INVOKABLE void clearModel();


private:

    QHash<qint64, QSharedPointer<QCatGrayChatStruct>> m_ChatStructList;
};
