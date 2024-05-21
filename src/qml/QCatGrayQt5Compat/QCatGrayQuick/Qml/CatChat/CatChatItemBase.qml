import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

Item {
    property color senderBgColor: SystemPalette.base
    property color recipientBgColor: SystemPalette.base

    readonly property bool isSender: (model.sender === model.recipient)

}
