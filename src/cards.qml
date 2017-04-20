import QtQuick 2.0
import QtQuick.Controls 2.1

Item {
    id: card1

    Rectangle {
        id: titleRectangle
        x: 0
        y: 0
        width: 145
        height: 20
        color: "#2088da"

        Drag.active: dragAreaTitle.drag.active
        Drag.hotSpot.x: 10
        Drag.hotSpot.y: 10

        Button {
            id: closeText
            text: qsTr("X")
            x: 145
            y: 0
            width: 20
            height: 20
            onClicked: {
                console.log("Destory")
                card1.destroy();
            }
        }

        MouseArea {
            id: dragAreaTitle
            width: 145
            anchors.fill: parent
            drag.target: parent
        }

        Rectangle {
            id: rectangleTextEdit
            width: 165
            height: 200
            color: "#ffffff"
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 20
            border.color: "#0b0b0b"


            SwipeView {
                id: swipeView
                x: -138
                y: -112

                currentIndex: 0
                anchors.fill: parent

                Item {
                    id: firstPage

                    TextEdit {
                        id: textEdit1
                        text: qsTr("Text Edit 1")
                        anchors.fill: parent
                        wrapMode: TextEdit.WordWrap
                        font.family: "Courier"
                        font.pointSize: 12
                        opacity: (swipeView.currentIndex == 0) ? 1.0 : 0.0
                    }
                }
                Item {
                    id: secondPage

                    TextEdit {
                        id: textEdit2
                        text: qsTr("Text Edit 2")
                        anchors.fill: parent
                        wrapMode: TextEdit.WordWrap
                        font.family: "Courier"
                        font.pointSize: 12
                        opacity: (swipeView.currentIndex == 1) ? 1.0 : 0.0
                    }
                }
                Item {
                    id: thirdPage

                    TextEdit {
                        id: textEdit3
                        wrapMode: TextEdit.WordWrap
                        text: qsTr("Text Edit 3")
                        anchors.fill: parent
                        font.family: "Courier"
                        font.pointSize: 12
                        opacity: (swipeView.currentIndex == 2) ? 1.0 : 0.0
                    }
                }
            }

            PageIndicator {
                id: indicator
                x: 68
                y: 377

                count: swipeView.count
                currentIndex: swipeView.currentIndex

                anchors.bottom: swipeView.bottom
                anchors.horizontalCenter: swipeView.horizontalCenter
            }
        }
    }
}
