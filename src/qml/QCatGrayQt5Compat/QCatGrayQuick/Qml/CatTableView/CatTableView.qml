import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import com.catgray.QCatGrayQuickTableViewModel 1.0

Rectangle {
    id: root
    property alias viewLayout: tableLayout
    property alias viewScrol: itemviewScrol
    //property alias viewRepeater: tableRepeater
    readonly property alias model: catgrayquickTableViewModel
    property Component delegate: null
    property var headerData: []
    property Component headerDelegate: null
    property int columnfreezeNum: 0
    color: "transparent"

    clip: true

    onHeaderDataChanged: {
        catgrayquickTableViewModel.headerCount = headerData.length
    }

    QCatGrayQuickTableViewModel {
        id: catgrayquickTableViewModel
        flickableWidth: itemviewScrol.width
        onFlickableWidthChanged: {
            console.log("flickableWidth: " + flickableWidth)
        }
    }

    Flickable {
        id: itemviewScrol
        //interactive: false
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
                CatTableViewDelegateBase {
                    delegate: root.delegate
                }
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
                readonly property alias datamodel: catgrayquickTableViewModel
                readonly property alias viewScrol: itemviewScrol
                Repeater {
                    id: headerColumnRepeater
                    model: root.columnfreezeNum

                    Row {
                        id: headerRow
                        spacing: 0
                        readonly property int columnRepeaterIndex: index
                        readonly property var headerData: root.headerData

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
