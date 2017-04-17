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
                x: 0
                y: 0
                width: 120
                height: 59
                text: qsTr("Text Edit")
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
            id: rectangle
            x: 138
            y: 112
            width: 137
            height: 200
            color: "#ffffff"


            SwipeView {
                id: view
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
                        font.pixelSize: 12
                    }
                }
                Item {
                    id: secondPage

                    TextEdit {
                        id: textEdit2
                        width: 137
                        height: 75
                        text: qsTr("Text Edit 2")
                        font.pixelSize: 12
                    }
                }
                Item {
                    id: thirdPage

                    TextEdit {
                        id: textEdit3
                        width: 137
                        height: 75
                        text: qsTr("Text Edit 3")
                        font.pixelSize: 12
                    }
                }
            }
            PageIndicator {
                id: indicator
                x: 88
                y: 368

                count: view.count
                currentIndex: view.currentIndex

                anchors.bottom: view.bottom
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }



    }


}
