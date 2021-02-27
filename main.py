## V1.0
# Updated 25/02/21
# Added MQTT library
# Publishing
# More QML functions
# Mode switching for lights

## V0.5
# Updated 21/02/21
# Adding functions

## V0.1
# Creation 01/11/20
# Auto gerenated

import sys
import os

import PySide2.QtGui as qtgui
import PySide2.QtQml as qtqml
import PySide2.QtCore as qtcore

import paho.mqtt.client as paho

# Signals and slots for QML interaction
class backend(qtcore.QObject):
    def __init__(self):
        super().__init__()
        #print("Initiating MQTT client")
        pass

    mode = 'strip'

    @qtcore.Slot(str)
    def debug(self, s):
        print(s)
        pass
    @qtcore.Slot(str)
    def mqttCol(self, arg):
        send = str("lights/" + str(self.getMode()) + "/colour")
        client.connect(broker,port,QoS)
        ret = client.publish(send , str(arg)) #"lights/strip/colour"
        print(send)
        pass
    @qtcore.Slot(str)
    def mqttBrt(self, arg):
        send = str("lights/" + str(self.getMode()) + "/brightness")
        client.connect(broker,port,QoS)
        ret = client.publish(send, str(arg)) #"lights/strip/brightness"
        print(send)
        pass
    @qtcore.Slot(str)
    def setMode(self, arg):
        self.mode = arg
        pass
    @qtcore.Slot()
    def getMode(self):
        return self.mode


if __name__ == "__main__":
    app = qtgui.QGuiApplication(sys.argv)
    engine = qtqml.QQmlApplicationEngine()
    context = engine.rootContext()

    # Create MQTT client
    #broker = "192.168.1.176" # teejberry.local
    broker = "teejberry"
    #broker = "teejberry.local"
    port = 1883
    QoS = 1
    def on_publish(client,userdata,result):
        #print("data published: ")
        #print(userdata)
        pass
    client = paho.Client("controlGUI")
    client.on_publish = on_publish
    client.connect(broker,port, QoS)

    # Create linking object
    b = backend()
    # Expose object to QML
    context.setContextProperty("b",b)

    # Load main QML file
    engine.load(os.path.abspath("view.qml"))

    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec_())
