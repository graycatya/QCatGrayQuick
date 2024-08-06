import QtQuick 2.12
import com.catgray.QCatGrayQuickTableViewModel 1.0
import com.catgray.QCatGrayQuickTableViewModelStruct 1.0
import com.catgray.QCatGrayQuickTableViewHeaderStruct 1.0

Rectangle {
    id: root
    color: "transparent"
    readonly property int columnIndex: parent.columnIndex
    readonly property int rowIndex: index
    readonly property var datamodel: parent.datamodel
    width: datamodel.getHeaderStruct(rowIndex).preferredWidth
    height: datamodel.getStruct(columnIndex).preferredHeight

}
