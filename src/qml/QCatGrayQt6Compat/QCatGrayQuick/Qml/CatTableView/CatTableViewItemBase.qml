import QtQuick 
import com.catgray.QCatGrayQuickTableViewModel 
import com.catgray.QCatGrayQuickTableViewModelStruct 
import com.catgray.QCatGrayQuickTableViewHeaderStruct 

Rectangle {
    id: root
    color: "transparent"
    clip: true
    property int columnIndex: -1
    property int rowIndex: -1
    property var datamodel: null
    width: datamodel ?
               datamodel.getHeaderStruct(rowIndex) !== null ?
                   datamodel.getHeaderStruct(rowIndex).preferredWidth
                 : 0
                 : 0
    height: datamodel ?
                datamodel.getStruct(columnIndex) !== null ?
                    datamodel.getStruct(columnIndex).preferredHeight
                  : 0
                  : 0
}
