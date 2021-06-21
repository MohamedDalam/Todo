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

    readonly property int taskheight: 40

    ModelTodo {
        id: modelTodo
    }

    Style{
        id: style
    }

    ColumnLayout {
        id: listContainer
        anchors.centerIn: parent
        width: 400
        height: 600

        TitleBar{
            actualHeight: 60
            Layout.fillWidth: true
        }

        Rectangle{
            id: listBackground
            Layout.fillHeight: true
            Layout.fillWidth: true
            color: "white"
            radius: 5
            state: "EmptyList"

            TasksList{}

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
        InputContainer{
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignBottom | Qt.AlignVCenter
            _model: modelTodo
        }
    }
}
