import QtQuick 2.0

Item {
    id: _root

    state: ""

    property alias text: name.text

    signal clicked()

    Rectangle{
        id: btnBack
        height: _root.height
        width: _root.width
        color: Style.secondaryColorMain
        radius: 10

        Text {
            id: name
            anchors.centerIn: parent
            color: Style.fontTextColor
            font.bold: true
            font.pixelSize: 20
        }

        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: _root.clicked()
            onEntered: _root.state = "entered"
            onExited:  _root.state = ""
        }
    }

    states: [
        State {
            name: "entered"
            PropertyChanges {
                target: btnBack
                color: Style.secondaryColorLight
            }
        }
    ]

    transitions: [
        Transition {
            from: "*"; to: "*"
            PropertyAnimation {
                properties: "color"; duration: 100; easing.type: Easing.OutInCubic
            }
        }
    ]
}
