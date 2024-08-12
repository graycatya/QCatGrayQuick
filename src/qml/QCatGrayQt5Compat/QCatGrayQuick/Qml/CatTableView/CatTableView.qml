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
        z:3
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
            Row {
                id: headerRow
                Repeater {
                    id: headerList
                    anchors.fill: parent
                    // boundsBehavior: Flickable.StopAtBounds
                    // orientation: ListView.Horizontal
                    model: catgrayquickTableViewModel.headerTableData
                    delegate: Rectangle {
                        width: catgrayquickTableViewModel.getHeaderStruct(index).preferredWidth
                        height: catgrayquickTableViewModel.preferredHeaderHeight

                        border.color: "#FFFFFF"
                        border.width: 1
                        color: "#666666"
                        Text {
                           anchors.fill: parent
                           verticalAlignment: Text.AlignVCenter
                           horizontalAlignment: Text.AlignHCenter
                           text: catgrayquickTableViewModel.headerTableData[index]
                           color: "#FFFFFF"
                           font.pixelSize: 16

                        }

                    }


                }
            }
        }
    }

    TableView {
        id: tableListView
        clip: true
        //anchors.fill: parent
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
        model: catgrayquickTableViewModel

        delegate: Item {
            id: delitem
            property int columnindex: index
            implicitWidth: dataRow.implicitWidth
            implicitHeight: catgrayquickTableViewModel.getStruct(columnindex).preferredHeight

                Row {
                    id: dataRow
                    Repeater {
                        id: dataRepeater
                        // anchors.fill: parent
                        // boundsBehavior: Flickable.StopAtBounds
                        // orientation: ListView.Horizontal
                        model: catgrayquickTableViewModel.headerTableData
                        delegate: Rectangle {
                            width: catgrayquickTableViewModel.getHeaderStruct(index).preferredWidth
                            height: catgrayquickTableViewModel.getStruct(columnindex).preferredHeight
                            border.color: "#FFFFFF"
                            border.width: 1
                            color: "#000000"
                            Text {
                               anchors.fill: parent
                               verticalAlignment: Text.AlignVCenter
                               horizontalAlignment: Text.AlignHCenter
                               text: catgrayquickTableViewModel.getStruct(columnindex).data[catgrayquickTableViewModel.headerTableData[index]]
                               color: "#FFFFFF"
                               font.pixelSize: 16

                            }
                        }
                    }
                }

        }

    }



}
