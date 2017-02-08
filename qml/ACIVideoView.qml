import QtQuick 2.5
import QtMultimedia 5.5

Item {
    id: videoView;
    signal exitVideo

    function setVideoSource(name){
        video.source = name;
        video.play();
    }

    function handleDirUp(){
        video.stop();
        exitVideo();
    }

    function handleRot(direction){
        console.log("videoView.handleRot"+direction)
        if(direction===0){
            video.seek(video.position + 2000)
        } else {
            video.seek(video.position - 2000)
        }
    }

    Rectangle { anchors.fill: parent; color: "black" }

    Video {
        id: video
        anchors.fill: parent;
    }

    Rectangle {
        color: Qt.rgba(0.0,0.0,0.0,0.5);

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

    Component.onCompleted: {
        video.source = "C:/temp/Wildlife.wmv";
        video.play();
    }
}
