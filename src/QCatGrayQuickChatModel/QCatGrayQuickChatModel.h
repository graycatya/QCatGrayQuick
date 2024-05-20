#pragma once

#include <QAbstractItemModel>



struct ChatDataBasic
{
    qint64 id;
    QString sender;
    QString recipient;
    quint64 datetime;

};


class QCatGrayQuickChatModel : public QAbstractItemModel
{
    Q_OBJECT

public:

};
