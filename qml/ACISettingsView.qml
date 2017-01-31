import QtQuick 2.5

Item {
    id: settingsView;
    Rectangle { color: "#636363"; anchors.fill: parent;
        Text {
            id: settingsViewText
            text: qsTr("Settings")
            color: "white"
            font.pixelSize: 60;
            anchors.centerIn: parent;
        }
    }
}
