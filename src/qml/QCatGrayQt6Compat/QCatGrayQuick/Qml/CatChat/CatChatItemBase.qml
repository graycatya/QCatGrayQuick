import QtQuick 
import QtQuick.Layouts 
import QtQuick.Controls 

Item {
    id: root
    property color senderBgColor: "transparent"
    property color recipientBgColor: "transparent"
    property alias delegate: chatitemDelegate
    property var chatmodel: null
    readonly property bool isUser: (model.username === model.sender)

    Loader {
        id:chatitemDelegate
        anchors.fill: parent
        onStatusChanged: {
            console.log("chatitemDelegate loader status: " + chatitemDelegate.status)
        }
    }

}
