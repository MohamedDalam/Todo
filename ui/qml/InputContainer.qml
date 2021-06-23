import QtQuick 2.0

FocusScope {
    id: _root
    implicitHeight: 30
    implicitWidth: 200

    property int _btnX: ((_root.width / 2) - (btnNewTask.width / 2))
    property string inputText: inputRecord.text

    signal append()

    function acceptRecord() {
        if(_root.state === "add") {
            _root.append()
            _root.state = "view"
        } else {
            _root.state = "add"
        }
    }

    state: "view"
    Keys.onEscapePressed : _root.state = "view"

    InputRecord {
        id: inputRecord
        anchors.leftMargin: 20
        placeholderText: "What is your next task?"
        focus: true

        onAccepted: _root.acceptRecord()
    }

    PrimaryButton {
        id: btnNewTask
        x: _root._btnX
        anchors.verticalCenter: parent.verticalCenter
        height: parent.height
        text: "+ Add Task"

        onClicked: _root.acceptRecord()
    }

    states: [
        State {
            name: "view"
            PropertyChanges {
                target: inputRecord
                opacity: 0.0
                textFiledWidth: 0
                text: ""
            }
            PropertyChanges { target: btnNewTask
                width: 160
            }
        },
        State {
            name: "add"
            PropertyChanges { target: btnNewTask
                text: "+"
                width: 30
                x: _root.width - btnNewTask.width - 20
            }
            PropertyChanges {
                target: inputRecord
                opacity: 1.0
                textFiledWidth: btnNewTask.x - 30
                text: ""
            }
        }
    ]

    transitions: [
        Transition {
            from: "view"; to: "add"
            NumberAnimation {
                properties: "x"; to: _root.width - 50
                duration: 250; easing.type: Easing.Linear
            }
            PropertyAnimation { target: inputRecord; properties: "opacity, textFiledWidth"; duration: 200 }
        },
        Transition {
            from: "add"; to: "view"
            NumberAnimation {
                properties: "x"; to: _root._btnX
                duration: 250; easing.type: Easing.Linear
            }
            PropertyAnimation { target: inputRecord; properties: "opacity, textFiledWidth"; duration: 200 }
        }
    ]
}
