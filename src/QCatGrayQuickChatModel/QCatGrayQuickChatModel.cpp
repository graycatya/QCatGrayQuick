#include "QCatGrayQuickChatModel.h"
#include <QSharedPointer>

QCatGrayQuickChatModel::QCatGrayQuickChatModel(QObject *parent)
    : QAbstractItemModel(parent)
{

}

QCatGrayQuickChatModel::~QCatGrayQuickChatModel()
{

}

QCatGrayChatStruct* QCatGrayQuickChatModel::appendStruct(qint64 id, QString sender,
                                          QString recipient, quint64 datetime,
                                          QVariant data,
                                          QCatGrayChatStruct::ChatType type)
{
    QCatGrayChatStruct *chatstruct = new QCatGrayChatStruct(this);
    chatstruct->setid(id);
    chatstruct->setsender(sender);
    chatstruct->setrecipient(recipient);
    chatstruct->setdatetime(datetime);
    chatstruct->setdata(data);
    chatstruct->settype(type);
    if(type == QCatGrayChatStruct::ChatType::Chat_Text)
    {
        chatstruct->setstatus(QCatGrayChatStruct::ChatStatus::Chat_ParseSuccess);
    } else {
        chatstruct->setstatus(QCatGrayChatStruct::ChatStatus::Chat_Ready);
    }
    beginInsertRows(QModelIndex(),m_ChatStructList.count(),m_ChatStructList.count());
    m_ChatStructList.insert(id, QSharedPointer<QCatGrayChatStruct>(chatstruct));
    endInsertRows();
    return chatstruct;
}

void QCatGrayQuickChatModel::removeStruct(qint64 id)
{
    beginInsertRows(QModelIndex(),m_ChatStructList.count(),m_ChatStructList.count());
    m_ChatStructList.remove(id);
    endInsertRows();
}

void QCatGrayQuickChatModel::clearModel()
{
    beginResetModel();
    m_ChatStructList.clear();
    endResetModel();
}
