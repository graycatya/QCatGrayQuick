import QtQuick 2.12
import QtQuick.Controls 2.12

Rectangle {
    id: root
    property alias viewLayout: tableLayout
    property alias viewScrol: itemviewScrol
    //property alias viewRepeater: tableRepeater
    property var model: null
    property alias delegate: tableRepeater.delegate
    property var headerData: []
    color: "transparent"

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
                id: tableRepeater
                model: root.model
//                delegate: CatTableViewDelegateBase {
//                    delegate: root.delegate
//                }
            }
        }
//        Rectangle {
//            id: headerItem
//            y: itemviewScrol.contentY
//            anchors.left: parent.left
//            anchors.right: parent.right
//            color: "transparent"
//            Loader {
//                id: headerItemloader
//                onWidthChanged: {
//                    console.log("loader w: " + width)
//                }
//            }

//        }
    }
}
