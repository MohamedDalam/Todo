import QtQuick 2.12
import QtQml 2.0
import QtQuick.Layouts 1.2

Item{
    id: _root
    property alias actualHeight: _root.height
    property date currentDate: new Date()
    width: parent.width

    Rectangle{
        id:background
        anchors.fill: parent
        gradient: Gradient{
            GradientStop {position: 0.0; color: style.primaryColorMain }
            GradientStop {position: 1.0; color: style.primaryColorLight }
        }
        radius: 5
    }

    RowLayout{
        anchors.fill: parent
        id: titleBar
        Text {
            id: title
            text: "Daily Tasks"
            color: "white"
            font.pixelSize: 20
            font.bold: true
            Layout.leftMargin: 10
            Layout.alignment: Qt.AlignVCenter
        }

        Text {
            id: date
            text: currentDate.toDateString()
            color: "white"
            font.pixelSize: 16
            font.bold: false
            Layout.rightMargin: 10
            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
        }
    }
}
