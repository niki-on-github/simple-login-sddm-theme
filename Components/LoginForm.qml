import QtQuick 2.11
import QtQuick.Layouts 1.11
import SddmComponents 2.0 as SDDM

ColumnLayout {
    id: formContainer
    SDDM.TextConstants { id: textConstants }

    Rectangle {
        id: topMarginLoginForm
        height: parent.height / 8
        width: parent.width / 2
        color: "#777"
        opacity: 0
    }

    Image {
        id: userImage
        sourceSize.height: parent.height / 5
        source: Qt.resolvedUrl("../Assets/User.png")
        asynchronous: true
        cache: true
        clip: true
        mipmap: true
        Layout.alignment: Qt.AlignBottom | Qt.AlignHCenter
    }

    Input {
        id: input
        Layout.leftMargin: 0
        Layout.topMargin: 0
        anchors.topMargin: 50
    }
}
