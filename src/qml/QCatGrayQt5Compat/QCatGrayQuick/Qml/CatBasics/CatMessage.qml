import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import "../CatButton"

Item {
    id: root

    FontMetrics {
        id: fontmetrics
    }

    enum MessageOrientation {
        Horizontal = 0,
        Vertical
    }

    enum MessageLayoutDirection {
        TopToBottom = 0,
        BottomToTop,
        LeftToRight,
        RightToLeft
    }

    enum MessageType {
        Succeed = 0,
        Warning,
        Information,
        Errored
    }

    enum AnchorsLayout {
        TopLeft = 0,
        TopRight,
        TopCenter,
        LeftCenter,
        RightCenter,
        BottomCenter,
        BottomLeft,
        BottomRight
    }


    readonly property int parentWidth: parent.width
    readonly property int parentHeight: parent.height

    property color succeed_backcolor: "#00000000"
    property color warning_backcolor: "#00000000"
    property color information_backcolor: "#00000000"
    property color errored_backcolor: "#00000000"

    property color succeed_bordercolor: "#00000000"
    property color warning_bordercolor: "#00000000"
    property color information_bordercolor: "#00000000"
    property color errored_bordercolor: "#00000000"

    property int succeed_borderwidth: 0
    property int warning_borderwidth: 0
    property int information_borderwidth: 0
    property int errored_borderwidth: 0

    property int succeed_backradius: 0
    property int warning_backradius: 0
    property int information_backradius: 0
    property int errored_backradius: 0

    property alias message_font: fontmetrics.font
    property color message_color: "#00000000"
    property int message_width: 100

    property int messageOrientation: CatMessage.Vertical
    property int messageLayoutDirection: CatMessage.TopToBottom
    property int spacing: 10

    width: parentWidth
    height: parentHeight
    z: parent.children.length

    ListModel {
        id: messageModel
        ListElement {
            message: "test-message"
            messageType: 0
            messagetextFormat: 0
        }
    }

    Repeater {
        id: repeater
        model: messageModel
        anchors.fill: parent
        delegate: Rectangle {

            id: baseMessageItem

            readonly property int currentindex: index

            anchors.horizontalCenter: parent.horizontalCenter
            width: root.message_width
            height: rowlayout.implicitHeight
            color: "#00000000"

            RowLayout {
                id: rowlayout
                spacing: root.spacing
                anchors.fill: parent
                Image {
                    id: messageimage
                }
                Text {
                    id: messagetest
                    text: message
                    font: root.message_font
                    color: root.message_color
                }
                CatButtonImage {
                    id: messagecloseButton
                }
            }

            onCurrentindexChanged: {
                console.log("onCurrentindexChanged: " + currentindex)
            }

            Component.onDestruction: {
                console.log("dest: " + currentindex)
            }

            Component.onCompleted: {
                initProperty()

            }

            function initProperty() {
                switch(messageType) {
                    case CatMessage.Succeed: {
                        baseMessageItem.color = succeed_backcolor
                        baseMessageItem.border.color = succeed_bordercolor
                        baseMessageItem.border.width = succeed_borderwidth
                        break;
                    }
                    case CatMessage.Warning: {
                        baseMessageItem.color = warning_backcolor
                        baseMessageItem.border.color = warning_bordercolor
                        baseMessageItem.border.width = warning_borderwidth
                        break;
                    }
                    case CatMessage.Information: {
                        baseMessageItem.color = information_backcolor
                        baseMessageItem.border.color = information_bordercolor
                        baseMessageItem.border.width = information_borderwidth
                        break;
                    }
                    case CatMessage.Errored: {
                        baseMessageItem.color = errored_backcolor
                        baseMessageItem.border.color = errored_bordercolor
                        baseMessageItem.border.width = errored_borderwidth
                        break;
                    }
                }
            }
        }
    }

    Timer {
        id: timer
        interval: 2000
        running: true
        onTriggered: {

            messageModel.remove(0);

        }

    }

    function message(message, messagetype = CatMessage.Succeed) {

    }

}
