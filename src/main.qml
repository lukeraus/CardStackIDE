import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.1

Window {
    visible: true
    width: 650
    height: 600
    id: root

    Row {
        id: tools
        z: 2

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
            text: qsTr("Code")
            property int count: 0
            onClicked: {
                var component;
                var cards;
                component = Qt.createComponent("code.qml");
                cards = component.createObject(canvas, {"x": 100 + count, "y": 100 + count})
                count+= 15;
            }
        }

        Button {
            id: searchText
            text: qsTr("Search History")
            onClicked: {
                var component;
                var cards;
                component = Qt.createComponent("search.qml");
                cards = component.createObject(canvas, {"x": 100 + newText.count, "y": 100 + newText.count})
                newText.count+= 15;
            }
        }

        Button {
            id: issueText
            text: qsTr("Issues")
            onClicked: {
                var component;
                var cards;
                component = Qt.createComponent("issue.qml");
                cards = component.createObject(canvas, {"x": 100 + newText.count, "y": 100 + newText.count})
                newText.count+= 15;
            }
        }

        Switch {
            id: drawSwitch
            text: qsTr("Draw")
            checked: true
        }

    }

    MultiPointTouchArea {
        id: t_area
        anchors.fill: parent
        onPressed: {
            if(point2.pressed && point1.pressed){
                drawSwitch.checked = false
            } else {
                drawSwitch.checked = true
            }

        }

        touchPoints: [
            TouchPoint { id: point1},
            TouchPoint { id: point2}
        ]

        Flickable {
            z: 1
            id: scrolling
            anchors.fill: parent
            boundsBehavior: Flickable.DragAndOvershootBounds
            interactive: drawSwitch.checked ? false : true
            contentWidth: canvas.width; contentHeight: canvas.height

            Canvas {
                id: canvas
                width: 2000
                height: 2000
                x: 0
                y: 0
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
                    anchors.fill: canvas
                    enabled: drawSwitch.checked ? true : false
                    onPressed: {
                        canvas.lastX = mouseX
                        canvas.lastY = mouseY
                    }

                    onPositionChanged: {
                        canvas.requestPaint()
                    }
                }

            }
        }
    }

}
