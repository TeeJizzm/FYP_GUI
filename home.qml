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
    id: page
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
        id: timer
        repeat: true
        interval: 1000
        running: true


        onTriggered: page.currentDate = new Date()
    }

    Rectangle {
        id: rectangle
        x: 199
        y: 93
        width: 200
        height: 200
        color: "#999999"
        radius: 100
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter

        Label {
            text: (qsTr(pad(pad(hours)) + ":" + pad(pad(minutes)) + ":" + pad(pad(seconds))))
            anchors.centerIn: parent
            font.pointSize: 20
            font.family: "Tahoma"

        }

    }




}
