## V0.2
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

# Signals and slots for QML interaction
class backend(qtcore.QObject):
    @qtcore.Slot(str)
    def output(self, s):
        print(s)




if __name__ == "__main__":
    app = qtgui.QGuiApplication(sys.argv)
    engine = qtqml.QQmlApplicationEngine()
    context = engine.rootContext()

    # Create linking object
    b = backend()

    # Expose object to QML
    context.setContextProperty("b",b)

    # Load main QML file
    engine.load(os.path.abspath("view.qml"))

    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec_())
