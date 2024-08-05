import QtQuick 2.12
import com.catgray.QCatGrayQuickTableViewModel 1.0
import com.catgray.QCatGrayQuickTableViewModelStruct 1.0

Item {
    id: root
    readonly property int columnIndex: parent.columnRepeaterIndex
    readonly property int rowIndex: index
    readonly property bool isheaderFreeze: columnIndex == 0
}
