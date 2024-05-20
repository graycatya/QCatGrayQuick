#ifndef QCATGRAYCHATSTRUCT_H
#define QCATGRAYCHATSTRUCT_H

#include <QObject>
#include <QVariant>

class QCatGrayChatStruct : public QObject
{
    Q_OBJECT
    Q_PROPERTY(qint64 id READ id WRITE setid NOTIFY idChanged FINAL)
public:
    using QObject::QObject;

    enum ChatType
    {
        Chat_Text,
        Chat_Image,
        Chat_Auido,
        Chat_Video
    };
    Q_ENUM(ChatType)

    enum ChatStatus
    {
        Chat_Error,
        Chat_Ready,
        Chat_ParseOn,
        Chat_ParseSuccess,
        Chat_ParseError
    };
    Q_ENUM(ChatStatus)

    QCatGrayChatStruct();
    ~QCatGrayChatStruct();

    void setId(qint64 id);
    qint64 getId() const;
    void setSender(const QString sender);

    void setRecipient(const QString recipient);

    void setDatetime(quint64 datetime);

    void setData(QVariant data);

    void setType(ChatType type);

    void setStatus(ChatStatus status);



protected:
    qint64 m_Id;
    QString m_Sender;
    QString m_Recipient;
    quint64 m_Datetime;
    QVariant m_Data;
    ChatType m_Type;
    ChatStatus m_Status;

};

#endif // QCATGRAYCHATSTRUCT_H
