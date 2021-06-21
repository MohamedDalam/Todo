import QtQuick 2.0

Item {
    id: _root
    property alias color: checkedIndicator.color

    signal clicked()

    Rectangle{
        id: checkedIndicator
        width: 14
        height: checkedIndicator.width
        radius:  checkedIndicator.width / 2
        color: "transparent"
        border.width: 1
        border.color: style.primaryColorMain

        MouseArea{
        anchors.fill: parent
        onClicked: _root.clicked()
        }
    }
}
