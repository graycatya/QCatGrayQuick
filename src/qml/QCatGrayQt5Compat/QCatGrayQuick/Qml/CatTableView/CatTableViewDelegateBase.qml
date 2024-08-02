import QtQuick 2.12

Item {
    id: root
    property int tablerow: model.row
    property alias model: tableItemRepeater.model
    property alias delegate: tableItemRepeater.delegate
    Row {
        Repeater {
            id: tableItemRepeater

        }
    }
}
