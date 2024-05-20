#include "QCatGrayChatStruct.h"

QCatGrayChatStruct::QCatGrayChatStruct() {}

QCatGrayChatStruct::~QCatGrayChatStruct()
{

}

void QCatGrayChatStruct::setId(qint64 id)
{
    m_Id = id;
}

qint64 QCatGrayChatStruct::getId() const
{
    return m_Id;
}

void QCatGrayChatStruct::setSender(const QString sender)
{
    m_Sender = sender;
}

void QCatGrayChatStruct::setRecipient(const QString recipient)
{
    m_Recipient = recipient;
}

void QCatGrayChatStruct::setDatetime(quint64 datetime)
{
    m_Datetime =datetime;
}

void QCatGrayChatStruct::setData(QVariant data)
{
    m_Data = data;
}

void QCatGrayChatStruct::setType(ChatType type)
{
    m_Type = type;
}

void QCatGrayChatStruct::setStatus(ChatStatus status)
{
    m_Status = status;
}
