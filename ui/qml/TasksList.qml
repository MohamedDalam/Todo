import QtQuick 2.12

ListView{
    id: tasksList

    property var todoModel;

    implicitHeight: 100
    width: parent.width
    height: parent.height
    clip: true

    model: DelegateModel {
        id: delegatemodel
        model: todoModel
        delegate: Item {
            id: delegateRoot
            property int dropItemIndex: DelegateModel.itemsIndex

            width: tasksList.width
            height: 40

            TasksListDelegate {
                id: task
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                width: parent.width
                text: model.description
                dropItemIndex: delegateRoot.dropItemIndex
                isActive: model.active
                dragParent: tasksList

                onActiveStateChanged: delegatemodel.model.changeActiveState(model.index)
                onRemoveClicked: delegatemodel.model.remove(model.index)
            }

            DropArea {
                id: dropArea
                anchors.fill: parent
                onEntered: function(drag) {
                    delegatemodel.items.move((drag.source as TasksListDelegate).dropItemIndex, task.dropItemIndex)
                }
                onDropped: delegatemodel.model.swap((drag.source as TasksListDelegate).dropItemIndex, task.dropItemIndex);
            }
        }
    }

    add: Transition {
        NumberAnimation {
            properties: "x"; from: tasksList.width; to: 0
            duration: 250; easing.type: Easing.InCirc
        }
    }
    remove: Transition {
        NumberAnimation {
            properties: "x"; from: 0; to: tasksList.width;
            duration: 200; easing.type: Easing.InCirc
        }
    }
    displaced: Transition {
        SequentialAnimation {
            PauseAnimation { duration: 150 }
            NumberAnimation { properties: "y"; easing.type: Easing.OutQuad; duration: 75 }
        }
    }
}
