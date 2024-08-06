#include "QCatGrayQuickTableViewModelStruct.h"


QCatGrayQuickTableViewModelStruct::QCatGrayQuickTableViewModelStruct(QObject *parent)
    : QObject{parent}
{

}

QCatGrayQuickTableViewModelStruct::~QCatGrayQuickTableViewModelStruct()
{

}

void QCatGrayQuickTableViewModelStruct::setdata(QJsonObject data)
{
    if(m_Data != data)
    {
        m_Data = data;
        emit dataChanged();
        emit lengthChanged();
    }
}

void QCatGrayQuickTableViewModelStruct::setPreferredHeight(int height)
{
    if(m_PreferredHeight != height)
    {
        m_PreferredHeight = height;
        if(m_PreferredHeight < m_MinimumHeight)
        {
            m_PreferredHeight = m_MinimumHeight;
        }
        if(m_PreferredHeight > m_MaximumHeight)
        {
            m_PreferredHeight = m_MaximumHeight;
        }
        emit preferredHeightChanged();
    }
}

void QCatGrayQuickTableViewModelStruct::setMinimumHeight(int height)
{
    if(m_MinimumHeight != height)
    {
        m_MinimumHeight = height;
        if(m_PreferredHeight < m_MinimumHeight)
        {
            m_PreferredHeight = m_MinimumHeight;
            emit preferredHeightChanged();
        }
        emit minimumHeightChanged();
    }
}

void QCatGrayQuickTableViewModelStruct::setMaximumHeight(int height)
{
    if(m_MaximumHeight != height)
    {
        m_MaximumHeight = height;
        if(m_PreferredHeight > m_MaximumHeight)
        {
            m_PreferredHeight = m_MaximumHeight;
            emit preferredHeightChanged();
        }
        emit maximumHeightChanged();
    }
}
