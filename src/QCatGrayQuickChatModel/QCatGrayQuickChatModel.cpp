#include "QCatGrayQuickChatModel.h"
#include <QSharedPointer>

QCatGrayQuickChatModel::QCatGrayQuickChatModel(QObject *parent)
    : QAbstractListModel(parent)
{

}

QCatGrayQuickChatModel::~QCatGrayQuickChatModel()
{

}

int QCatGrayQuickChatModel::rowCount(const QModelIndex &parent) const
{
    if(parent.isValid())
    {
        return 0;
    }

    return m_ChatStructList.count();
}

QVariant QCatGrayQuickChatModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    const int row = index.row();
    auto item = m_ChatStructList.at(row);
    switch(role)
    {
        case Qt::UserRole+0:
        {
            return item->id();
        }
        case Qt::UserRole+1:
        {
            return item->username();
        }
        case Qt::UserRole+2:
        {
            return item->senderimage();
        }
        case Qt::UserRole+3:
        {
            return item->sender();
        }
        case Qt::UserRole+4:
        {
            return item->recipientimage();
        }
        case Qt::UserRole+5:
        {
            return item->recipient();
        }
        case Qt::UserRole+6:
        {
            return item->datetime();
        }
        case Qt::UserRole+7:
        {
            return item->data();
        }
        case Qt::UserRole+8:
        {
            return item->type();
        }
        case Qt::UserRole+9:
        {
            return item->status();
        }
        default:break;
    }

    return QVariant();
}

QHash<int, QByteArray> QCatGrayQuickChatModel::roleNames() const
{
    return QHash<int,QByteArray>{
        { Qt::UserRole+0, "id" }
        ,{ Qt::UserRole+1, "username" }
        ,{ Qt::UserRole+2, "senderimage" }
        ,{ Qt::UserRole+3, "sender" }
        ,{ Qt::UserRole+4, "recipientimage" }
        ,{ Qt::UserRole+5, "recipient" }
        ,{ Qt::UserRole+6, "datetime" }
        ,{ Qt::UserRole+7, "data" }
        ,{ Qt::UserRole+8, "type" }
        ,{ Qt::UserRole+9, "status" }
    };
}

QCatGrayChatStruct* QCatGrayQuickChatModel::appendStruct(qint64 id, QString username,
                                                         QString sender, QString recipient,
                                                         quint64 datetime, QVariant data,
                                                            int type)
{
    QCatGrayChatStruct *chatstruct = new QCatGrayChatStruct(this);
    chatstruct->setid(id);
    chatstruct->setusername(username);
    chatstruct->setsender(sender);
    chatstruct->setrecipient(recipient);
    chatstruct->setdatetime(datetime);
    chatstruct->setdata(data);
    chatstruct->settype(static_cast<QCatGrayChatStruct::ChatType>(type));
    if(type == QCatGrayChatStruct::ChatType::Chat_Text)
    {
        chatstruct->setstatus(QCatGrayChatStruct::ChatStatus::Chat_ParseSuccess);
    } else {
        chatstruct->setstatus(QCatGrayChatStruct::ChatStatus::Chat_Ready);
    }
    beginInsertRows(QModelIndex(),m_ChatStructList.count(),m_ChatStructList.count());
    m_ChatStructList.insert(m_ChatStructList.count(), QSharedPointer<QCatGrayChatStruct>(chatstruct));
    endInsertRows();
    return chatstruct;
}

QCatGrayChatStruct *QCatGrayQuickChatModel::getStruct(int index)
{
    if(index >= 0 && index < m_ChatStructList.count())
    {
        return m_ChatStructList.at(index).get();
    }
    return nullptr;
}

int QCatGrayQuickChatModel::getStructSize()
{
    return m_ChatStructList.length();
}

void QCatGrayQuickChatModel::removeStruct(int index)
{
    beginRemoveRows(QModelIndex(),m_ChatStructList.count(),m_ChatStructList.count());
    m_ChatStructList.removeAt(index);
    endRemoveRows();
}

void QCatGrayQuickChatModel::clearModel()
{
    beginResetModel();
    m_ChatStructList.clear();
    endResetModel();
}
