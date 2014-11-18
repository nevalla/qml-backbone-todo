import QtQuick 2.0

Item {
    id: root

    property alias icon: image.source
    property bool buttonEnabled: true

    signal clicked()

    Image {
        id: image
        anchors.centerIn: parent
        height: parent.height * 0.8
        width: height
        fillMode: Image.PreserveAspectFit

        Behavior on scale { NumberAnimation{ duration: 50} }
    }

    MouseArea {
        anchors.fill: parent
        enabled: buttonEnabled
        onPressed: image.scale = 1.3
        onReleased: image.scale = 1.0
        onClicked: {
            image.scale = 1.0
            root.clicked()
        }
    }

}
