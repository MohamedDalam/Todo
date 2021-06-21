import QtQuick 2.0

Item {
    id: _root
    implicitHeight: 40
    implicitWidth: 200

    property var _model
    readonly property int _btnX: ((_root.width / 2) - (btnNewTask.width / 2))

    focus: true
    Keys.onEscapePressed : _root.state = "view"

    state: "view"
    function acceptRecord() {
        if(_root.state === "add") {
            _root._model.append(inputRecord.isActive,inputRecord.text);
            inputRecord.clearText();
        }
        _root.state = _root.state === "view" ? "add" : "view";
    }

    InputRecord{
        id: inputRecord
        anchors.leftMargin: 20
        textFiledPlaceHolderText: "What is your next task?"
        onEnterPressed: _root.acceptRecord()
    }

    PrimaryButton{
        id: btnNewTask
        x: _root._btnX
        anchors.verticalCenter: parent.verticalCenter
        text: "+ Add Task"
        onClicked: _root.acceptRecord()
    }
    states: [
        State {
            name: "view"
            PropertyChanges { target: inputRecord; opacity: 0.0; textFiledWidth: 0}
            PropertyChanges { target: btnNewTask; width: 180; height: 40; }
        },
        State {
            name: "add"
            PropertyChanges { target: btnNewTask; text: "+"; width: 30; height: 30; x: _root.width - btnNewTask.width - 20; }
            PropertyChanges { target: inputRecord; opacity: 1.0; textFiledWidth: btnNewTask.x - 30}
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

