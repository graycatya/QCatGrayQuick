import QtQuick 2.12
import QtQuick.Layouts 1.12
import com.catgray.QCatGrayQuickTableViewModel 1.0
import com.catgray.QCatGrayQuickTableViewModelStruct 1.0
import com.catgray.QCatGrayQuickTableViewHeaderStruct 1.0

Item {
    id: root
    readonly property int columnIndex: parent.columnRepeaterIndex
    readonly property int rowIndex: index
    readonly property bool isheaderFreeze: columnIndex == 0
    readonly property var model: parent.parent.datamodel
    readonly property QCatGrayQuickTableViewHeaderStruct headerStruct: model.getHeaderStruct(columnIndex)
    readonly property var headerData: parent.headerData
//    Connections {
//        target: model.getHeaderStruct(rowIndex)
//        function onPreferredWidthChanged() {
//            root.width = model.getHeaderStruct(columnIndex).preferredWidth
//        }
//    }
    width: model.getHeaderStruct(rowIndex).preferredWidth
    height: model.preferredHeaderHeight

}
