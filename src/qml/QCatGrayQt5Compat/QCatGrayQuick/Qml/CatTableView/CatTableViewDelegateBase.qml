import QtQuick 2.12

Item {
    id: root
    clip: true
    readonly property var headerData: parent.headerData
    readonly property var datamodel: parent.datamodel
    property alias delegate: tableItemRepeater.delegate
    readonly property int columnIndex: index
    width: rowRepeater.implicitWidth
    height: rowRepeater.implicitHeight
    Row {
        id: rowRepeater
        readonly property int columnIndex: root.columnIndex
        readonly property var datamodel: root.datamodel
        readonly property var headerData: root.headerData
        Repeater {
            id: tableItemRepeater
            model: datamodel.headerCount
        }
    }
}
