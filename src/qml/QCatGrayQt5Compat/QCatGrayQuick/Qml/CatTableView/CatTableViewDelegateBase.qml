import QtQuick 2.12

Item {
    id: root
    readonly property var datamodel: parent.datamodel
    property alias delegate: tableItemRepeater.delegate
    width: rowRepeater.implicitWidth
    height: rowRepeater.implicitHeight

    Connections {
        target: datamodel.getStruct(index)
    }

    Row {
        id: rowRepeater
        Repeater {
            id: tableItemRepeater
            model: datamodel.headerCount
        }
    }
}
