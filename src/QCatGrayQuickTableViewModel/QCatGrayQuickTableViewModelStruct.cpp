#include "QCatGrayQuickTableViewModelStruct.h"


QCatGrayQuickTableViewModelStruct::QCatGrayQuickTableViewModelStruct()
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
