import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.1


Window {
    visible: true
    width: 540
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

        Button {
            id: newText
            text: qsTr("New Text")
            property int count: 0
            onClicked: {
                var component;
                var cards;
                component = Qt.createComponent("cards.qml");
                cards = component.createObject(canvas, {"x": 100 + count, "y": 100 + count})
                count+= 15;
            }
        }

    }



    Canvas {
        id: canvas
        anchors.top: tools.bottom
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
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

//            Rectangle {
//                id: rectangleCanvas
//                x: 111
//                y: 343
//                width: 137
//                height: 20
//                color: "#2088da"

//                Drag.active: dragArea.drag.active
//                Drag.hotSpot.x: 10
//                Drag.hotSpot.y: 10

//                MouseArea {
//                    id: dragArea
//                    anchors.topMargin: 0
//                    anchors.fill: parent

//                    drag.target: parent
//                }


//                TextEdit {
//                    id: textEdit
//                    x: 0
//                    width: 137
//                    height: 59
//                    text: qsTr("Text Edit Canvas")
//                    anchors.top: dragArea.bottom
//                    anchors.topMargin: 1
//                    font.capitalization: Font.MixedCase
//                    font.family: "Arial"
//                    font.pointSize: 12
//                    horizontalAlignment: Text.AlignLeft
//                    textFormat: Text.AutoText
//                    leftPadding: 0
//                    cursorVisible: false
//                    renderType: Text.NativeRendering
//                    clip: false
//                }
//            }
        }

    }

}
