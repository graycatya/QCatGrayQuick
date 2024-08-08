#include "QCatGrayQuickTableViewModel.h"
#include <QQmlEngine>
#include <QGuiApplication>
#include <QCursor>


QCatGrayQuickTableViewModel::QCatGrayQuickTableViewModel(QObject *parent)
    : QAbstractListModel(parent)
{
    InitConnect();
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
    connect(this, &QCatGrayQuickTableViewModel::setAllItemPreferredHeighted,
            t_struct, &QCatGrayQuickTableViewModelStruct::setPreferredHeight);
    connect(this, &QCatGrayQuickTableViewModel::setAllItemMinimumHeighted,
            t_struct, &QCatGrayQuickTableViewModelStruct::setMinimumHeight);
    connect(this, &QCatGrayQuickTableViewModel::setAllItemMaximumHeighted,
            t_struct, &QCatGrayQuickTableViewModelStruct::setMaximumHeight);
    t_struct->setdata(object);
    beginInsertRows(QModelIndex(), m_StructList.count(), m_StructList.count());
    m_StructList.insert(m_StructList.count(), QSharedPointer<QCatGrayQuickTableViewModelStruct>(t_struct));
    endInsertRows();
    emit tabledataChanged();
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
    emit tabledataChanged();
}

void QCatGrayQuickTableViewModel::clearModel()
{
    beginResetModel();
    m_StructList.clear();
    endResetModel();
    emit tabledataChanged();
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
            connect(this, &QCatGrayQuickTableViewModel::setAllHeaderPreferredWidthed,
                    t_struct, &QCatGrayQuickTableViewHeaderStruct::setPreferredWidth);
            connect(this, &QCatGrayQuickTableViewModel::setAllHeaderMinimumWidthed,
                    t_struct, &QCatGrayQuickTableViewHeaderStruct::setMinimumWidth);
            connect(this, &QCatGrayQuickTableViewModel::setAllHeaderMaximumWidthed,
                    t_struct, &QCatGrayQuickTableViewHeaderStruct::setMaximumWidth);
            connect(t_struct, &QCatGrayQuickTableViewHeaderStruct::preferredWidthChanged,
                    this, [=](){
                //updateHeaderStruct();
            });
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

void QCatGrayQuickTableViewModel::setAllHeaderPreferredWidth(int width)
{
    emit setAllHeaderPreferredWidthed(width);
}

void QCatGrayQuickTableViewModel::setAllHeaderMinimumWidth(int width)
{
    emit setAllHeaderMinimumWidthed(width);
}

void QCatGrayQuickTableViewModel::setAllHeaderMaximumWidth(int width)
{
    emit setAllHeaderMaximumWidthed(width);
}

void QCatGrayQuickTableViewModel::setAllItemPreferredHeight(int height)
{
    emit setAllItemPreferredHeighted(height);
}

void QCatGrayQuickTableViewModel::setAllItemMinimumHeight(int height)
{
    emit setAllItemMinimumHeighted(height);
}

void QCatGrayQuickTableViewModel::setAllItemMaximumHeight(int height)
{
    emit setAllItemMaximumHeighted(height);
}

void QCatGrayQuickTableViewModel::setPreferredHeaderHeight(int height)
{
    if(m_PreferredHeaderHeight != height)
    {
        m_PreferredHeaderHeight = height;
        if(m_PreferredHeaderHeight < m_MinimumHeaderHeight)
        {
            m_PreferredHeaderHeight = m_MinimumHeaderHeight;
        }
        if(m_PreferredHeaderHeight > m_MaximumHeaderHeight)
        {
            m_PreferredHeaderHeight = m_MaximumHeaderHeight;
        }
        emit preferredHeaderHeightChanged();
    }
}

void QCatGrayQuickTableViewModel::setMinimumHeaderHeight(int height)
{
    if(m_MinimumHeaderHeight != height)
    {
        m_MinimumHeaderHeight = height;
        if(m_PreferredHeaderHeight < m_MinimumHeaderHeight)
        {
            m_PreferredHeaderHeight = m_MinimumHeaderHeight;
            emit preferredHeaderHeightChanged();
        }
        emit minimumHeaderHeightChanged();
    }
}

void QCatGrayQuickTableViewModel::setMaximumHeaderHeight(int height)
{
    if(m_MaximumHeaderHeight != height)
    {
        m_MaximumHeaderHeight = height;
        if(m_PreferredHeaderHeight > m_MaximumHeaderHeight)
        {
            m_PreferredHeaderHeight = m_MaximumHeaderHeight;
            emit preferredHeaderHeightChanged();
        }
        emit maximumHeaderHeightChanged();
    }
}

void QCatGrayQuickTableViewModel::setFlickableWidth(int width)
{
    if(m_FlickableWidth != width)
    {
        if(m_FlickableWidth < 0)
        {
            m_FlickableWidth = 0;
        }
        m_FlickableWidth = width;
        emit flickableWidthChanged();
        updateHeaderStruct();
    }
}

void QCatGrayQuickTableViewModel::setOverrideCursor(Qt::CursorShape shape)
{
    static_cast<QGuiApplication*>(QGuiApplication::instance())->setOverrideCursor(QCursor(shape));
}

void QCatGrayQuickTableViewModel::updateHeaderStruct()
{
    int notstretchwidths = 0, totalheaderWidth = 0;
    QList<int> headerStretchIndexs;
    for(int i = 0; i < m_headerStruct.length(); i++)
    {
        if(m_headerStruct.at(i).get()->resizeMode() == QCatGrayQuickTableViewHeaderStruct::Stretch)
        {
            headerStretchIndexs.append(i);
        } else {
            notstretchwidths = notstretchwidths + m_headerStruct.at(i).get()->preferredWidth();
        }
        totalheaderWidth = totalheaderWidth + m_headerStruct.at(i).get()->preferredWidth();
    }
    if(!headerStretchIndexs.isEmpty())
    {

        if(m_FlickableWidth > totalheaderWidth)
        {
            int allstretchwidth = m_FlickableWidth - notstretchwidths;
            int stretchwidth = allstretchwidth / headerStretchIndexs.size();
            foreach (int index, headerStretchIndexs) {
                m_headerStruct.at(index).get()->setPreferredWidth(stretchwidth);
            }
        } else {
            int allstretchwidth = m_FlickableWidth - notstretchwidths;
            int stretchwidth = allstretchwidth / headerStretchIndexs.size();
            foreach (int index, headerStretchIndexs) {
                m_headerStruct.at(index).get()->setPreferredWidth(stretchwidth);
            }
        }
    }
}

void QCatGrayQuickTableViewModel::InitConnect()
{

}

