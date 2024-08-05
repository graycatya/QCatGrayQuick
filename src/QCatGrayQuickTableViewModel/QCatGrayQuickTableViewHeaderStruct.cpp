#include "QCatGrayQuickTableViewHeaderStruct.h"

QCatGrayQuickTableViewHeaderStruct::QCatGrayQuickTableViewHeaderStruct(QObject *parent)
    : QObject{parent}
{

}

QCatGrayQuickTableViewHeaderStruct::~QCatGrayQuickTableViewHeaderStruct()
{

}

void QCatGrayQuickTableViewHeaderStruct::setResizeMode(ResizeMode mode)
{
    if(m_ResizeMode != mode)
    {
        m_ResizeMode = mode;
        emit resizeModeChanged();
    }
}

void QCatGrayQuickTableViewHeaderStruct::setPreferredWidth(int width)
{
    if(m_PreferredWidth != width)
    {
        m_PreferredWidth = width;
        emit preferredWidthChanged();
    }
}

void QCatGrayQuickTableViewHeaderStruct::setMinimumWidth(int width)
{
    if(m_MinimumWidth != width)
    {
        m_MinimumWidth = width;
        emit minimumWidthChanged();
    }
}

void QCatGrayQuickTableViewHeaderStruct::setMaximumWidth(int width)
{
    if(m_MaximumWidth != width)
    {
        m_MaximumWidth = width;
        emit maximumWidthChanged();
    }
}
