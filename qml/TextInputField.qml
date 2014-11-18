import QtQuick 2.0

Rectangle {
    id: root
    radius: 2
    border.color: input.activeFocus ? "#428bca" : "#999999"
    border.width: input.activeFocus ? 2 : 1
    color: "#ffffff"

    signal accepted(string text)
    property alias text: input.text
    property alias placeholderText: placeholder.text
    property bool password: false

    function forceActiveFocus()
    {
        input.forceActiveFocus()
        input.selectAll()
    }

    TextInput {
        id: input
        anchors.fill: parent
        anchors.margins: parent.height * 0.2
        verticalAlignment: Text.AlignVCenter
        activeFocusOnPress: true
        cursorVisible: activeFocus || focus
        onAccepted: root.accepted(text)
        echoMode: root.password ? TextInput.Password : TextInput.Normal
        font.pixelSize: height*.8
        inputMethodHints: Qt.ImhNoPredictiveText
        clip: true
    }

    Text {
        id: placeholder
        anchors.fill: parent
        anchors.margins: parent.height * 0.2
        color: "#cccccc"
        font.pixelSize: input.font.pixelSize
        verticalAlignment: Text.AlignVCenter
        opacity: !input.cursorVisible && !input.text.length && input.enabled
        Behavior on opacity { NumberAnimation{} }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            root.forceActiveFocus()
            Qt.inputMethod.show()
        }
    }
}
