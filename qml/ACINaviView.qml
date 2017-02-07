import QtQuick 2.5
import QtPositioning 5.3
import QtLocation 5.6

Item {
    anchors.fill: parent;
    Rectangle {
        color: "#636363"
        anchors.fill: parent;
        Text {
            id: navi
            text: qsTr("navi")
            color: "white"
            anchors.centerIn: parent;
        }
    }
    Plugin {
        id: osmPlugin
        name: "osm"
        //        PluginParameter { name: "osm.useragent"; value: "My great Qt OSM application" }
        //        PluginParameter { name: "osm.mapping.host"; value: "http://osm.tile.server.address/" }
        //        PluginParameter { name: "osm.mapping.copyright"; value: "All mine" }
        //        PluginParameter { name: "osm.routing.host"; value: "http://osrm.server.address/viaroute" }
        //        PluginParameter { name: "osm.geocoding.host"; value: "http://geocoding.server.address" }
        // specify plugin parameters if necessary
        // PluginParameter {
        //     name:
        //     value:
        // }
    }

    Map {
        anchors.fill: parent
        plugin: osmPlugin
        center: QtPositioning.coordinate(59.91, 10.75) // Oslo
        zoomLevel: 10
    }
}
