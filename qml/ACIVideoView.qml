import QtQuick 2.5
import QtMultimedia 5.5

Item {
    anchors.fill: parent;

    function setVideoSource(name){
        video.source = name;
        video.play();
    }
    Rectangle { anchors.fill: parent; color: "black" }
    Video {
        id: video
        anchors.fill: parent;
    }

    Rectangle { color: Qt.rgba(0.0,0.0,0.0,0.4);

        Text {
            id: foo
            text: qsTr("Steering Video");
            color: "white"
            anchors.centerIn: parent;
        }
        anchors.bottom: parent.bottom;
        width: parent.width;
        height: 100;
    }
}
