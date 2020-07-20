import QtQuick 2.11
import QtQuick.Layouts 1.11
import SddmComponents 2.0 as SDDM

ColumnLayout {
    id: formContainer
    SDDM.TextConstants { id: textConstants }

    Rectangle {
        id: topMarginLoginForm
        height: parent.height / 5
        width: parent.width / 2
        color: "#777"
        opacity: 0
    }

    Image {
        id: userImage

        sourceSize.height: parent.height / 5
        anchors.horizontalCenter: parent.horizontalCenter
        source: Qt.resolvedUrl("../Assets/User.png")
        asynchronous: true
        cache: true
        clip: true
        mipmap: true

        anchors.top: topMarginLoginForm.bottom
        anchors.topMargin: 50
    }

    Input {
        id: input
        Layout.alignment: QT.AlignTop
        Layout.leftMargin: 0
        Layout.topMargin: 0
        anchors.top: userImage.bottom
        anchors.topMargin: 50
    }
}
