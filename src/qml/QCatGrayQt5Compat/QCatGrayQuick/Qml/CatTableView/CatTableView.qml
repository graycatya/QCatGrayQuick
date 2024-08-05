import QtQuick 2.12
import QtQuick.Controls 2.12
import com.catgray.QCatGrayQuickTableViewModel 1.0

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
        contentWidth: headerColumn.implicitWidth
        contentHeight: tableLayout.implicitHeight + catgrayquickTableViewModel.preferredHeaderHeight

        ScrollBar.vertical: ScrollBar{}
        ScrollBar.horizontal: ScrollBar{}

        Column {
            id: tableLayout
            anchors.top: parent.top
            anchors.topMargin: catgrayquickTableViewModel.preferredHeaderHeight
            readonly property alias datamodel: catgrayquickTableViewModel
            Repeater {
                id: tableRepeater
                model: catgrayquickTableViewModel
            }
        }
        Rectangle {
            id: headerItem
            y: itemviewScrol.contentY
            anchors.left: parent.left
            width: headerColumn.implicitWidth
            height: headerColumn.implicitHeight
            color: "transparent"
            Column {
                id: headerColumn
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
