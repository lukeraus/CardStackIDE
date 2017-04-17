import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.1

Window {
    visible: true
    width: 500
    height: 540
    id: root

    Row {
        id: tools

        Button {
            id: clear
            text: "Clear"
            onClicked: {
                canvas.clear()
            }
        }

        Button {
            id: save
            text: "Save"
            onClicked: {
                mouse.save()
            }
        }

    }



    Canvas {
        id: canvas
        anchors.top: tools.bottom
        width: 500
        height: 500
        property int lastX: 0
        property int lastY: 0

        function clear() {
            var ctx = getContext("2d")
            ctx.reset()
            canvas.requestPaint()
            mouse.clear()
        }

        onPaint: {
            // Do something
            var ctx = getContext("2d")
            ctx.lineWidth = 2
            ctx.strokeStyle = color.red
            ctx.beginPath()
            ctx.moveTo(lastX, lastY)
            lastX = area.mouseX
            lastY = area.mouseY
            ctx.lineTo(lastX, lastY)
            ctx.stroke()

            mouse.test()
            mouse.add(lastX, lastY)
        }

        MouseArea {
            id: area
            anchors.fill: parent
            onPressed: {
                canvas.lastX = mouseX
                canvas.lastY = mouseY
            }

            onPositionChanged: {
                canvas.requestPaint()
            }

            TextEdit {
                id: textEdit
                x: 190
                y: 402
                width: 120
                height: 59
                text: qsTr("Text Edit Canvas")
                font.capitalization: Font.MixedCase
                font.family: "Arial"
                font.pointSize: 12
                horizontalAlignment: Text.AlignLeft
                textFormat: Text.AutoText
                leftPadding: 0
                cursorVisible: false
                renderType: Text.NativeRendering
                clip: false
            }
        }




        Rectangle {
            id: rectangle1
            x: 100
            y: 100
            width: 137
            height: 20
            color: "#2088da"

            Drag.active: dragArea.drag.active
            Drag.hotSpot.x: 10
            Drag.hotSpot.y: 10

            MouseArea {
                id: dragArea
                anchors.fill: parent

                drag.target: parent
            }

            Rectangle {
                id: rectangle
                width: 137
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
                            width: 137
                            height: 73
                            text: qsTr("Text Edit 1")
                            font.family: "Courier"
                            font.pointSize: 12
                        }
                    }
                    Item {
                        id: secondPage

                        TextEdit {
                            id: textEdit2
                            width: 137
                            height: 75
                            text: qsTr("Text Edit 2")
                            font.family: "Courier"
                            font.pointSize: 12
                        }
                    }
                    Item {
                        id: thirdPage

                        TextEdit {
                            id: textEdit3
                            width: 137
                            height: 75
                            text: qsTr("Text Edit 3")
                            font.family: "Courier"
                            font.pointSize: 12
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


}
