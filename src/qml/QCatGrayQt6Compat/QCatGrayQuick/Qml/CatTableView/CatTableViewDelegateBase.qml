import QtQuick 
import com.catgray.QCatGrayQuickTableViewModel 
import com.catgray.QCatGrayQuickTableViewModelStruct 
import com.catgray.QCatGrayQuickTableViewHeaderStruct 

Rectangle {
    id: root
    color: "transparent"
    clip: true
    property int columnIndex: -1
    property var datamodel: null
    property Component delegate: null
    width: dataRow.implicitWidth
    implicitWidth: dataRow.implicitWidth
    implicitHeight: datamodel ? datamodel.getStruct(columnIndex).preferredHeight : 0

    Row {
        id: dataRow
        Repeater {
            id: dataRepeater
            model: datamodel ? datamodel.headerTableData : 0
            delegate: root.delegate
        }
    }

}
