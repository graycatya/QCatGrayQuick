#include "QCatGrayQuickTableViewModel.h"
#include <QQmlEngine>


QCatGrayQuickTableViewModel::QCatGrayQuickTableViewModel(QObject *parent)
    : QAbstractListModel(parent)
{

}

QCatGrayQuickTableViewModel::~QCatGrayQuickTableViewModel()
{

}

int QCatGrayQuickTableViewModel::rowCount(const QModelIndex &parent) const
{
    if(parent.isValid())
    {
        return 0;
    }

    return m_StructList.count();
}

int QCatGrayQuickTableViewModel::columnCount(const QModelIndex &parent) const
{
    if(parent.isValid())
    {
        return 0;
    }
    return m_HeaderCount;
}

QVariant QCatGrayQuickTableViewModel::data(const QModelIndex &index, int role) const
{
    if(!index.isValid())
        return QVariant();

    const int row = index.row();
    auto item = m_StructList.at(row);
    return item->data();
}

QCatGrayQuickTableViewModelStruct *QCatGrayQuickTableViewModel::appendStruct(QJsonObject object)
{
    QCatGrayQuickTableViewModelStruct *t_struct = new QCatGrayQuickTableViewModelStruct(this);
    t_struct->setdata(object);
    beginInsertRows(QModelIndex(), m_StructList.count(), m_StructList.count());
    m_StructList.insert(m_StructList.count(), QSharedPointer<QCatGrayQuickTableViewModelStruct>(t_struct));
    endInsertRows();
    return t_struct;
}

QCatGrayQuickTableViewModelStruct *QCatGrayQuickTableViewModel::getStruct(int index)
{
    if(index >= 0 && index < m_StructList.count())
    {
        return m_StructList.at(index).get();
    }
    return nullptr;
}

int QCatGrayQuickTableViewModel::getStructSize()
{
    return m_StructList.length();
}

void QCatGrayQuickTableViewModel::removeStruct(int index)
{
    beginRemoveRows(QModelIndex(),m_StructList.count(),m_StructList.count());
    m_StructList.removeAt(index);
    endRemoveRows();
}

void QCatGrayQuickTableViewModel::clearModel()
{
    beginResetModel();
    m_StructList.clear();
    endResetModel();
}

void QCatGrayQuickTableViewModel::setHeaderCount(int headerCount)
{
    if(m_HeaderCount != headerCount)
    {
        m_HeaderCount = headerCount;
        emit headerCountChanged();
    }
}
