import QtQuick
import QtQuick.Controls


Item {
    id: root
    property alias chatviewRepeater: viewRepeater
    property alias chatviewDelegate: viewRepeater.delegate
    //property alias chatviewLayout: viewLayout
    property alias chatviewScrol: verticalScrollBar
    property alias chatviewRepeaterModel: viewRepeater.model

    // Flickable {
    //     id: viewScrol
    //     anchors.fill: parent
    //     contentWidth: parent.width
    //     contentHeight: viewLayout.implicitHeight
    //     ScrollBar.vertical: ScrollBar{}

    //     Column {
    //         id: viewLayout
    //         spacing: 5
    //         anchors.left: parent.left
    //         anchors.right: parent.right
    //         Repeater {
    //             id: viewRepeater
    //         }
    //     }
    // }

    ScrollBar {
        id: verticalScrollBar
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        z: 3
    }

    ListView {
        id: viewRepeater
        anchors.fill: parent
        contentWidth: parent.width
        boundsBehavior: Flickable.StopAtBounds
        spacing: 15
        ScrollBar.vertical: verticalScrollBar
    }
}
