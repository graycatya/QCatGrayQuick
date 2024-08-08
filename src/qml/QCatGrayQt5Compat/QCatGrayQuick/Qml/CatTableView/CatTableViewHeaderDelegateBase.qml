import QtQuick 2.12
import QtQuick.Layouts 1.12
import com.catgray.QCatGrayQuickTableViewModel 1.0
import com.catgray.QCatGrayQuickTableViewModelStruct 1.0
import com.catgray.QCatGrayQuickTableViewHeaderStruct 1.0

Item {
    id: root
    readonly property int columnIndex: parent.columnRepeaterIndex
    readonly property int rowIndex: index
    readonly property bool isheaderFreeze: columnIndex == 0
    readonly property var model: parent.parent.datamodel
    readonly property QCatGrayQuickTableViewHeaderStruct headerStruct: model.getHeaderStruct(columnIndex)
    readonly property var headerData: parent.headerData
    readonly property var viewScrol: parent.parent.viewScrol
//    Connections {
//        target: model.getHeaderStruct(rowIndex)
//        function onPreferredWidthChanged() {
//            root.width = model.getHeaderStruct(columnIndex).preferredWidth
//        }
//    }
    width: model.getHeaderStruct(rowIndex).preferredWidth
    height: model.preferredHeaderHeight

    // Rectangle {
    //     anchors.top: parent.top
    //     anchors.bottom: parent.bottom
    //     anchors.left: parent.left
    //     width: 2
    //     z: 99999
    //     color: "#FFFFFF"
    //     MouseArea {
    //         anchors.fill: parent
    //         hoverEnabled: true
    //         propagateComposedEvents: true
    //         onDoubleClicked: { mouse.accepted = false;}
    //         onPositionChanged: { mouse.accepted = false;}
    //         onPressed:  {  mouse.accepted = false; }
    //         onPressAndHold: { mouse.accepted = false; }
    //         onClicked:  { mouse.accepted = false;}
    //         onReleased: { mouse.accepted = false;}
    //         onWheel: { wheel.accepted = false; }
    //         onEntered: { cursorShape = Qt.SizeHorCursor }
    //         onExited: { cursorShape = Qt.ArrowCursor }
    //     }
    // }

    Rectangle {
        id: rightrect
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        width: 2
        z: 99999
        color: "#01FFFFFF"
        property real lastmouseX: 0
        property real lastmouseY: 0
        visible: model.getHeaderStruct(rowIndex).resizeMode === QCatGrayQuickTableViewHeaderStruct.FixedCanBeManuallyAdjusted
        onFocusChanged: {
            console.log("rightrect.focus: " + rightrect.focus)
        }
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            propagateComposedEvents: false
            //propagateComposedEvents: true
            // drag.target: parent
            // onPositionChanged: {
            //     mouse.accepted = false;
            //     if (parent.drag.active) {
            //         parent.x = dragArea.x - (parent.width / 2);
            //         parent.y = dragArea.y - (parent.height / 2);
            //     }
            // }
            onPositionChanged: {
                if(pressed)
                {
                    model.setOverrideCursor(Qt.SizeHorCursor);
                    //console.log("onPositionChanged:"+(mouseX - rightrect.lastmouseX)+":"+(mouseY - rightrect.lastmouseY))
                    model.getHeaderStruct(rowIndex).preferredWidth = model.getHeaderStruct(rowIndex).preferredWidth + (mouseX - rightrect.lastmouseX)
                    rightrect.lastmouseX = mouseX;
                    rightrect.lastmouseY = mouseY;
                }
                mouse.accepted = true
            }
            onPressed:  {
                rightrect.lastmouseX = mouseX;
                rightrect.lastmouseY = mouseY;
                mouse.accepted = true
                viewScrol.interactive = false
            }
            onReleased: {
                viewScrol.interactive = true
                model.setOverrideCursor(Qt.ArrowCursor);
            }
            onEntered: {
                model.setOverrideCursor(Qt.SizeHorCursor);
            }
            onExited: {
                if(!containsPress)
                {
                    model.setOverrideCursor(Qt.ArrowCursor);
                }
            }
        }
    }
}
