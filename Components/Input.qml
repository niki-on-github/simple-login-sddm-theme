import QtQuick 2.11
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.4
import QtGraphicalEffects 1.0

Column {
    id: inputContainer
    Layout.fillWidth: true

    property bool failed

    // USERNAME INPUT
    Item {
        id: usernameField

        height: root.font.pointSize * 4.5
        width: parent.width / 2
        anchors.horizontalCenter: parent.horizontalCenter

        ComboBox {

            id: selectUser

            width: parent.height
            height: parent.height
            anchors.left: parent.left
            z: 2

            model: userModel
            currentIndex: model.lastIndex
            textRole: "name"
            hoverEnabled: true
            onActivated: {
                username.text = currentText
            }

            delegate: ItemDelegate {
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                contentItem: Text {
                    text: model.realName != "" ? model.realName : model.name
                    font.pointSize: root.font.pointSize * 0.8
                    font.capitalization: Font.Capitalize
                    color: selectUser.highlightedIndex === index ? "#444" : root.palette.highlight
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                highlighted: parent.highlightedIndex === index
                background: Rectangle {
                    color: selectUser.highlightedIndex === index ? root.palette.highlight : "transparent"
                }
            }

            indicator: Button {
                    id: usernameIcon
                    width: selectUser.height
                    height: parent.height
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: 0
                    //anchors.leftMargin: selectUser.height * 0.125
                    icon.height: parent.height * 0.25
                    icon.width: parent.height * 0.25
                    enabled: false
                    icon.color: root.palette.text
                    icon.source: Qt.resolvedUrl("../Assets/User.svgz")
            }

            background: Rectangle {
                color: "transparent"
                border.color: "transparent"
            }

            popup: Popup {
                y: parent.height - username.height / 3
                rightMargin: undefined
                width: usernameField.width
                implicitHeight: contentItem.implicitHeight
                padding: 10

                contentItem: ListView {
                    clip: true
                    implicitHeight: contentHeight + 20
                    model: selectUser.popup.visible ? selectUser.delegateModel : null
                    currentIndex: selectUser.highlightedIndex
                    ScrollIndicator.vertical: ScrollIndicator { }
                }

                background: Rectangle {
                    radius: 20 / 2
                    color: "#444"
                    layer.enabled: true
                    layer.effect: DropShadow {
                        transparentBorder: true
                        horizontalOffset: 0
                        verticalOffset: 0
                        radius: 100
                        samples: 201
                        cached: true
                        color: "#88000000"
                    }
                }

                enter: Transition {
                    NumberAnimation { property: "opacity"; from: 0; to: 1 }
                }
            }

            states: [
                State {
                    name: "pressed"
                    when: selectUser.down
                    PropertyChanges {
                        target: usernameIcon
                        icon.color: Qt.lighter(root.palette.highlight, 1.1)
                    }
                },
                State {
                    name: "hovered"
                    when: selectUser.hovered
                    PropertyChanges {
                        target: usernameIcon
                        icon.color: Qt.lighter(root.palette.highlight, 1.2)
                    }
                },
                State {
                    name: "focused"
                    when: selectUser.visualFocus
                    PropertyChanges {
                        target: usernameIcon
                        icon.color: root.palette.highlight
                    }
                }
            ]

            transitions: [
                Transition {
                    PropertyAnimation {
                        properties: "color, border.color, icon.color"
                        duration: 150
                    }
                }
            ]

        }

        TextField {
            id: username
            text: selectUser.currentText
            font.capitalization: Font.Capitalize
            anchors.centerIn: parent
            height: root.font.pointSize * 3
            width: parent.width
            placeholderText: textConstants.userName
            selectByMouse: true
            horizontalAlignment: TextInput.AlignHCenter
            renderType: Text.QtRendering
            background: Rectangle {
                color: "transparent"
                border.color: root.palette.text
                border.width: parent.activeFocus ? 2 : 1
                radius: 20
            }
            Keys.onReturnPressed: sddm.login(username.text, password.text, sessionSelect.selectedSession)
            KeyNavigation.down: password
            z: 1

            states: [
                State {
                    name: "focused"
                    when: username.activeFocus
                    PropertyChanges {
                        target: username.background
                        border.color: root.palette.highlight
                    }
                    PropertyChanges {
                        target: username
                        color: root.palette.highlight
                    }
                }
            ]
        }

    }

    // PASSWORD INPUT
    Item {
        id: passwordField
        height: root.font.pointSize * 4.5
        width: parent.width / 2
        anchors.horizontalCenter: parent.horizontalCenter

        TextField {
            id: password
            anchors.centerIn: parent
            height: root.font.pointSize * 3
            width: parent.width
            focus: true
            selectByMouse: true
            echoMode: TextInput.Password
            placeholderText: textConstants.password
            horizontalAlignment: TextInput.AlignHCenter
            passwordCharacter: "•"
            passwordMaskDelay: undefined
            renderType: Text.QtRendering
            background: Rectangle {
                color: "transparent"
                border.color: root.palette.text
                border.width: parent.activeFocus ? 2 : 1
                radius: 20
            }

            Keys.onReturnPressed: sddm.login(username.text, password.text, sessionSelect.selectedSession)
        }

        states: [
            State {
                name: "focused"
                when: password.activeFocus
                PropertyChanges {
                    target: password.background
                    border.color: root.palette.highlight
                }
                PropertyChanges {
                    target: password
                    color: root.palette.highlight
                }
            }
        ]

        transitions: [
            Transition {
                PropertyAnimation {
                    properties: "color, border.color"
                    duration: 150
                }
            }
        ]
    }


    // ERROR FIELD
    Item {
        height: root.font.pointSize * 2.3
        width: parent.width / 2
        anchors.horizontalCenter: parent.horizontalCenter
        Label {
            id: errorMessage
            width: parent.width
            text: failed ? textConstants.loginFailed + "!" : keyboard.capsLock ? textConstants.capslockWarning : null
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: root.font.pointSize * 0.8
            font.italic: true
            color: root.palette.text
            opacity: 0
            states: [
                State {
                    name: "fail"
                    when: failed
                    PropertyChanges {
                        target: errorMessage
                        opacity: 1
                    }
                },
                State {
                    name: "capslock"
                    when: keyboard.capsLock
                    PropertyChanges {
                        target: errorMessage
                        opacity: 1
                    }
                }
            ]
            transitions: [
                Transition {
                    PropertyAnimation {
                        properties: "opacity"
                        duration: 100
                    }
                }
            ]
        }
    }


    // SESSION SELECT
    SessionButton {
        id: sessionSelect
        textConstantSession: textConstants.session
    }

    Connections {
        target: sddm
        function onLoginSucceeded() {}
        function onLoginFailed() {
            failed = true
            resetError.running ? resetError.stop() && resetError.start() : resetError.start()
        }
    }

    Timer {
        id: resetError
        interval: 2000
        onTriggered: failed = false
        running: false
    }
}
