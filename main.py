## V1.0
# Creation 01/11/20
# Auto gerenated

import sys
import os

from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine


if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    engine.load(os.path.abspath("view.qml"))

    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec_())
