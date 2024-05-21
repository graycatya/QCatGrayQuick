import QtQuick 2.12
import QtQuick.Controls 2.12


Item {
    id: root
    property alias chatviewRepeater: viewRepeater
    property alias chatviewDelegate: viewRepeater.delegate
    property alias chatviewLayout: viewLayout
    property alias chatviewScrol: viewScrol

    ScrollView {
        id: viewScrol
        Column {
            id: viewLayout
            spacing: 5
            anchors.fill: parent
            Repeater {
                id: viewRepeater

            }
        }
    }
}
