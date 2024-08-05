import QtQuick 2.12
import QtQuick.Controls 2.12
import QCatGrayQuickTableViewModel 1.0

Rectangle {
    id: root
    property alias viewLayout: tableLayout
    property alias viewScrol: itemviewScrol
    //property alias viewRepeater: tableRepeater
    readonly property alias model: catgrayquickTableViewModel
    property alias delegate: tableRepeater.delegate
    property var headerData: []
    property Component headerDelegate: null
    property int columnfreezeNum: 0
    color: "transparent"

    clip: true

    QCatGrayQuickTableViewModel {
        id: catgrayquickTableViewModel
        headerCount: headerData.length
    }

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
                model: catgrayquickTableViewModel
//                delegate: CatTableViewDelegateBase {
//                    delegate: root.delegate
//                }
            }
        }
       Rectangle {
           id: headerItem
           y: itemviewScrol.contentY
           anchors.left: parent.left
           anchors.right: parent.right
           color: "transparent"
           Column {
                spacing: 0
                Repeater {
                    id: headerColumnRepeater
                    model: root.columnfreezeNum
                    Row {
                        id: headerRow
                        spacing: 0
                        readonly property int columnRepeaterIndex: index
                        Repeater {
                            id: headerRowRepeater
                            model: catgrayquickTableViewModel.headerCount
                            delegate: root.headerDelegate

                        }

                    }
                }
           }

       }
    }
}
