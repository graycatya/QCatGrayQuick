#include "QCatGrayChatStruct.h"
#include <QDebug>

QCatGrayChatStruct::QCatGrayChatStruct() {}

QCatGrayChatStruct::~QCatGrayChatStruct()
{

}

void QCatGrayChatStruct::setid(qint64 id)
{
    if(m_Id != id)
    {
        m_Id = id;
        emit idChanged();
    }
}

void QCatGrayChatStruct::setusername(const QString username)
{
    if(m_UserName != username)
    {
        m_UserName = username;
        emit usernameChanged();
    }
}

void QCatGrayChatStruct::setsenderimage(const QString senderimage)
{
    if(m_SenderImage != senderimage)
    {
        m_SenderImage = senderimage;
        emit senderimageChanged();
    }
}


void QCatGrayChatStruct::setsender(const QString sender)
{
    if(m_Sender != sender)
    {
        m_Sender = sender;
        emit senderChanged();
    }
}

void QCatGrayChatStruct::setrecipientimage(const QString recipientimage)
{
    if(m_RecipientImage != recipientimage)
    {
        m_RecipientImage = recipientimage;
        emit recipientimageChanged();
    }
}

void QCatGrayChatStruct::setrecipient(const QString recipient)
{
    m_Recipient = recipient;
}

void QCatGrayChatStruct::setdatetime(quint64 datetime)
{
    m_Datetime =datetime;
}

void QCatGrayChatStruct::setdata(QVariant data)
{
    m_Data = data;
}

void QCatGrayChatStruct::settype(ChatType type)
{
    m_Type = type;
}

void QCatGrayChatStruct::setstatus(ChatStatus status)
{
    m_Status = status;
}
