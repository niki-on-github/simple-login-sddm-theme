import QtQuick 2.11
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.4
import QtGraphicalEffects 1.0
import QtQuick.Window 2.1
import "Components"

Pane {
    id: root

    height: Screen.height
    width: Screen.ScreenWidth

    LayoutMirroring.enabled: false
    LayoutMirroring.childrenInherit: true

    padding: 0
    palette.button: "transparent"
    palette.highlight: "white"
    palette.text: "white"
    palette.buttonText: "white"
    palette.window: "#999"

    font.family: config.Font || "Noto Sans"
    font.pointSize: parseInt(height / 60)
    focus: true

    Item {
        id: sizeHelper

        anchors.fill: parent
        height: parent.height
        width: parent.width


        LoginForm {
            id: form

            height: parent.height * 0.66
            width: parent.width / 2.1
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            z: 1
        }

        Image {
            id: backgroundImage

            height: parent.height
            width: parent.width

            horizontalAlignment: Image.AlignHCenter

            source: config.background || config.Background || "Background.jpg"
            fillMode: Image.PreserveAspectCrop
        }

        FastBlur {
            id: backgroundBlur
            anchors.fill: backgroundImage
            source: backgroundImage
            radius: 50
        }

        MouseArea {
            anchors.fill: backgroundImage
            onClicked: parent.forceActiveFocus()
        }
    }
}
