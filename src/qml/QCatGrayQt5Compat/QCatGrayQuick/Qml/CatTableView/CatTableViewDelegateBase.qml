import QtQuick 2.12
import com.catgray.QCatGrayQuickTableViewModel 1.0
import com.catgray.QCatGrayQuickTableViewModelStruct 1.0
import com.catgray.QCatGrayQuickTableViewHeaderStruct 1.0

Rectangle {
    id: root
    color: "transparent"
    clip: true
    property int columnindex: -1
    property var datamodel: null
    property Component delegate: null
    width: dataRow.implicitWidth
    implicitWidth: dataRow.implicitWidth
    implicitHeight: datamodel ? datamodel.getStruct(columnindex).preferredHeight : 0

    Row {
        id: dataRow
        Repeater {
            id: dataRepeater
            model: datamodel ? datamodel.headerTableData : 0
            delegate: root.delegate
        }
    }

}
