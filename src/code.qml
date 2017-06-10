import QtQuick 2.0
import QtQuick.Controls 2.1

Item {
    id: card1
    property alias rectangleTextEdit: rectangleTextEdit

    Rectangle {
        id: titleRectangle
        x: 0
        y: 0
        width: 430
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
            text: qsTr("Code")
            elide: Text.ElideMiddle
        }

        Button {
            id: closeText
            x: 430
            text: qsTr("X")
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
            anchors.fill: parent
            drag.target: parent
        }

        Rectangle {
            id: rectangleResize
            color: "#ffffff"
            border.width: 7
            width: 450
            height: 325
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

                    PinchArea {
                        id: t_area
                        anchors.fill: parent
                        property real initialWidth
                        property real initialHeight
                        property real last_pinch: 1
                        onPinchStarted: {
                            initialWidth = rectangleResize.width
                            initialHeight = rectangleResize.height
                        }

                        onPinchUpdated: {
                            console.log("Pinch updating")
                            console.log(pinch.scale)
                            if (last_pinch > pinch.scale){
                                if ((last_pinch - pinch.scale) > 0.02){
                                    console.log("shrink")
                                    rectangleResize.width = rectangleResize.width - 10
                                    titleRectangle.width = titleRectangle.width - 10
                                    closeText.x = closeText.x - 10
                                    rectangleResize.height = rectangleResize.height - 10
                                    last_pinch = pinch.scale
                                }
                            } else {
                                if ((pinch.scale - last_pinch) > 0.02){
                                    console.log("grow")
                                    rectangleResize.width = rectangleResize.width + 10
                                    titleRectangle.width = titleRectangle.width + 10
                                    closeText.x = closeText.x + 10
                                    rectangleResize.height = rectangleResize.height + 10
                                    last_pinch = pinch.scale
                                }
                            }
                        }
                        onPinchFinished: {
                            console.log("pinch finish")
                        }

                            SwipeView {
                                id: swipeView

                                currentIndex: 0
                                anchors.fill: parent

                                Item {
                                    id: firstPage

                                    TextEdit {
                                        id: textEdit1
                                        text: qsTr("
    class OthelloGameState:
        def __init__(self, rows: int,
                           columns: int):
            self._ROWS = rows
            self._COLUMNS = columns

        def move(self, row: int, column: int):
            if not self._check_for_open_move():
                self._change_turns()
                raise NoValidMoves
            elif self._[row][column] != '.':
                raise CellNotEmpty")
                                        anchors.fill: parent
                                        wrapMode: TextEdit.WordWrap
                                        font.family: "Courier"
                                        font.pointSize: 12
                                        visible: (swipeView.currentIndex == 0) ? true : false
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
                        }

                    PageIndicator {
                        id: indicator

                        count: swipeView.count
                        currentIndex: swipeView.currentIndex

                        anchors.bottom: t_area.bottom
                        anchors.horizontalCenter: t_area.horizontalCenter
                    }
                }
            }
    }
}
