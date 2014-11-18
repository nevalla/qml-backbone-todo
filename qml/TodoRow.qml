import QtQuick 2.0

Rectangle {
    id: itemDelegate
    height: Math.max(buttonHeight, content.contentHeight);
    width: parent.width
    color: itemDone ? "#bbbbbb" : "#f1f1f1"
    radius: 1

    property int buttonHeight: app.height * 0.08
    property bool itemDone: attributes['completed'] ? attributes['completed'] : false

    Text {
        id: content
        anchors { left: parent.left; verticalCenter: parent.verticalCenter; margins: parent.width * 0.03 }
        verticalAlignment: Text.AlignVCenter
        width: parent.width - buttonHeight
        wrapMode: Text.WordWrap
        font.strikeout: attributes["completed"] ? attributes["completed"] : false
        color: itemDone ? "#555555" : "#333333"
        font.pixelSize: Math.min(parent.width * 0.05, buttonHeight*0.3)
        text: attributes['text']
    }

    ImageButton {
        id: btn
        anchors { right: parent.right; top: parent.top; }
        height: buttonHeight
        width: height

        icon: {
            if (itemProcessing)
                return "qrc:/images/loading.png";
            else
                return attributes['completed'] ? "qrc:/images/close.png" : "qrc:/images/accept.png";
        }
        onClicked: {
            if (itemDone)
                app.deleteItem(index);
            else
                app.completeItem(index);
        }


        NumberAnimation {
            target: btn
            property: "rotation"
            duration: 1000
            from: 0
            to: 360
            alwaysRunToEnd: true
            running: itemProcessing
            loops: Animation.Infinite
        }

    }

    Rectangle {
        anchors.bottom: parent.bottom
        width: parent.width
        height: 2
        color: itemDone ? "#cccccc" : "#e5e5e5"
    }

    Rectangle {
        anchors.top: parent.top
        width: parent.width
        height: 2
        color: itemDone ? "#aaaaaa" : "#ffffff"
    }
}
