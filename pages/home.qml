/** V1.1
 ** Updated 26/02/21
  * Added clock, time and timer functions
  * Next stage: Implement alarms based on timer
  */

/** V0.5
 ** Created 21/02/21
  * Created for templating a home screen
  */

import QtQuick 2.11
import QtQuick.Controls 2.4


Page {
    id: homePage
    width: 800
    height: 440

    title: qsTr("Home Page")

    background: Rectangle {
        color: "#222222"
    }

    // Get current date and time
    property int hours: currentDate.getHours()
    property int minutes: currentDate.getMinutes()
    property int seconds: currentDate.getSeconds()
    property var currentDate: new Date()

    function pad(number) {
        var s = "0" + number;
        return s.substr(s.length-2);
    }

    Timer {
        // timer is synchronised to the animation timer
        // multiple of 1/30fps is most appropriate
        id: clockTime
        repeat: true
        interval: 500
        running: true


        onTriggered: {
            homePage.currentDate = new Date()



            // If midnight, update sunrise/sunset times
            if (hours === 0 & minutes === 0 & seconds === 0) {

            }


        }





    }

    Rectangle {
        id: rectangle
        width: 205
        height: 200
        color: "#999999"
        radius: 100
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter

        Label {
            text: (qsTr(pad(hours) + ":" + pad(minutes) + ":" + pad(seconds)))
            anchors.centerIn: parent
            font.pointSize: 20
            font.family: "Tahoma"

        }

    }




}
