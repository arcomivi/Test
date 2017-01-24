import QtQuick 2.5

Rectangle {
    id: rootSteerEmpty
    color: Qt.rgba(0.0, 0.0, 0.0, 0.0)
    width: parent.width
    height: parent.height

    //properties
    property int noOfElements: 0
    property string btnPrefix: "empty-bt-"
    property int m_current: -1

    Image {
        id: logo
        height: parent.height
        source: g_cssprefix + "css/common/Arcom-ivi_logo.png"
        anchors.centerIn: parent
        fillMode: Image.PreserveAspectFit
        smooth: true
    }
}
