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
        emit preferredHeightChanged();
    }
}

void QCatGrayQuickTableViewModelStruct::setMinimumHeight(int height)
{
    if(m_MinimumHeight != height)
    {
        m_MinimumHeight = height;
        emit minimumHeightChanged();
    }
}

void QCatGrayQuickTableViewModelStruct::setMaximumHeight(int height)
{
    if(m_MaximumHeight != height)
    {
        m_MaximumHeight = height;
        emit maximumHeightChanged();
    }
}
