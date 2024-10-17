import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import com.catgray.QCatGrayQuickTableViewModel 1.0

Rectangle {
    id: root
    //property alias viewScrol: itemviewScrol
    //property alias viewRepeater: tableRepeater
    readonly property alias model: catgrayquickTableViewModel
    property Component delegate: null
    property alias headerData: catgrayquickTableViewModel.headerTableData
    property Component headerDelegate: null
    property bool freezeHeader: true
    property int columnfreezeNum: 0
    property int leftbottomfreezeNum: 0
    property alias horizontalScrollBar: tablehorizontalScrollBar
    property alias verticalScrollBar: tableverticalScrollBar

    color: "transparent"
    //clip: true

    QCatGrayQuickTableViewModel {
        id: catgrayquickTableViewModel
        flickableWidth: root.width
    }



    ScrollBar {
        id: tablehorizontalScrollBar
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.left: parent.left
        z: 3
    }

    ScrollBar {
        id: tableverticalScrollBar
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        z: 3
    }

    Item {
        id: headeritem
        width: tableListView.width
        height: catgrayquickTableViewModel.preferredHeaderHeight
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        z:2
        clip: true
        Flickable {
            anchors.fill: parent
            boundsBehavior: Flickable.StopAtBounds
            ScrollBar.horizontal: tablehorizontalScrollBar
            contentWidth: headerRow.implicitWidth
            interactive: catgrayquickTableViewModel.interactive
            Row {
                id: headerRow
                Repeater {
                    id: headerList
                    model: catgrayquickTableViewModel.headerTableData
                    delegate: root.headerDelegate
                }
            }
        }
    }

    TableView {
        id: tableListView
        clip: true
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: catgrayquickTableViewModel.preferredHeaderHeight
        boundsBehavior: Flickable.StopAtBounds
        columnSpacing: 0
        rowSpacing: 0
        ScrollBar.vertical: tableverticalScrollBar
        ScrollBar.horizontal: tablehorizontalScrollBar
        contentWidth: headerRow.implicitWidth
        model: catgrayquickTableViewModel
        interactive: catgrayquickTableViewModel.interactive

        delegate: root.delegate
    }



}
