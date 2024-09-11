import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import "../CatButton"

Item {
    id: root
    clip: true

    FontMetrics {
        id: fontmetrics
    }

    enum MessageType {
        Succeed = 0,
        Warning,
        Information,
        Errored
    }

    enum LayoutDirection {
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

    property color succeed_back_color: "#00000000"
    property color warning_back_color: "#00000000"
    property color information_back_color: "#00000000"
    property color errored_back_color: "#00000000"

    property color succeed_border_color: "#00000000"
    property color warning_border_color: "#00000000"
    property color information_border_color: "#00000000"
    property color errored_border_color: "#00000000"

    property int succeed_border_width: 0
    property int warning_border_width: 0
    property int information_border_width: 0
    property int errored_border_width: 0

    property int succeed_back_radius: 0
    property int warning_back_radius: 0
    property int information_back_radius: 0
    property int errored_back_radius: 0

    property alias message_font: fontmetrics.font

    property color message_text_succeed_color: "#00000000"
    property color message_text_warning_color: "#00000000"
    property color message_text_information_color: "#00000000"
    property color message_text_errored_color: "#00000000"

    property int message_width: 100

    property int spacing: 10

    property int topMargin: 10
    property int bottomMargin: 10
    property int rightMargin: 10
    property int leftMargin: 10

    property int messagelayout_topMargin: 10
    property int messagelayout_bottomMargin: 10
    property int messagelayout_rightMargin: 10
    property int messagelayout_leftMargin: 10

    property int layoutDirection: CatMessage.TopCenter

    width: parentWidth
    height: parentHeight
    z: parent.children.length

    ListModel {
        id: messageModel
    }

    Repeater {
        id: repeater
        model: messageModel
        anchors.fill: parent
        clip: true

        delegate: Rectangle {

            id: baseMessageItem

            readonly property int currentindex: index
            property bool isinit: false

            //anchors.horizontalCenter: parent.horizontalCenter
            width: root.message_width
            height: rowlayout.implicitHeight + rowlayout.anchors.topMargin + rowlayout.anchors.bottomMargin
            color: "#00000000"

            RowLayout {
                id: rowlayout
                spacing: root.spacing
                anchors.fill: parent
                anchors.topMargin: root.messagelayout_topMargin
                anchors.bottomMargin: root.messagelayout_bottomMargin
                anchors.leftMargin: root.messagelayout_leftMargin
                anchors.rightMargin: root.messagelayout_rightMargin

                Image {
                    id: messageimage
                    Layout.minimumWidth: 16
                    Layout.minimumHeight: 16
                }
                Text {
                    id: messagetest
                    text: message
                    font: root.message_font
                    wrapMode: Text.WordWrap
                    Layout.minimumWidth: 50
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    textFormat: parseInt(messagetextFormat)

                }
                CatButtonImage {
                    id: messagecloseButton
                    Layout.minimumWidth: 16
                    Layout.minimumHeight: 16
                }
            }

            onCurrentindexChanged: {
                console.log("onCurrentindexChanged: " + currentindex)
                if(baseMessageItem.isinit)
                {
                    updateCoordinate()
                }
            }

            Component.onDestruction: {
                console.log("dest: " + currentindex)
            }

            Component.onCompleted: {
                console.log("comp: " + currentindex)
                initProperty()
                addupdateCoordinate()
                baseMessageItem.isinit = true

            }

            ParallelAnimation {
                id: addparallelanimation

                NumberAnimation {
                    id: add_xAnimation
                    target: baseMessageItem
                    duration: 300
                }
                NumberAnimation {
                    id: add_yAnimation
                    target: baseMessageItem
                    duration: 300
                }
                NumberAnimation {
                    id: add_opacityAnimation
                    target: baseMessageItem
                    duration: 300
                }

                onFinished: {
                    removetimer.restart()
                }
            }

            ParallelAnimation {
                id: removeparallelanimation

                NumberAnimation {
                    id: remove_xAnimation
                    target: baseMessageItem
                    duration: 300
                }
                NumberAnimation {
                    id: remove_yAnimation
                    target: baseMessageItem
                    duration: 300
                }
                NumberAnimation {
                    id: remove_opacityAnimation
                    target: baseMessageItem
                    duration: 300
                }

                onFinished: {
                    console.log("removeparallelanimation: " + currentindex)
                    console.log("messageModel: " + messageModel.count)
                    if(messageModel.count > 0)
                    {
                        messageModel.remove(0)
                    }
                }
            }

            ParallelAnimation {
                id: updateparallelanimation

                NumberAnimation {
                    id: update_xAnimation
                    target: baseMessageItem
                    duration: 300
                }
                NumberAnimation {
                    id: update_yAnimation
                    target: baseMessageItem
                    duration: 300
                }
                NumberAnimation {
                    id: update_opacityAnimation
                    target: baseMessageItem
                    duration: 300
                }

                onFinished: {
                    if(messageModel.count > 0 &&
                            baseMessageItem.currentindex === 0)
                    {
                        removetimer.restart()
                    }
                }
            }

            function initProperty() {
                switch(messageType) {
                    case CatMessage.Succeed: {
                        baseMessageItem.color = succeed_back_color
                        baseMessageItem.border.color = succeed_border_color
                        baseMessageItem.border.width = succeed_border_width
                        baseMessageItem.radius = succeed_back_radius
                        messagetest.color = message_text_succeed_color
                        break;
                    }
                    case CatMessage.Warning: {
                        baseMessageItem.color = warning_back_color
                        baseMessageItem.border.color = warning_border_color
                        baseMessageItem.border.width = warning_border_width
                        baseMessageItem.radius = warning_back_radius
                        messagetest.color = message_text_warning_color
                        break;
                    }
                    case CatMessage.Information: {
                        baseMessageItem.color = information_back_color
                        baseMessageItem.border.color = information_border_color
                        baseMessageItem.border.width = information_border_width
                        baseMessageItem.radius = information_back_radius
                        messagetest.color = message_text_information_color
                        break;
                    }
                    case CatMessage.Errored: {
                        baseMessageItem.color = errored_back_color
                        baseMessageItem.border.color = errored_border_color
                        baseMessageItem.border.width = errored_border_width
                        baseMessageItem.radius = errored_back_radius
                        messagetest.color = message_text_errored_color
                        break;
                    }
                }
            }

            function addupdateCoordinate() {
                switch(root.layoutDirection) {
                    case CatMessage.TopCenter: {
                        add_xAnimation.properties = ""
                        add_yAnimation.properties = "y"
                        baseMessageItem.anchors.horizontalCenter = parent.horizontalCenter
                        add_yAnimation.from = currentindex <= 0 ? 0 - baseMessageItem.height
                                                             : repeater.itemAt(currentindex - 1).y + repeater.itemAt(currentindex - 1).height - baseMessageItem.height
                        add_yAnimation.to = currentindex <= 0 ? topMargin
                                                           : topMargin + repeater.itemAt(currentindex - 1).y + baseMessageItem.height
                        add_opacityAnimation.properties = "opacity"
                        add_opacityAnimation.from = 0
                        add_opacityAnimation.to = 1
                        addparallelanimation.restart()

                        break;
                    }
                    case CatMessage.BottomCenter: {
                        baseMessageItem.anchors.horizontalCenter = parent.horizontalCenter
                        break;
                    }
                }
            }

            function removeupdateCoordinate() {
                switch(root.layoutDirection) {
                    case CatMessage.TopCenter: {
                        remove_xAnimation.properties = ""
                        remove_yAnimation.properties = "y"
                        baseMessageItem.anchors.horizontalCenter = parent.horizontalCenter
                        remove_yAnimation.from = currentindex <= 0 ? topMargin
                                                             : topMargin + repeater.itemAt(currentindex - 1).y + baseMessageItem.height
                        remove_yAnimation.to = currentindex <= 0 ? 0 - baseMessageItem.height
                                                           : repeater.itemAt(currentindex - 1).y + repeater.itemAt(currentindex - 1).height - baseMessageItem.height
                        remove_opacityAnimation.properties = "opacity"
                        remove_opacityAnimation.from = 1
                        remove_opacityAnimation.to = 0
                        removeparallelanimation.restart()

                        break;
                    }
                    case CatMessage.BottomCenter: {
                        baseMessageItem.anchors.horizontalCenter = parent.horizontalCenter
                        break;
                    }
                }
            }

            function updateCoordinate() {
                switch(root.layoutDirection) {
                    case CatMessage.TopCenter: {
                        update_xAnimation.properties = ""
                        update_yAnimation.properties = "y"
                        baseMessageItem.anchors.horizontalCenter = parent.horizontalCenter
                        update_yAnimation.from = currentindex <= 0 ? baseMessageItem.y
                                                             : topMargin + repeater.itemAt(currentindex - 1).y + baseMessageItem.height
                        update_yAnimation.to = currentindex <= 0 ? topMargin
                                                           : repeater.itemAt(currentindex - 1).y + repeater.itemAt(currentindex - 1).height - baseMessageItem.height
                        update_opacityAnimation.properties = ""
                        updateparallelanimation.restart()

                        break;
                    }
                    case CatMessage.BottomCenter: {
                        baseMessageItem.anchors.horizontalCenter = parent.horizontalCenter
                        break;
                    }
                }
            }

            Connections {
                target: removetimer
                function onRemoveTrigered(removeindex) {
                    console.log("removeindex: " + removeindex)
                    if(removeindex === baseMessageItem.currentindex)
                    {
                        removeupdateCoordinate()
                    }
                }
            }
        }
    }

    Timer {
        id: removetimer
        interval: 3000
//        running: true
        signal removeTrigered(var removeindex)
        onTriggered: {
            removetimer.removeTrigered(0)
        }

    }

    function message(message,
                     messagetype = CatMessage.Succeed,
                     messagetextFormat = Text.AutoText) {
        if(removetimer.running)
        {
            removetimer.stop()
        }
        messageModel.append({"message": message,
                            "messageType": parseInt(messagetype),
                            "messagetextFormat": parseInt(messagetextFormat)})

    }

}
