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
    property bool freezeHeader: true
    property int columnfreezeNum: 0

    color: "transparent"
    clip: true

    onHeaderDataChanged: {
        catgrayquickTableViewModel.headerCount = headerData.length
    }

    QCatGrayQuickTableViewModel {
        id: catgrayquickTableViewModel
        flickableWidth: itemviewScrol.width
        onDataChanged: {

        }
    }

    Flickable {
        id: itemviewScrol
        boundsBehavior: Flickable.StopAtBounds
        anchors.fill: parent
        contentWidth: root.freezeHeader ? headerColumn.implicitWidth : tableLayout.implicitWidth
        contentHeight: {
            if(!root.freezeHeader)
            {
                    return tableLayout.implicitHeight;
            }
            return tableLayout.implicitHeight + catgrayquickTableViewModel.preferredHeaderHeight;
        }
        ScrollBar.vertical: ScrollBar{}
        ScrollBar.horizontal: ScrollBar{}

        Column {
            id: tableLayout
            anchors.top: parent.top
            anchors.topMargin: root.freezeHeader ? catgrayquickTableViewModel.preferredHeaderHeight : 0
            readonly property alias datamodel: catgrayquickTableViewModel
            readonly property var headerData: root.headerData
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
                    model: //root.columnfreezeNum + 1
                    {
                        var freezenum = 0;
                        if(root.freezeHeader)
                        {
                            if(catgrayquickTableViewModel.tabledata.length > 0 && catgrayquickTableViewModel.data.length < root.columnfreezeNum)
                            {
                                freezenum = root.columnfreezeNum + 1;
                            } else {
                                freezenum = 1;
                            }
                        }
                        console.log("freezenum: " + freezenum)
                        return freezenum;
                    }

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

//        Rectangle {
//            id: headerItem
//            y: itemviewScrol.contentY
//            anchors.left: parent.left
//            width: headerColumn.implicitWidth
//            height: headerColumn.implicitHeight
//            color: "transparent"

//            Column {
//                id: headerColumn
//                spacing: 0
//                readonly property alias datamodel: catgrayquickTableViewModel
//                readonly property alias viewScrol: itemviewScrol

//                Repeater {
//                    id: headerColumnRepeater
//                    model: root.columnfreezeNum

//                    Row {
//                        id: headerRow
//                        spacing: 0
//                        readonly property int columnRepeaterIndex: index
//                        readonly property var headerData: root.headerData

//                        Repeater {
//                            id: headerRowRepeater
//                            model: catgrayquickTableViewModel.headerCount
//                            delegate: root.headerDelegate
//                        }

//                    }

//                }
//            }

//        }

    }
}
