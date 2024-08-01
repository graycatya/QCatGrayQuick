import QtQuick 2.12
import QtQuick.Controls 2.12

Rectangle {
    id: root
    property alias viewLayout: tableLayout
    property alias viewScrol: itemviewScrol
    clip: true
    Flickable {
        id: itemviewScrol
        boundsBehavior: Flickable.StopAtBounds
        anchors.fill: parent
        contentWidth: tableLayout.implicitWidth
        contentHeight: tableLayout.implicitHeight

        ScrollBar.vertical: ScrollBar{}
        ScrollBar.horizontal: ScrollBar{}

        Column {
            id: tableLayout
            Repeater {
                model: 10
                delegate: CatTableViewDelegateBase {
                    width: 1000
                    height: 50
                    Rectangle {
                        border.width: 1
                        anchors.fill: parent
                        color: "blue"
                    }
                }
            }
        }
        Rectangle {
            y: itemviewScrol.contentY
            anchors.left: parent.left
            anchors.right: parent.right
            height: 50
            color: "blue"
        }
        Rectangle {
            x: itemviewScrol.contentX
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: 100
            color: "gray"
        }
    }
}
