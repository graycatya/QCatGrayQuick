import QtQuick 2.12
import QtQuick.Controls 2.12


Item {
    id: root
    property alias chatviewRepeater: viewRepeater
    property alias chatviewDelegate: viewRepeater.delegate
    property alias chatviewLayout: viewLayout
    property alias chatviewScrol: viewScrol
    property alias chatviewRepeaterModel: viewRepeater.model

    Flickable {
        id: viewScrol
        anchors.fill: parent
        contentWidth: parent.width
        contentHeight: viewLayout.implicitHeight
        ScrollBar.vertical: ScrollBar{}

        Column {
            id: viewLayout
            spacing: 5
            anchors.left: parent.left
            anchors.right: parent.right
            Repeater {
                id: viewRepeater
            }
        }
    }
}
