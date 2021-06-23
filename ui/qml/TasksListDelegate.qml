import QtQuick 2.12
import QtQuick.Layouts 1.2

Rectangle {
    id: _root
    implicitWidth: 200
    implicitHeight: 40
    color: "transparent"
    radius: 5

    property int dropItemIndex: 0
    property alias text: description.text
    property alias descState: description.state
    property Item dragParent
    property bool isActive

    signal activeStateChanged()
    signal removeClicked()

    MouseArea {
        id: area
        anchors.fill: parent
        hoverEnabled: true
        drag.target: _root
        drag.onActiveChanged: _root.Drag.drop()
        onClicked: {
            _root.activeStateChanged()
            _root.isActive = !_root.isActive
        }
    }

    RowLayout {
        id: row
        anchors.fill: parent
        spacing: 0

        Item {
            id: descriptionContainer
            height: parent.height
            Layout.fillWidth: true

            CheckedIndicator {
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
                    when: _root.isActive === true
                    PropertyChanges { target: checkedIndicator; color: "transparent" }
                    PropertyChanges { target: description; opacity: 1.0;  font.strikeout: false;}
                },
                State {
                    name: "deActive"
                    when: _root.isActive === false
                    PropertyChanges { target: checkedIndicator; color: Style.primaryColorMain }
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

        Item {
            id: removeIconBack
            Layout.alignment: Qt.AlignRight
            Layout.preferredWidth: parent.height
            height: parent.height
            visible: area.containsMouse && !area.drag.active

            Text {
                id: removeIcon
                anchors.centerIn: parent
                verticalAlignment: Text.AlignVCenter
                color: deleteMousearea.containsMouse ? Style.secondaryColorLight : Style.secondaryColorMain
                font.bold: true
                font.pixelSize: 16
                text: "X"
            }

            MouseArea {
                id: deleteMousearea
                anchors.fill: removeIconBack
                hoverEnabled: true

                onClicked: removeClicked()
            }
        }
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
                color: Qt.lighter(Style.primaryColorLight,1.5)
            }
            AnchorChanges {
                target: _root
                anchors.horizontalCenter: undefined
                anchors.verticalCenter: undefined
            }
        }
    ]
}
