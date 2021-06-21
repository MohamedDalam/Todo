import QtQuick 2.12
import QtQuick.Layouts 1.2

Rectangle {
    id: _root
    implicitWidth: 200
    implicitHeight: 40
    color: "transparent"
    radius: 5

    property int dropItemIndex:0
    property alias text: description.text
    property alias descState: description.state
    property ListView listView
    property Item dragParent
    property bool isActive

    signal activeStateChanged()
    signal itemHover()
    signal removeClicked()

    RowLayout{
        id: row
        anchors.fill: parent
        Item{
            id: descriptionContainer
            height: parent.height
            width: description.width + 30
            Layout.preferredWidth: descriptionContainer.width
            Layout.preferredHeight: 40
            state: isActive ? "active" : "deActive"

            CheckedIndicator{
                id:checkedIndicator
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 10
                width: 14
                height: 14
            }

            Text {
                id: description
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: checkedIndicator.right
                anchors.leftMargin: 10
                font.pixelSize: 16
            }

            states: [
                State {
                    name: "active"
                    PropertyChanges { target: checkedIndicator; color: "transparent" }
                    PropertyChanges { target: description; opacity: 1.0;  font.strikeout: false;}
                },
                State {
                    name: "deActive"
                    PropertyChanges { target: checkedIndicator; color: style.primaryColorMain }
                    PropertyChanges { target: description; opacity: 0.5;  font.strikeout: true;}
                }
            ]

            transitions: [
                Transition {
                    from: "*"; to: "*"
                    PropertyAnimation { target: checkedIndicator; properties: "color"; duration: 200 }
                    PropertyAnimation { target: description; properties: "opacity"; duration: 200 }
                }
            ]
        }

        Rectangle {
            id: removeIcon
            Layout.alignment: Qt.AlignRight
            Layout.rightMargin: 10
            width: 16
            height: 16
            color: "transparent"
            Text {
                id: name
                anchors.centerIn: parent
                color: "red"
                font.bold: false
                font.pixelSize: 20
                text: "x"
            }
        }

    }

    MouseArea{
        id: area
        anchors.fill: parent
        hoverEnabled: true
        drag.target: _root

        drag.onActiveChanged: _root.Drag.drop();

        onClicked: (mouse) => {
                       if(mouse.x >= removeIcon.x && mouse.x < (removeIcon.x + removeIcon.width)){
                           removeClicked()
                       }
                       else{
                           _root.activeStateChanged()
                           descriptionContainer.state = descriptionContainer.state === "active" ?  "deActive" : "active"
                       }}
    }

    Drag.active: area.drag.active
    Drag.hotSpot.x: width / 2
    Drag.hotSpot.y: height / 2

    states: [
        State {
            when: _root.Drag.active
            ParentChange {
                target: _root
                parent: _root.dragParent
            }
            PropertyChanges {
                target: _root
                color: Qt.lighter(style.primaryColorLight,1.5)
            }
            AnchorChanges {
                target: _root
                anchors.horizontalCenter: undefined
                anchors.verticalCenter: undefined
            }
        }

    ]
}
