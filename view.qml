/*** Rainbow Slider UI - Colour choosing  **/

/** V3.1
 ** Update 29/01/21
  * Added value Slider
  * Added set white button
  * Functional layout
  */

/** V3.0
 ** Update 27/01/21
  * Modified colour changes
  * Added buttons
  * Added function placeholder
  */

/** V2.0
 ** Update 02/12/20
  * Recreated in PyQt
  * Corrected errors in runtime
  */

/** V1.1
 ** Update 03/11/20
  * Dropper now only appears for selection
  * Slider shows full spectrum
  * Dropper lines up with bar
  * Removed unnecessary imports
  * Documentation of functions and objects
  */

/** V1.0
 ** Creation 01/11/20
  * Rainbow selection
  * Slider with colour update
  * Make generic and repeatable
  * Minimum dependancy
  */

import QtQuick 2.12
import QtQuick.Controls 2.5

//unnecessary import
//import QtGraphicalEffects 1.12
//import QtQuick.Controls.Styles 1.4


ApplicationWindow {
    id: window
    width: 800
    height: 480 // Window sizes
    visible: true // show
    color: "#222222"

    title: qsTr("Colour dropper")


    function btnPressed(id) {
        // Take id as what Button is pressed
        // Button corresponds to the colour and state

    }



    Slider {
        id: colour
        anchors.centerIn: parent // Positioning
        width: 640
        height: 160
        anchors.verticalCenterOffset: 50
        anchors.horizontalCenterOffset: 0
        padding: 20


        background: Rectangle { // Background - rounded rectangle
            anchors.centerIn: parent
            x: colour.leftPadding // Positioning
            y: colour.topPadding + colour.availableHeight / 2 - height / 2 // Positioning within confines of slider object
            implicitWidth: 240
            implicitHeight: 90
            width: colour.availableWidth // Consistent size for design
            height: implicitHeight

            radius: 20 // Rounded edge
            border.width: 1 // Border size
            border.color: "#333333" // Border colour


            gradient: Gradient {    // Display HSV rainbow for selection
                orientation: Gradient.Horizontal // Gradient orientation
                // 6 points on hue circle
                GradientStop {  // Red
                    position: 0.000
                    color: Qt.hsva(position, 1, 1)
                }
                GradientStop { // Yellow
                    position: 0.167
                    color: Qt.hsva(position, 1, 1)
                }
                GradientStop {  // Green
                    position: 0.333
                    color: Qt.hsva(position, 1, 1)
                }
                GradientStop { // Light blue
                    position: 0.500
                    color: Qt.hsva(position, 1, 1)
                }
                GradientStop { // Dark blue
                    position: 0.667
                    color: Qt.hsva(position, 1, 1)
                }
                GradientStop { // Magenta
                    position: 0.833
                    color: Qt.hsva(position, 1, 1)
                }
                GradientStop { // Red
                    position: 1.000
                    color: Qt.hsva(position, 1, 1)
                } // End gradient points
            } // End gradient

        } // End background

        handle: Rectangle // Floating handle designed as a colour dropper
        {
            id: recPalette
            width: 40
            height: 40
            x: width/2 + colour.value * (colour.background.width - width) // Fit the colour dropper to the selection bar
            y: -this.height /2 // Have the dropper appear above the selection bar
            implicitWidth: 30 // Size of dropper
            implicitHeight: 50 // Size of dropper
            radius: 20 // Rounded edges

            //*/ Choice to show dropper only when pressed or all the time
            color: Qt.hsva(colour.valueAt(colour.position), 1, 1)
            border.color: "#333333"
            /*/
            color: colour.pressed ? Qt.hsva(colour.valueAt(colour.position), 1, 1) // Show dropper with currently selected colour
                                   : "transparent" // When released, dropper disappears
            border.color: colour.pressed ? "#333333" // Constant colour
                                          : "transparent" // Only show dropper and border when selecting colour
            //*/


        } // End handle


    }

    Slider {
        id: brightness
        width: 640
        height: 160
        background: Rectangle {
            x: brightness.leftPadding
            y: brightness.topPadding + brightness.availableHeight / 2 - height / 2
            width: brightness.availableWidth
            height: implicitHeight
            radius: 20
            border.color: "#333333"
            border.width: 1
            gradient: Gradient {
                GradientStop {
                    position: 0
                    color: Qt.hsva(1, 0, position)
                }

                GradientStop {
                    position: 1
                    color: Qt.hsva(1, 0, position)
                }
                orientation: Gradient.Horizontal
            }
            implicitWidth: 240
            anchors.centerIn: parent
            implicitHeight: 90
        }
        anchors.verticalCenterOffset: -110
        handle: Rectangle {
            id: recPalette1
            x: width/2 + brightness.value * (brightness.background.width - width)
            y: -this.height /2
            width: 40
            height: 40
            radius: 20

            //*/ Choice to show dropper only when pressed or all the time
            color: Qt.hsva(1, 0, brightness.valueAt(brightness.position))
            border.color: "#333333"
            /*/ Show dropper with currently selected colour
            color: brightness.pressed ? Qt.hsva(1, 0, brightness.valueAt(brightness.position))
                                      : "transparent"
            border.color: brightness.pressed ? "#333333" // Constant colour
                                             : "transparent"
            //*/

            implicitWidth: 30
            implicitHeight: 50
        }
        anchors.horizontalCenterOffset: 0
        anchors.centerIn: parent
        padding: 20
    }

    Button {
        id: btnOff
        x: 474
        y: 114
        width: 100
        height: 70
        text: qsTr("Black")
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenterOffset: 120
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenterOffset: 160
        font.pointSize: 11
        font.family: "Tahoma"

        palette {
            button: "#111111"
            buttonText: "#eeeeee"
        }

        Connections {
            target: btnOff
            onClicked: {
                console.log("Off/Black")
                btnPressed(0)
            }
        } // End connection
    } // End btnOff

    Button {
        id: btnSet
        x: 228
        y: 114
        width: 100
        height: 70
        text: qsTr("Set Colour")
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenterOffset: -120
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenterOffset: 160
        font.pointSize: 11
        checkable: false
        font.family: "Tahoma"


        Connections {
            target: btnSet
            onClicked: {
                console.log("Colour")
                btnPressed(2)
            }
        } // end connection
    } // btnSet

    Button {
        id: btnWhite
        x: 218
        y: 107
        width: 100
        height: 70
        text: qsTr("Set White")
        anchors.verticalCenter: parent.verticalCenter
        font.pointSize: 11
        anchors.verticalCenterOffset: 160
        font.family: "Tahoma"
        anchors.horizontalCenterOffset: 0
        Connections {
            target: btnWhite
            onClicked: {
                console.log("White")
                btnPressed(1)
            }
        }
        anchors.horizontalCenter: parent.horizontalCenter
        checkable: false
    } // End btnWhite

}
