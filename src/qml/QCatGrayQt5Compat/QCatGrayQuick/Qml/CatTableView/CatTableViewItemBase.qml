import QtQuick 2.12
import com.catgray.QCatGrayQuickTableViewModel 1.0
import com.catgray.QCatGrayQuickTableViewModelStruct 1.0
import com.catgray.QCatGrayQuickTableViewHeaderStruct 1.0

Rectangle {
    id: root
    color: "transparent"
    clip: true
    readonly property var headerData: parent.headerData
    readonly property int columnIndex: parent.objectName === "headerLoader" ? parent.columnIndex - 1 : parent.columnIndex
    readonly property int rowIndex: index
    readonly property var datamodel: parent.datamodel
    width: datamodel.getHeaderStruct(rowIndex) !== null ? datamodel.getHeaderStruct(rowIndex).preferredWidth : 0
    height: datamodel.getStruct(columnIndex) !== null ? datamodel.getStruct(columnIndex).preferredHeight : 0

}
