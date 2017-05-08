import QtQuick 2.0
import QtQuick.Controls 2.1

Item {
    id: card3
    property alias rectangleTextEdit: rectangleTextEdit

    Rectangle {
        id: titleRectangle
        x: 0
        y: 0
        width: 250
        height: 20
        color: "#2088da"

        Drag.active: dragAreaTitle.drag.active
        Drag.hotSpot.x: 10
        Drag.hotSpot.y: 10

        Text{
            id: titleText
            x: 8
            y: 3
            color: "#ffffff"
            text: qsTr("Issues")
            elide: Text.ElideMiddle
        }

        Button {
            id: closeText
            x: 250
            text: qsTr("X")
            y: 0
            width: 20
            height: 20
            onClicked: {
                console.log("Destory")
                card3.destroy();
            }
        }

        MouseArea {
            id: dragAreaTitle
            anchors.fill: parent
            drag.target: parent
        }


        Rectangle {
            id: rectangleResize
            color: "#ffffff"
            border.width: 7
            width: 270
            height: 250
            border.color: "#2088da"
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 20

            MouseArea {
                  id: mouseAreaLeft

                  property int oldMouseX
                  property int oldMouseY
                  anchors.fill: parent
                  hoverEnabled: true

                  onPressed: {
                      oldMouseX = mouseX
                      oldMouseY = mouseY
                  }

                  onPositionChanged: {
                      if (pressed) {
                          rectangleResize.width = rectangleResize.width + (mouseX - oldMouseX)
                          titleRectangle.width = titleRectangle.width + (mouseX - oldMouseX)
                          closeText.x = closeText.x + (mouseX - oldMouseX)
                          oldMouseX = mouseX
                          rectangleResize.height = rectangleResize.height + (mouseY - oldMouseY)
                          oldMouseY = mouseY
                      }
                  }
            }

            Rectangle {
                id: rectangleTextEdit
                color: "#ffffff"
                anchors.rightMargin: 7
                anchors.leftMargin: 7
                anchors.bottomMargin: 7
                anchors.topMargin: 0
                anchors.fill: parent
                border.color: "#0b0b0b"

                SwipeView {
                    id: swipeView

                    currentIndex: 0
                    anchors.fill: parent

                    Item {
                        id: firstPage

                        Text {
                            id: link_Text
                            text: '<html><style type="text/css"></style><a href="http://google.com">Issue 1: Example Text</a></html>'
                            onLinkActivated: Qt.openUrlExternally("https://github.com/lukeraus/CardStackIDE/issues/1")
                            wrapMode: TextEdit.WordWrap
                            font.family: "Courier"
                            font.pointSize: 12
                            visible: (swipeView.currentIndex == 0) ? true : false
                            MouseArea {
                                    anchors.fill: parent
                                    acceptedButtons: Qt.NoButton // we don't want to eat clicks on the Text
                                    cursorShape: parent.hoveredLink ? Qt.PointingHandCursor : Qt.ArrowCursor
                                }
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
                            visible: (swipeView.currentIndex == 1) ? true : false
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
                            visible: (swipeView.currentIndex == 2) ? true : false
                        }
                    }
                }

                PageIndicator {
                    id: indicator

                    count: swipeView.count
                    currentIndex: swipeView.currentIndex

                    anchors.bottom: swipeView.bottom
                    anchors.horizontalCenter: swipeView.horizontalCenter
                }
            }
        }
    }
}
