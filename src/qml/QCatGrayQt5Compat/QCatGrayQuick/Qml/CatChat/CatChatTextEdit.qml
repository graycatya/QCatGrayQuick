import QtQuick 2.12
import QtQuick.Controls 2.12

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
