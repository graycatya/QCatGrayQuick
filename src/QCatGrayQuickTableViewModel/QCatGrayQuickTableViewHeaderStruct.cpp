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

        if(m_PreferredWidth > m_MaximumWidth)
        {
            m_PreferredWidth = m_MaximumWidth;
        }

        if(m_PreferredWidth < m_MinimumWidth)
        {
            m_PreferredWidth = m_MinimumWidth;
        }
        emit preferredWidthChanged();
    }
}

void QCatGrayQuickTableViewHeaderStruct::setMinimumWidth(int width)
{
    if(m_MinimumWidth != width)
    {
        m_MinimumWidth = width;

        if(m_PreferredWidth < m_MinimumWidth)
        {
            m_PreferredWidth = m_MinimumWidth;
            emit preferredWidthChanged();
        }

        emit minimumWidthChanged();
    }
}

void QCatGrayQuickTableViewHeaderStruct::setMaximumWidth(int width)
{
    if(m_MaximumWidth != width)
    {
        m_MaximumWidth = width;

        if(m_PreferredWidth > m_MaximumWidth)
        {
            m_PreferredWidth = m_MaximumWidth;
            emit preferredWidthChanged();
        }

        emit maximumWidthChanged();
    }
}
