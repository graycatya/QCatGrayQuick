import QtQuick 
import QtQuick.Layouts 
import com.catgray.QCatGrayQuickTableViewModel 
import com.catgray.QCatGrayQuickTableViewModelStruct 
import com.catgray.QCatGrayQuickTableViewHeaderStruct 

Item {
    id: root
    clip: true
    readonly property int rowIndex: index
    property var datamodel: null
    property QCatGrayQuickTableViewHeaderStruct headerStruct: null
    property var headerTableData: null

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

            onPositionChanged: (mouse)=> {
                if(pressed)
                {
                    datamodel.interactive = false
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
            onPressed: (mouse)=> {
                datamodel.interactive = false
                datamodel.setOverrideCursor(Qt.SizeHorCursor);
                rightrect.lastmouseX = mouseX;
                rightrect.lastmouseY = mouseY;
                root.lastwidth = root.width
                mouse.accepted = true

            }
            onReleased: {
                datamodel.interactive = true
                datamodel.setOverrideCursor(Qt.ArrowCursor);
            }
            onEntered: {
                datamodel.interactive = false
                datamodel.setOverrideCursor(Qt.SizeHorCursor);
            }
            onExited: {
                if(!pressed)
                {
                    datamodel.interactive = true
                    datamodel.setOverrideCursor(Qt.ArrowCursor);
                }
            }
        }

        Component.onCompleted: {
            if(datamodel.headerTableData.length-1 === rowIndex)
            {
                datamodel.updateHeaderStruct()
            }
        }
    }

}
