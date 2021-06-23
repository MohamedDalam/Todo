import QtQuick 2.0
import QtQuick.Layouts 1.2
import QtQuick.Controls 2.2

TextField {
    id: _root

    property alias textFiledWidth: textFieldBack.width

    anchors.fill: parent
    verticalAlignment : TextInput.AlignVCenter

    background: Rectangle {
        id:textFieldBack
        border.width: 1
        radius: 5
        border.color: Style.primaryColorLight
    }
    cursorDelegate: Rectangle {
        visible: cursorVisible
        color: Style.primaryColorMain
        width: cursorRectangle.width
    }
    leftPadding: 10
    rightPadding: 10
    selectByMouse: true
    placeholderTextColor:Qt.rgba(Style.primaryColorLight.r, Style.primaryColorLight.g,
                                 Style.primaryColorLight.b, 0.5)
}
