import QtQuick 2.5

Item {
    id: settingsView;

    signal goUp
    signal goDown

    function handleDirUp(){
        console.log("settingsView.handleDirUp");
        goUp();
    }
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
