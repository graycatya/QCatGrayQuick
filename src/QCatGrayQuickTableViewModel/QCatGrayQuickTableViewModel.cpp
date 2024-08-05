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
        m_headerStruct.clear();
        for(int i = 0; i < m_HeaderCount; i++)
        {
            QCatGrayQuickTableViewHeaderStruct *t_struct = new QCatGrayQuickTableViewHeaderStruct(this);
            m_headerStruct.insert(m_headerStruct.count(), QSharedPointer<QCatGrayQuickTableViewHeaderStruct>(t_struct));
        }
        emit headerCountChanged();
    }
}

QCatGrayQuickTableViewHeaderStruct *QCatGrayQuickTableViewModel::getHeaderStruct(int index)
{
    if(index >= 0 && index < m_headerStruct.count())
    {
        return m_headerStruct.at(index).get();
    }
    return nullptr;
}

void QCatGrayQuickTableViewModel::setPreferredHeaderHeight(int height)
{
    if(m_PreferredHeaderHeight != height)
    {
        m_PreferredHeaderHeight = height;
        emit preferredHeaderHeightChanged();
    }
}

void QCatGrayQuickTableViewModel::setMinimumHeaderHeight(int height)
{
    if(m_MinimumHeaderHeight != height)
    {
        m_MinimumHeaderHeight = height;
        emit minimumHeaderHeightChanged();
    }
}

void QCatGrayQuickTableViewModel::setMaximumHeaderHeight(int height)
{
    if(m_MaximumHeaderHeight != height)
    {
        m_MaximumHeaderHeight = height;
        emit maximumHeaderHeightChanged();
    }
}
