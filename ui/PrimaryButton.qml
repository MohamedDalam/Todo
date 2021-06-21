import QtQuick 2.0

Item {
    id: _root

    height: 40
    width: 180
    state: ""

    property color btnColor : style.secondaryColorMain
    property color btnHoveredColor: style.secondaryColorLight
    property color fontColor : style.fontTextColor
    property alias text: name.text

    signal clicked()

    Rectangle{
        id: btnBack
        height: _root.height
        width: _root.width
        color: _root.btnColor
        radius: 10
        Text {
            id: name
            anchors.centerIn: parent
            color: _root.fontColor
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
                color: _root.btnHoveredColor
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
