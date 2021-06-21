import QtQuick 2.0
import QtQuick.Layouts 1.2
import QtQuick.Controls 2.2

Item {
    id: _root
    anchors.fill: parent

    property string text: textField.text
    property bool isActive: true
    property alias textFiledWidth: textFieldBack.width
    property alias textFiledPlaceHolderText: textField.placeholderText

    signal enterPressed()

    function clearText(){
        textField.clear()
    }

    implicitWidth: 200
    implicitHeight: 40
    //    state: "active"

    //    RowLayout{
    //        spacing: 20
    //        anchors.fill: parent
    //        CheckedIndicator{
    //            id:checkedIndicator
    //            width: 14
    //            height: 14
    //            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
    //            Layout.leftMargin: 20
    //            onClicked: _root.state = _root.state === "active" ?  "deActive" : "active"
    //        }

    TextField {
        id: textField
        implicitWidth: parent.width
        anchors.verticalCenter: parent.verticalCenter
        background: Rectangle{
            id:textFieldBack
            border.width: 1
            border.color: style.primaryColorLight
            radius: 5
        }
        cursorDelegate: Rectangle {
            visible: textField.cursorVisible
            color: style.primaryColorMain
            width: textField.cursorRectangle.width
        }
        width: textFiledWidth
        leftPadding: 10
        rightPadding: 10
        verticalAlignment : TextInput.AlignVCenter
        selectByMouse: true
        placeholderTextColor:Qt.rgba(style.primaryColorLight.r, style.primaryColorLight.g,
                                     style.primaryColorLight.b, 0.5)

        onAccepted: _root.enterPressed()
    }
    //    }

    //    states: [
    //        State {
    //            name: "active"
    //            PropertyChanges {target: _root; isActive: true}
    //            PropertyChanges { target: checkedIndicator; color: "transparent" }
    //        },
    //        State {
    //            name: "deActive"
    //            PropertyChanges {target: _root; isActive: false}
    //            PropertyChanges { target: checkedIndicator; color: style.primaryColorMain }
    //        }
    //    ]
}
