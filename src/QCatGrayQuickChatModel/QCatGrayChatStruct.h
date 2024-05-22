#ifndef QCATGRAYCHATSTRUCT_H
#define QCATGRAYCHATSTRUCT_H

#include <QObject>
#include <QVariant>
#include <QUrl>

class QCatGrayChatStruct : public QObject
{
    Q_OBJECT
    Q_PROPERTY(qint64 id READ id WRITE setid NOTIFY idChanged FINAL)
    Q_PROPERTY(QString username READ username WRITE setusername NOTIFY usernameChanged FINAL)
    Q_PROPERTY(QString senderimage READ senderimage WRITE setsenderimage NOTIFY senderimageChanged FINAL)
    Q_PROPERTY(QString sender READ sender WRITE setsender NOTIFY senderChanged FINAL)
    Q_PROPERTY(QString recipientimage READ recipientimage WRITE setrecipientimage NOTIFY recipientimageChanged FINAL)
    Q_PROPERTY(QString recipient READ recipient WRITE setrecipient NOTIFY recipientChanged FINAL)
    Q_PROPERTY(quint64 datetime READ datetime WRITE setdatetime NOTIFY datetimeChanged FINAL)
    Q_PROPERTY(QVariant data READ data WRITE setdata NOTIFY dataChanged FINAL)
    Q_PROPERTY(ChatType type READ type WRITE settype NOTIFY typeChanged FINAL)
    Q_PROPERTY(ChatStatus status READ status WRITE setstatus NOTIFY statusChanged FINAL)
    Q_ENUMS(ChatType)
    Q_ENUMS(ChatStatus)
public:
    using QObject::QObject;

    enum ChatType
    {
        Chat_Text,
        Chat_Image,
        Chat_Auido,
        Chat_Video
    };
    //Q_ENUM(ChatType)

    enum ChatStatus
    {
        Chat_Error,
        Chat_Ready,
        Chat_ParseOn,
        Chat_ParseSuccess,
        Chat_ParseError
    };
    //Q_ENUM(ChatStatus)

    QCatGrayChatStruct();
    ~QCatGrayChatStruct();

    Q_INVOKABLE void setid(qint64 id);
    qint64 id() const { return m_Id; }

    Q_INVOKABLE void setusername(const QString username);
    QString username() const { return m_UserName; }

    Q_INVOKABLE void setsenderimage(const QString senderimage);
    QString senderimage() const { return m_SenderImage; }

    Q_INVOKABLE void setsender(const QString sender);
    QString sender() const { return m_Sender; }

    Q_INVOKABLE void setrecipientimage(const QString recipientimage);
    QString recipientimage() const { return m_RecipientImage; }

    Q_INVOKABLE void setrecipient(const QString recipient);
    QString recipient() const { return m_Recipient; }

    Q_INVOKABLE void setdatetime(quint64 datetime);
    quint64 datetime() const { return m_Datetime; }

    Q_INVOKABLE void setdata(QVariant data);
    QVariant data() const { return m_Data; }

    Q_INVOKABLE void settype(ChatType type);
    ChatType type() const { return m_Type; }

    Q_INVOKABLE void setstatus(ChatStatus status);
    ChatStatus status() const { return m_Status; }

signals:
    void idChanged();
    void usernameChanged();
    void senderimageChanged();
    void senderChanged();
    void recipientimageChanged();
    void recipientChanged();
    void datetimeChanged();
    void dataChanged();
    void typeChanged();
    void statusChanged();

protected:
    qint64 m_Id;
    QString m_UserName;
    QString m_SenderImage;
    QString m_Sender;
    QString m_RecipientImage;
    QString m_Recipient;
    quint64 m_Datetime;
    QVariant m_Data;
    ChatType m_Type;
    ChatStatus m_Status;

};

#endif // QCATGRAYCHATSTRUCT_H
