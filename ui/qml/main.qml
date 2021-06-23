import QtQuick 2.12
import QtQuick.Layouts 1.2
import QtQuick.Window 2.12
import ModelLib 1.0

Window {
    id: root
    width: 400
    height: 600
    visible: true
    color: "lightGray"

    ModelTodo {
        id: modelTodo
    }

    ColumnLayout {
        id: listContainer
        anchors.fill: parent

        TitleBar {
            height: 60
            Layout.fillWidth: true
        }

        Rectangle {
            id: listBackground
            Layout.fillHeight: true
            Layout.fillWidth: true
            color: "white"
            radius: 5

            TasksList{
                anchors.fill: parent
                todoModel: modelTodo
            }

            Text {
                id: emptyHint
                anchors.centerIn: parent
                text: "Add your Tasks..."
                color: "lightGray"
                font.pixelSize: 24
                font.bold: true
                visible: modelTodo.count === 0 ? true : false
            }
        }

        InputContainer {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignBottom | Qt.AlignVCenter
            Layout.bottomMargin: parent.spacing
            onAppend: modelTodo.append(true, name);
        }
    }
}
