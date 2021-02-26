/*** UI View Container  **/

/** V1.0
 ** Update 25/02/21
  * Added Fullscreen
  * Added duplicate page for multiple led strip control
  */

/** V0.1
 ** Creation 21/02/21
  * Setup up view with internal pages
  * Navigation bar between pages
  * Initially holds Slider Page
  */

import QtQuick 2.11
import QtQuick.Controls 2.4

ApplicationWindow {
    id: window
    visible: true
    //visibility: "FullScreen"
    width: 800
    height: 480

    header: ToolBar {
        contentHeight: toolButton.implicitHeight
        background: "#222222"

        ToolButton {
            id: toolButton
            text: stackView.depth > 1 ? "🔙" : "🍔" //"\u25C0" : "\u2630"  // 🍔 🔙
            font.pixelSize: Qt.application.font.pixelSize * 1.6
            onClicked: {
                if (stackView.depth > 1) {
                    stackView.pop()
                } else {
                    drawer.open()
                }
            }
        }

        Label {
            text: stackView.currentItem.title
            anchors.centerIn: parent
        }
    }

    Drawer {
        id: drawer
        width: window.width * 0.66
        height: window.height

        Column {
            anchors.fill: parent

            ItemDelegate {
                text: qsTr("Strip colour")
                width: parent.width
                onClicked: {
                    b.setMode("strip")
                    stackView.push("sliders.qml")
                    drawer.close()
                } // End Clicked
            } // End Item

            ItemDelegate {
                text: qsTr("Chain colour")
                width: parent.width
                onClicked: {
                    b.setMode("chain")
                    stackView.push("sliders.qml")
                    drawer.close()
                } // End Clicked
            } // End Item

        } // End List
    } // End Drawer

    StackView { // Default Page
        id: stackView
        initialItem: "home.qml"
        anchors.fill: parent
    }
}
