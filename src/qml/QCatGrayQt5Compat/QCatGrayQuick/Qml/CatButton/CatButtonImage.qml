﻿import QtQuick 2.9
import QtQuick.Controls 2.12
import "../CatGraphicalEffects"

Button {
    id: catbuttonimage
 

    property alias buttonMouse: buttonmouse
    property alias tipText: catbasictooltip.text
    property alias tipItem: catbasictooltip
    property alias tipVisible: catbasictooltip.visible
    property alias tipDelay: catbasictooltip.delay
    property alias tipTimeout: catbasictooltip.timeout
    property alias tipFont: catbasictooltip.font
    property alias tipTextColor: catbasictooltiptext.color
    property alias tipBackground: tooltiprectangle
    property alias backImage: backimage
    property bool selected: false
    property string btnImgNormal
    property string btnImgHovered
    property string btnImgPressed
    property string btnImgDisbaled

    property string btnImgUrl:  {
        if (!catbuttonimage.enabled) {
            return catbuttonimage.btnImgDisbaled
        } else if (catbuttonimage.pressed || catbuttonimage.selected) {
            return catbuttonimage.btnImgPressed
        } else if (catbuttonimage.hovered) {
            return catbuttonimage.btnImgHovered
        } else if (catbuttonimage.checked) {
            return catbuttonimage.btnImgPressed
        } else {
            return catbuttonimage.btnImgNormal
        }
    }

    property color backgroundColor: "#01000000"
    property color backgroundColor_pressed: "#01000000"
    property color backgroundColor_hovered: "#01000000"
    property alias imagebackground: catbuttonimagebackground

    ToolTip {
        id: catbasictooltip
        visible: catbuttonimage.hovered && String(text).length
        delay: 500
        contentItem: Text {
            id: catbasictooltiptext
            text: catbasictooltip.text
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.family: catbasictooltip.font.family
            font.pixelSize: catbasictooltip.font.pixelSize
            elide: Text.ElideRight
            //color: catbasictooltip.color
        }

        background: Rectangle {
            color: "transparent"
            Rectangle {
                id: tooltiprectangle
                anchors.fill: parent
            }
            CatDropShadow {
                anchors.fill: tooltiprectangle
                horizontalOffset: 2
                verticalOffset: 2
                radius: 4.0
                samples: 8
                color: "#50000000"
                source: tooltiprectangle
            }
        }
    }

    background: Rectangle {
        id: catbuttonimagebackground
        anchors.fill: parent
        color: {
            catbuttonimage.pressed ?
                        catbuttonimage.backgroundColor_pressed :
                        (catbuttonimage.hovered ?
                             catbuttonimage.backgroundColor_hovered :
                             catbuttonimage.backgroundColor)
        }
        Image {
            id: backimage
            anchors.centerIn: catbuttonimagebackground
            width: parent.width - (parent.border.width*2)
            height: parent.height - (parent.border.width*2)
            source: catbuttonimage.btnImgUrl
        }
    }

    MouseArea {
        id: buttonmouse
        anchors.fill: parent
        hoverEnabled: true
        propagateComposedEvents: true
        //鼠标图标， hovered 或者 pressed时显示此图标
        cursorShape: enabled ? Qt.PointingHandCursor : Qt.ForbiddenCursor
        onDoubleClicked: { mouse.accepted = false;}
        onPositionChanged: {
            if(mouse)
            {
                mouse.accepted = false;
            }
        }
        onPressed:  {  mouse.accepted = false; }
        onPressAndHold: { mouse.accepted = false; }
        onClicked:  { mouse.accepted = false;}
        onReleased: { mouse.accepted = false;}
        onWheel: { wheel.accepted = false; }
    }

}
