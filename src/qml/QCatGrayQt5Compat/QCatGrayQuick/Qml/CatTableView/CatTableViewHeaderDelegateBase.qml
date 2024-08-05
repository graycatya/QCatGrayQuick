import QtQuick 2.12

Item {
    id: root
    readonly property int columnIndex: parent.columnRepeaterIndex
    readonly property int rowIndex: index
    readonly property bool isheaderFreeze: columnIndex == 0
}
