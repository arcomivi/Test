import QtQuick 2.5

Item {
    id: viewHome;
    //objectName: "viewHome"
    visible: true;
    width: parent.width; height: parent.height;
    Rectangle { color: "#636363"; anchors.fill: parent;
        Text {
            id: viewHomeText;
            text: qsTr("10:05")
            color: "white"
            font.pixelSize: 60;
            anchors.centerIn: parent;
        }
    }
}
