/*** Rainbow Slider UI - Colour choosing  **/

/** V1.0
 ** Update 25/02/21
  * Implemented MQTT control
  * Backend added with functions
  * Backend holds current LED mode, for multiple strips
  */

/** V0.5
 ** Update 21/02/21
  * Renamed file
  * Created view pages with navigation
  * QML can now call Python functions
  * Testing sending values
  */

/** V0.4
 ** Update 16/02/21
  * Working on Pi
  * Changed Qt versions for compatibility
  * Backwards compatibility changes
  * Gradient functionality required rotating shapes
  * Rotating shapes means changing widths and heights
  */

/** V0.3.1
 ** Update 29/01/21
  * Added value Slider
  * Added set white button
  * Functional layout
  */

/** V0.3
 ** Update 27/01/21
  * Modified colour changes
  * Dropper always appears, changed shape
  * Kept previous dropper behaviour
  * Added buttons
  * Added function placeholder
  */

/** V0.2
 ** Update 02/12/20
  * Recreated in PyQt
  * Corrected errors in runtime
  */

/** V0.1.1
 ** Update 03/11/20
  * Dropper now only appears for selection
  * Slider shows full spectrum
  * Dropper lines up with bar
  * Removed unnecessary imports
  * Documentation of functions and objects
  */

/** V0.1
 ** Creation 01/11/20
  * Rainbow selection
  * Slider with colour update
  * Make generic and repeatable
  * Minimum dependancy
  */

import QtQuick 2.11
import QtQuick.Controls 2.4
//import QtGraphicalEffects 1.0

//unnecessary import
//import QtQuick.Controls.Styles 1.4

//ApplicationWindow {
Page {
    id: window
    width: 800
    height: 440 // Window sizes
    visible: true // show
    background: Rectangle { // Changed to a background rectangle
        color: "#222222"
    }

    title: qsTr("Select Colour for " + b.getMode())

    Slider {
        id: colour
        anchors.centerIn: parent // Positioning
        width: 640
        height: 160
        anchors.verticalCenterOffset: -110
        anchors.horizontalCenterOffset: 0
        padding: 20


        background: Rectangle { // Background - rounded rectangle
            anchors.centerIn: parent
            x: colour.leftPadding // Positioning
            y: colour.topPadding + colour.availableHeight / 2 - height / 2 // Positioning within confines of slider object
            implicitWidth: 240
            implicitHeight: 90
            height: colour.availableWidth // Consistent size for design
            width: implicitHeight

            radius: 20 // Rounded edge
            rotation: -90 // Vertical gradient
            border.width: 1 // Border size
            border.color: "#333333" // Border colour

            gradient: Gradient {    // Display HSV rainbow for selection
            	// orientation: Gradient.Horizontal // Gradient orientation
            	// 6 points on hue circle
                GradientStop {  // Red
       	            position: 0.000
                    color: Qt.hsva(0.000, 1, 1)
                }
                GradientStop { // Yellow
                    position: 0.167
                    color: Qt.hsva(0.167, 1, 1)
                }
                GradientStop {  // Green
                    position: 0.333
                    color: Qt.hsva(0.333, 1, 1)
                }
                GradientStop { // Light blue
                    position: 0.500
                    color: Qt.hsva(0.500, 1, 1)
                }
                GradientStop { // Dark blue
                    position: 0.667
                    color: Qt.hsva(0.667, 1, 1)
                }
                GradientStop { // Magenta
                    position: 0.833
                    color: Qt.hsva(0.833, 1, 1)
                }
                GradientStop { // Red
                    position: 1.000
                    color: Qt.hsva(1.000, 1, 1)
                }
            } // End Gradient
        } // End background

        handle: Rectangle // Floating handle designed as a colour dropper
        {
            id: colourDropper
            width: 40
            height: 40
            x: width/2 + colour.value * (colour.background.height - width) // Fit the colour dropper to the selection bar
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


        }// End handle

        Connections {
            target: colour
            function onMoved() {
                //console.log(colourDropper.color)
                b.mqttCol(colourDropper.color)
            }
        }




    } // End slider

    Slider {
        id: brightness
        width: 640
        height: 160
        stepSize: 1
        anchors.horizontalCenterOffset: 0
        anchors.centerIn: parent
        padding: 20
        anchors.verticalCenterOffset: 50
        to: 100


        background: Rectangle {
            x: brightness.leftPadding
            y: brightness.topPadding + brightness.availableHeight / 2 - height / 2
            anchors.centerIn: parent
            height: brightness.availableWidth
            width: implicitHeight
            implicitWidth: 240
            implicitHeight: 90
            radius: 20
            rotation: -90
            border.color: "#333333"
            border.width: 1


            gradient: Gradient { // Generate gradient over slider
                GradientStop { // Black
                    position: 0
                    color: Qt.hsva(1, 0, 0)
                }

                GradientStop { // White
                    position: 1
                    color: Qt.hsva(1, 0, 1)
                }
                //orientation: Gradient.Horizontal
            } // End gradient

        } // End Background
        handle: Rectangle {
            id: brightnessDropper
            x: width/2 + (brightness.value/100) * (brightness.background.height - width)
            y: -this.height /2
            width: 40
            height: 40
            radius: 20

            //*/ Choice to show dropper only when pressed or all the time
            color: Qt.hsva(1, 0, (brightness.valueAt(brightness.position)/100))
            border.color: "#333333"

            /*/ Show dropper with currently selected colour

            color: brightness.pressed ? Qt.hsva(1, 0, brightness.valueAt(brightness.position))
                                      : "transparent"
            border.color: brightness.pressed ? "#333333" // Constant colour
                                             : "transparent"
            //*/
            implicitWidth: 30
            implicitHeight: 50
        } // End Handle


        Connections {
            target: brightness
            function onMoved() {
                //console.log(brightness.value)
                b.mqttBrt(brightness.value)
            }

        }



    } // End Slider

    Button {
        id: btnOff
        x: 474
        y: 114
        width: 100
        height: 70
        text: qsTr("Brightness\nMin")
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenterOffset: -180
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenterOffset: 165
        font.pointSize: 11
        font.family: "Tahoma"

        palette {
            button: "#111111"
            buttonText: "#eeeeee"
        }

        Connections {
            target: btnOff
            function onClicked() {
                //console.log("Off")
                brightness.value = 0

                b.debug(0)
                b.mqttBrt(brightness.value)
            }
        } // End connection
    } // End btnOff

    Button {
        id: btnOn
        x: 228
        y: 114
        width: 100
        height: 70
        text: qsTr("Brightness\nMax")
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenterOffset: 180
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenterOffset: 165
        font.pointSize: 11
        checkable: false
        font.family: "Tahoma"

        Connections {
            target: btnOn
            function onClicked() {
                //console.log("On")
                brightness.value = 100

                b.debug(1)
                b.mqttBrt(brightness.value)
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
        anchors.verticalCenterOffset: 165
        font.family: "Tahoma"
        anchors.horizontalCenterOffset: 0

        Connections {
            target: btnWhite
            function onClicked() {
                //("White")

                b.debug(1)
                b.mqttCol("#ffffee")
                //b.mqttBrt(brightness.value)
            }
        }
        anchors.horizontalCenter: parent.horizontalCenter
        checkable: false
    } // End btnWhite

}
