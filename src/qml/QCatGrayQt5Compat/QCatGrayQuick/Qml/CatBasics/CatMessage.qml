import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import "../CatButton"

Item {
    id: root

    readonly property int parentWidth: parent.width
    readonly property int parentHeight: parent.height

    width: parentWidth
    height: parentHeight
    z: parent.children.length

    enum MessageOrientation {
        Horizontal,
        Vertical
    }

    enum MessageLayoutDirection {
        TopToBottom,
        BottomToTop,
        LeftToRight,
        RightToLeft
    }

    enum MessageType {
        Succeed,
        Warning,
        Information,
        Errored
    }

    property int messageOrientation: CatMessage.Vertical
    property int messageLayoutDirection: CatMessage.TopToBottom
    property int spacing: 10

    ListModel {
        id: messageModel
        ListElement {
            images: "qrc://test"
            message: "test-message"
            type: ""
        }
        ListElement {
            images: "qrc://test"
            message: "test-message"
            type: ""
        }
        ListElement {
            images: "qrc://test"
            message: "test-message"
            type: ""
        }
        ListElement {
            images: "qrc://test"
            message: "test-message"
            type: ""
        }
    }

    Repeater {
        id: repeater
        model: messageModel
        anchors.fill: parent

        delegate: Rectangle {
            id: baseMessageItem
            x: 0
            y: index * 60
            width: 100
            height: rowlayout.implicitHeight
            color: 'blue'
            radius: 5
            RowLayout {
                id: rowlayout
                spacing: 10
                anchors.fill: parent
                Image {

                }
                Text {

                }
                CatButtonImage {

                }
            }

            Component.onDestruction: {
                console.log("dest: " + index)
            }
            Component.onCompleted: {
                console.log("comp: " + index)
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

    function message(message, messagetype) {

    }

}
