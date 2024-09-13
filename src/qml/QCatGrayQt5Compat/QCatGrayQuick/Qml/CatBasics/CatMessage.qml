import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import "../CatButton"

Item {
    id: root
    clip: false

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
        TopLeftDirection = 0,
        TopRightDirection = 1,
        TopCenterDirection = 2,
        LeftCenterDirection = 3,
        RightCenterDirection = 4,
        BottomCenterDirection = 5,
        BottomLeftDirection = 6,
        BottomRightDirection = 7
    }


    readonly property int parentWidth: parent.width
    readonly property int parentHeight: parent.height

    property url succeed_image: ""
    property url warning_image: ""
    property url information_image: ""
    property url errored_image: ""

    property int message_image_size: 16

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

    property int messagelayout_topMargin: 20
    property int messagelayout_bottomMargin: 20
    property int messagelayout_rightMargin: 20
    property int messagelayout_leftMargin: 20

    property int layoutDirection: CatMessage.TopLeft

    property bool showCloseButton: false
    property url close_button_image_Normal: ""
    property url close_button_image_Hovered: ""
    property url close_button_image_Pressed: ""
    property url close_button_image_Disbaled: ""
    property int close_button_image_size: 16

    width: parentWidth
    height: parentHeight
    z: parent.children.length

    ListModel {
        id: messageModel

        onCountChanged: {
            if(messageModel.count > 0)
            {
                if(removetimer.running)
                {
                    removetimer.stop()
                }
                removetimer.restart()
            }
        }
    }

    ListView {
        id: listview
        interactive: false

        anchors.fill: parent
        anchors.topMargin: root.topMargin
        anchors.bottomMargin: root.bottomMargin
        anchors.leftMargin: root.leftMargin
        anchors.rightMargin: root.rightMargin
        model: messageModel
        spacing: 10

        displaced: Transition {
            NumberAnimation { properties: "x"; duration: 300 }
            NumberAnimation { properties: "y"; duration: 300 }
        }

        delegate: Item {
            id: baseMessageItemParent
            width: root.message_width
            height: baseMessageItem.height
            Rectangle {

                id: baseMessageItem

                readonly property int currentindex: index
                property int removeindex: -1

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
                        Layout.preferredWidth: root.message_image_size
                        Layout.preferredHeight: root.message_image_size
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
                        Layout.preferredWidth: root.close_button_image_size
                        Layout.preferredHeight: root.close_button_image_size
                        visible: root.showCloseButton
                        btnImgNormal: root.close_button_image_Normal
                        btnImgHovered: root.close_button_image_Hovered
                        btnImgPressed: root.close_button_image_Pressed
                        btnImgDisbaled: root.close_button_image_Disbaled
                        onClicked: {
                            if(removetimer.running)
                            {
                                removetimer.stop()
                            }
                            baseMessageItem.removeindex = baseMessageItem.currentindex
                            baseMessageItem.removeupdateCoordinate()
                        }
                    }
                }

                Component.onDestruction: {

                }

                Component.onCompleted: {
                    initProperty()
                    addupdateCoordinate()

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
                        if(removetimer.running)
                        {
                            removetimer.stop()
                        }
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
                        if(messageModel.count > 0)
                        {
                            listview.model.remove(baseMessageItem.removeindex)
                            if(removetimer.running)
                            {
                                removetimer.stop()
                            }
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
                            messageimage.source = root.succeed_image
                            break;
                        }
                        case CatMessage.Warning: {
                            baseMessageItem.color = warning_back_color
                            baseMessageItem.border.color = warning_border_color
                            baseMessageItem.border.width = warning_border_width
                            baseMessageItem.radius = warning_back_radius
                            messagetest.color = message_text_warning_color
                            messageimage.source = root.warning_image
                            break;
                        }
                        case CatMessage.Information: {
                            baseMessageItem.color = information_back_color
                            baseMessageItem.border.color = information_border_color
                            baseMessageItem.border.width = information_border_width
                            baseMessageItem.radius = information_back_radius
                            messagetest.color = message_text_information_color
                            messageimage.source = root.information_image
                            break;
                        }
                        case CatMessage.Errored: {
                            baseMessageItem.color = errored_back_color
                            baseMessageItem.border.color = errored_border_color
                            baseMessageItem.border.width = errored_border_width
                            baseMessageItem.radius = errored_back_radius
                            messagetest.color = message_text_errored_color
                            messageimage.source = root.errored_image
                            break;
                        }
                    }
                }

                function addupdateCoordinate() {
                    switch(root.layoutDirection) {
                        case CatMessage.TopCenterDirection: {

                            baseMessageItemParent.anchors.horizontalCenter = baseMessageItemParent.parent.horizontalCenter

                            add_xAnimation.properties = ""
                            add_yAnimation.properties = "y"
                            add_yAnimation.from = - baseMessageItem.height
                            add_yAnimation.to =  0
                            add_opacityAnimation.properties = "opacity"
                            add_opacityAnimation.from = 0
                            add_opacityAnimation.to = 1
                            addparallelanimation.restart()

                            break;
                        }
                        case CatMessage.BottomCenterDirection: {
                            baseMessageItemParent.anchors.horizontalCenter = baseMessageItemParent.parent.horizontalCenter

                            add_xAnimation.properties = ""
                            add_yAnimation.properties = "y"
                            add_yAnimation.from = baseMessageItem.height
                            add_yAnimation.to =  0
                            add_opacityAnimation.properties = "opacity"
                            add_opacityAnimation.from = 0
                            add_opacityAnimation.to = 1
                            addparallelanimation.restart()
                            break;
                        }
                        case CatMessage.TopLeftDirection: {
                            baseMessageItemParent.anchors.left = baseMessageItemParent.parent.left

                            add_xAnimation.properties = ""
                            add_yAnimation.properties = "y"
                            add_yAnimation.from = - baseMessageItem.height
                            add_yAnimation.to =  0
                            add_opacityAnimation.properties = "opacity"
                            add_opacityAnimation.from = 0
                            add_opacityAnimation.to = 1
                            addparallelanimation.restart()
                            break;
                        }
                        case CatMessage.TopRightDirection: {
                            baseMessageItemParent.anchors.right = baseMessageItemParent.parent.right

                            add_xAnimation.properties = ""
                            add_yAnimation.properties = "y"
                            add_yAnimation.from = - baseMessageItem.height
                            add_yAnimation.to =  0
                            add_opacityAnimation.properties = "opacity"
                            add_opacityAnimation.from = 0
                            add_opacityAnimation.to = 1
                            addparallelanimation.restart()
                            break;
                        }
                        case CatMessage.BottomLeftDirection: {
                            baseMessageItemParent.anchors.left = baseMessageItemParent.parent.left

                            add_xAnimation.properties = ""
                            add_yAnimation.properties = "y"
                            add_yAnimation.from = baseMessageItem.height
                            add_yAnimation.to =  0
                            add_opacityAnimation.properties = "opacity"
                            add_opacityAnimation.from = 0
                            add_opacityAnimation.to = 1
                            addparallelanimation.restart()
                            break;
                        }
                        case CatMessage.BottomRightDirection: {
                            baseMessageItemParent.anchors.right = baseMessageItemParent.parent.right

                            add_xAnimation.properties = ""
                            add_yAnimation.properties = "y"
                            add_yAnimation.from = baseMessageItem.height
                            add_yAnimation.to =  0
                            add_opacityAnimation.properties = "opacity"
                            add_opacityAnimation.from = 0
                            add_opacityAnimation.to = 1
                            addparallelanimation.restart()
                            break;
                        }
                        case CatMessage.RightCenterDirection: {
                            baseMessageItemParent.anchors.verticalCenter = baseMessageItemParent.parent.verticalCenter

                            add_xAnimation.properties = "x"
                            add_xAnimation.from = baseMessageItem.width
                            add_xAnimation.to =  0
                            add_yAnimation.properties = ""
                            add_opacityAnimation.properties = "opacity"
                            add_opacityAnimation.from = 0
                            add_opacityAnimation.to = 1
                            addparallelanimation.restart()
                            break;
                        }
                        case CatMessage.LeftCenterDirection: {
                            baseMessageItemParent.anchors.verticalCenter = baseMessageItemParent.parent.verticalCenter

                            add_xAnimation.properties = "x"
                            add_xAnimation.from = - baseMessageItem.width
                            add_xAnimation.to =  0
                            add_yAnimation.properties = ""
                            add_opacityAnimation.properties = "opacity"
                            add_opacityAnimation.from = 0
                            add_opacityAnimation.to = 1
                            addparallelanimation.restart()
                            break;
                        }
                    }
                }

                function removeupdateCoordinate() {
                    switch(root.layoutDirection) {
                        case CatMessage.TopCenterDirection:
                        case CatMessage.TopLeftDirection:
                        case CatMessage.TopRightDirection:
                        {
                            remove_xAnimation.properties = ""
                            remove_yAnimation.properties = "y"
                            remove_yAnimation.from = 0
                            remove_yAnimation.to =  - baseMessageItem.height
                            remove_opacityAnimation.properties = "opacity"
                            remove_opacityAnimation.from = 1
                            remove_opacityAnimation.to = 0
                            removeparallelanimation.restart()
                            break;
                        }
                        case CatMessage.BottomCenterDirection:
                        case CatMessage.BottomLeftDirection:
                        case CatMessage.BottomRightDirection:
                        {
                            remove_xAnimation.properties = ""
                            remove_yAnimation.properties = "y"
                            remove_yAnimation.from = 0
                            remove_yAnimation.to =  baseMessageItem.height

                            remove_opacityAnimation.properties = "opacity"
                            remove_opacityAnimation.from = 1
                            remove_opacityAnimation.to = 0
                            removeparallelanimation.restart()
                            break;
                        }
                        case CatMessage.RightCenterDirection:
                        {
                            remove_xAnimation.properties = "x"
                            remove_xAnimation.from = 0
                            remove_xAnimation.to =  baseMessageItem.width
                            remove_yAnimation.properties = ""
                            remove_opacityAnimation.properties = "opacity"
                            remove_opacityAnimation.from = 1
                            remove_opacityAnimation.to = 0
                            removeparallelanimation.restart()
                            break;
                        }
                        case CatMessage.LeftCenterDirection:
                        {
                            remove_xAnimation.properties = "x"
                            remove_xAnimation.from = 0
                            remove_xAnimation.to =  - baseMessageItem.width
                            remove_yAnimation.properties = ""
                            remove_opacityAnimation.properties = "opacity"
                            remove_opacityAnimation.from = 1
                            remove_opacityAnimation.to = 0
                            removeparallelanimation.restart()
                            break;
                        }
                    }
                }

                Connections {
                    target: removetimer
                    function onRemoveTrigered(removeindex) {
                        baseMessageItem.removeindex = removeindex
                        if(removeindex === baseMessageItem.currentindex)
                        {
                            baseMessageItem.removeupdateCoordinate()
                        }
                    }
                }
            }
        }
    }

    onLayoutDirectionChanged: {
        switch(root.layoutDirection) {
            case CatMessage.TopCenterDirection:
            case CatMessage.TopLeftDirection:
            case CatMessage.TopRightDirection:
            {
                listview.orientation = ListView.Vertical
                listview.verticalLayoutDirection = ListView.TopToBottom
                break;
            }
            case CatMessage.BottomCenterDirection:
            case CatMessage.BottomLeftDirection:
            case CatMessage.BottomRightDirection:
            {
                listview.orientation = ListView.Vertical
                listview.verticalLayoutDirection = ListView.BottomToTop
                break;
            }
            case CatMessage.RightCenterDirection:
            {
                listview.orientation = ListView.Horizontal
                listview.layoutDirection = ListView.RightToLeft
                break;
            }
            case CatMessage.LeftCenterDirection:
            {
                listview.orientation = ListView.Horizontal
                listview.layoutDirection = ListView.LeftToRight
                break;
            }
        }
    }

    Timer {
        id: removetimer
        interval: 2000
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
