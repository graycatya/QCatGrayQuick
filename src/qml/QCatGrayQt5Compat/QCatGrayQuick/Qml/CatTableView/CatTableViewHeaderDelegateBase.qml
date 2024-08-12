import QtQuick 2.12
import QtQuick.Layouts 1.12
import com.catgray.QCatGrayQuickTableViewModel 1.0
import com.catgray.QCatGrayQuickTableViewModelStruct 1.0
import com.catgray.QCatGrayQuickTableViewHeaderStruct 1.0
import "../QCatGrayQuickMethod.js" as QCatGrayQuickMethod

Item {
    id: root
    clip: true
    readonly property int rowIndex: index
    property var datamodel: null
    property QCatGrayQuickTableViewHeaderStruct headerStruct: null
    property var headerTableData: null
    readonly property var viewScrol: parent.parent ? parent.parent : null

    property int lastwidth: 0

    width: headerStruct !== null ? headerStruct.preferredWidth : 0
    height: datamodel !== null ? datamodel.preferredHeaderHeight : 0

    //property bool isadd: false

    Rectangle {
        id: rightrect
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        width: 4
        //z: 99999
        color: "#01FFFFFF"
        property real lastmouseX: 0
        property real lastmouseY: 0
        visible: headerStruct !== null ?
                     headerStruct.resizeMode === QCatGrayQuickTableViewHeaderStruct.FixedCanBeManuallyAdjusted : false

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            propagateComposedEvents: true

            onPositionChanged: {
                if(pressed)
                {
                    var loastwidthmove = headerStruct.preferredWidth  - root.lastwidth;
                    var twidth = headerStruct.preferredWidth;
                    var movex = mouseX - rightrect.lastmouseX + loastwidthmove;
                    rightrect.lastmouseX = mouseX;
                    rightrect.lastmouseY = mouseY;
                    if(movex != 0)
                    {
                        root.lastwidth = root.width;
                        headerStruct.preferredWidth = twidth + movex
                        datamodel.updateHeaderStruct();
                    }
                    mouse.accepted = true
                }
            }
            onPressed:  {
                datamodel.setOverrideCursor(Qt.SizeHorCursor);
                rightrect.lastmouseX = mouseX;
                rightrect.lastmouseY = mouseY;
                root.lastwidth = root.width
                viewScrol.interactive = false
                mouse.accepted = true

            }
            onReleased: {
                viewScrol.interactive = true
                datamodel.setOverrideCursor(Qt.ArrowCursor);
                //datamodel.restoreOverrideCursor();
            }
            onEntered: {
                viewScrol.interactive = false
                datamodel.setOverrideCursor(Qt.SizeHorCursor);
                //datamodel.restoreOverrideCursor();
            }
            onExited: {
                if(!pressed)
                {
                    viewScrol.interactive = true
                    datamodel.setOverrideCursor(Qt.ArrowCursor);
                    //datamodel.restoreOverrideCursor();
                }
            }
        }
    }

//    Component.onDestruction: {
//        root.source = ""
//        root.sourceComponent = null
//    }
}
