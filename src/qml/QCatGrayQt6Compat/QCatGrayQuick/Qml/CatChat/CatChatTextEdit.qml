import QtQuick 
import QtQuick.Controls 

TextEdit {
    id: root
    readonly property alias textWidth: textprivate.implicitWidth
    readonly property alias textHeight: textprivate.implicitHeight
    Text {
        id: textprivate
        visible: false
        font: root.font
        padding: root.padding
        text: root.text
    }

}
