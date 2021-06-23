import QtQuick 2.12

ListView{
    id: tasksList
    implicitHeight: 100
    width: parent.width
    height: parent.height
    clip: true

    property var todoModel;

    model: DelegateModel {
        id: delegatemodel
        model: todoModel
        delegate: Item {
            id: delegateRoot
            width: tasksList.width
            height: 40
            property int dropItemIndex: DelegateModel.itemsIndex

            TasksListDelegate {
                id: task
                dropItemIndex: delegateRoot.dropItemIndex
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                width: parent.width
                text: model.description
                isActive: model.active
                onActiveStateChanged: delegatemodel.model.changeActiveState(model.index)
                onRemoveClicked: delegatemodel.model.remove(model.index)
                dragParent: tasksList
            }

            DropArea {
                id: dropArea
                anchors.fill: parent
                onEntered: function(drag) {
                    delegatemodel.items.move((drag.source as TasksListDelegate).dropItemIndex, task.dropItemIndex)
                }
                onDropped: {
                    delegatemodel.model.swap((drag.source as TasksListDelegate).dropItemIndex, task.dropItemIndex);
                }
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
            duration: 250; easing.type: Easing.InCirc
        }
    }
    displaced: Transition {
        SequentialAnimation {
            PauseAnimation { duration: 100 }
            NumberAnimation { properties: "y"; easing.type: Easing.OutQuad; duration: 75 }
        }
    }
    addDisplaced: Transition {
        NumberAnimation {properties: "x, y"; duration: 100}
    }
    moveDisplaced: Transition {
        NumberAnimation { properties: "x, y"; duration: 100 }
    }
    removeDisplaced: Transition {
        NumberAnimation { properties: "x, y"; duration: 100 }
    }
}
