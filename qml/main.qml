import QtQuick 2.3
import QtQuick.Controls 1.2
import "../js/app.js" as App


ApplicationWindow {
    id: app
    visible: true
    width: 480
    height: 800
    title: qsTr("Backbone Todo")
    color: "white"


    Component.onCompleted: {
        App.todos.on("add", function(todo) { todo.itemProcessing = false; todoModel.append(todo) });
        App.getTodos();
    }

    function completeItem(index) {
        var todo = App.todos.at(index)
        todo.itemProcessing = true;

        todo.save({completed: true}, {success: function(model) {
            todoModel.setProperty(index, "itemProcessing", false);
        }, error: function(){ console.log("error")} } )
        todoModel.set(index, todo);
    }

    function deleteItem(index) {
        var todo = App.todos.at(index)

        todo.destroy({success: function(model) {
            todoModel.remove(index);
        }, error: function(){ console.log("error")} } )
        todoModel.setProperty(index, "itemProcessing", true)
    }

    Rectangle {
        id: toolbar
        z: 10
        height: 40
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#777876"
            }

            GradientStop {
                position: 1
                color: "#142a01"
            }

        }

        border.width: 0
        border.color: "#00000000"

        anchors { top: parent.top; left: parent.left; right: parent.right }

        Image {
            id: logo
            anchors { top: parent.top; left: parent.left }
            height: parent.height * 0.7
            anchors.leftMargin: 10
            anchors.topMargin: 5
            fillMode: Image.PreserveAspectFit
            source: "qrc:/images/qt-logo.png"
            smooth: true
        }

        Text {
            id: text1
            x: 308
            y: 13
            color: "#ffffff"
            text: qsTr("Backbone Todo")
            horizontalAlignment: Text.AlignHCenter
            anchors.centerIn: parent
            font.bold: true
            wrapMode: Text.NoWrap
            font.pixelSize: 20
        }
    }

    ListView {
        id: todos
        width: parent.width
        anchors.left: parent.left
        anchors.leftMargin: 1
        anchors.top: toolbar.bottom
        anchors.bottom: textArea.top

        clip: true
        model: todoModel
        delegate: TodoRow {}

        add: Transition { NumberAnimation { property: "y"; from: -toolbar.height; duration: 300 } }
        addDisplaced: Transition { NumberAnimation { property: "y";  duration: 300 } }
        removeDisplaced: Transition { NumberAnimation { property: "y"; duration: 300 } }
        moveDisplaced: Transition { NumberAnimation { property: "y"; duration: 300 } }

    }

    ListModel {
        id: todoModel
    }

    Rectangle {
            id: textArea
            anchors { leftMargin: 3; bottom: parent.bottom; horizontalCenter: parent.horizontalCenter }

            width: parent.width
            height: 40

            color: "darkgray"

            TextInputField {
                id: textinput
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                height: parent.height - 10
                width: parent.width * 0.8
                onAccepted: { App.addTodo(textinput.text); text = '' }
            }

            Button {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                width: parent.width * 0.2
                height: parent.height -10
                text: qsTr("Add")

                onClicked: {App.addTodo(textinput.text); textinput.text = '' }
            }
        }

}
