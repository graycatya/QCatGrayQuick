import QtQuick 2.12
import QtQuick.Layouts 1.12
import com.catgray.QCatGrayQuickTableViewModel 1.0
import com.catgray.QCatGrayQuickTableViewModelStruct 1.0
import com.catgray.QCatGrayQuickTableViewHeaderStruct 1.0
import "../QCatGrayQuickMethod.js" as QCatGrayQuickMethod

Item {
    id: root
    clip: true
    readonly property bool isNotNull: parent != null
    readonly property int columnIndex: isNotNull ? parent.columnRepeaterIndex : 0
    readonly property int rowIndex: isNotNull ? index : 0
    readonly property bool isheaderFreeze: columnIndex == 0
    readonly property var datamodel: isNotNull ?
                                         parent.parent ? parent.parent.datamodel : null : null
    readonly property QCatGrayQuickTableViewHeaderStruct headerStruct: isNotNull ?
                                                                           datamodel ?
                                                                               datamodel.getHeaderStruct(columnIndex) : null : null
    readonly property var headerData: isNotNull ? parent.headerData : null
    readonly property var viewScrol: isNotNull ?
                                         parent.parent ? parent.parent.viewScrol : null : null
    property alias source : loader.source
    property alias sourceComponent : loader.sourceComponent
    property int lastwidth: 0

    width: datamodel !== null ? datamodel.getHeaderStruct(rowIndex).preferredWidth : 0
    height: datamodel !== null ? datamodel.preferredHeaderHeight : 0

    //property bool isadd: false

    Loader {
        id: loader
        objectName: "headerLoader"
        readonly property int columnIndex: root.columnIndex
        readonly property int rowIndex: root.rowIndex
        readonly property int index: root.rowIndex
        readonly property var datamodel: isNotNull ?
                                             parent.parent.parent ? parent.parent.parent.datamodel : null : null
        anchors.fill: parent
    }

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
        visible: datamodel !== null ?
                     datamodel.getHeaderStruct(rowIndex).resizeMode === QCatGrayQuickTableViewHeaderStruct.FixedCanBeManuallyAdjusted : false

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            propagateComposedEvents: true

            onPositionChanged: {
                if(pressed)
                {
                    var loastwidthmove = datamodel.getHeaderStruct(rowIndex).preferredWidth  - root.lastwidth;
                    var twidth = datamodel.getHeaderStruct(rowIndex).preferredWidth;
                    var movex = mouseX - rightrect.lastmouseX + loastwidthmove;
                    rightrect.lastmouseX = mouseX;
                    rightrect.lastmouseY = mouseY;
                    if(movex != 0)
                    {
                        root.lastwidth = root.width;
                        datamodel.getHeaderStruct(rowIndex).preferredWidth = twidth + movex
                        datamodel.updateHeaderStruct();
                    }
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
                datamodel.restoreOverrideCursor();
            }
            onEntered: {
                datamodel.setOverrideCursor(Qt.SizeHorCursor);
            }
            onExited: {
                if(!pressed)
                {
                    datamodel.restoreOverrideCursor();
                }
            }
        }
    }

    Component.onDestruction: {
        root.source = ""
        root.sourceComponent = null
    }
}
