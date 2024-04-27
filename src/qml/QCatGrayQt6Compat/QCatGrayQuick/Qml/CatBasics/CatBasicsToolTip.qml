﻿import QtQuick
import QtQuick.Controls

ToolTip {
 
    id: catbasictooltip
    contentItem: CatBasicsText {
        text: catbasictooltip.text
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.family: catbasictooltip.font.family
        font.pixelSize: catbasictooltip.font.pixelSize
        elide: Text.ElideRight
        color: catbasictooltip.color
    }

    background: Rectangle {
        id: tooltiprectangle
    }
}
