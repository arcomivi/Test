import QtQuick 2.5
import QtMultimedia 5.5
//import ACIElements 1.0

//Rectangle
Item {
    id: mainview
    //color: "transparent"

    // ==> properties
    property int m_current: -1

    signal update
    signal restart
    signal navigateTo(int widget);
    signal zoominNavi;
    signal zoomoutNavi;


    //  ==> functions
//    function rotateCW(){
//        standardListView.rotateCW();
//    }

//    function rotateCCW(){
//        standardListView.rotateCCW();
//    }

    function handleRot(direction){
        console.log("mainview-handleRot: "+ direction + " ("+m_current+")");
        if(m_current===-1) { m_current = 1; }        
        mainview.children[m_current].handleRot(direction);
    }

    function handlePush(){
        mainview.children[m_current].handlePush();
    }

    function handleRelease() {
        mainview.children[m_current].handleRelease();
    }

    function handleDirUp(){
        console.log("mainview-handleDirUp");
        mainview.children[m_current].handleDirUp();
    }

    function handleDirDown(){
        console.log("mainview-handleDirDown");
        //TODO: refactor
        if(mainview.m_current===1) {
            mainview.m_current = 2;
            viewsSwitcher.goToView(2);
        } else if(mainview.m_current===2) {
            mainview.m_current = 3;
            mainview.children[m_current].handleEnter();
        }
    }
Rectangle { anchors.fill: parent; color: "#636363"; z: 0;}
    // ==> UI elements
    // ===> background image (m_current === 0)
//    Image {
//        id: wallpaper
//        anchors.centerIn: parent;
//        //width: Math.floor(parent.width);
//        //height: Math.floor(parent.height);
////        source: "/usr/share/arcomivi/css/common/wallpaper640x480.png"
//        asynchronous: true;
//    }

    // ===> Main Menu (m_current === 1)
    MainMenu {
        id: mainMenu;
        objectName: "mainMenu"
        width: parent.width;
        height: Math.floor(parent.height*0.1);
        anchors.top: mainview.top;
        g_cssprefix: "/usr/share/arcomivi/";
        onNavigateTo: {
//            mainview.navigateTo(widget);
            switch(widget){
            case 0:
                break;
            case 3:
                //mainview.m_current = 2;
                //viewsSwitcher.goToView(0);
                break;
            case 9:
                //mainview.m_current = 2;
                //viewsSwitcher.goToView(1);
                //update
                mainview.update();
                break;
            }
        }
        onEnterMedia: {
            mainview.m_current = 2;
            viewsSwitcher.goToView(0);
        }
    }

//    // ===> Views: Navigation, Music, ... (m_current === 2)
//    Item {
//        id: viewsSwitcher;
//        width: parent.width;
//        height: Math.floor(parent.height*0.7);
//        anchors.top: mainMenu.bottom;
//        property alias pages: viewsSwitcherItem.children;
//        property Item currentPage;


//        function jumpTo(idx){

//            for(var i = 0; i < pages.length; i++)
//            {
//                pages[i].x = 999;
//                console.log("Jump to-move to: "+pages[i].x);
//            }
//            pages[idx].x = 0;
//            currentPage = pages[idx];
//            console.log("Jump to: "+idx +", "+pages[idx].x);
//        }

//        function goToView(view){
//            console.log("viewsSwitcher-goToView: " + view +" ("+m_current+")");
//            console.log(pages[view]);
//            jumpTo(view);
//        }

//        function handleRot(direction){
//            console.log("viewsSwitcher-handleRot"+ direction);
//            if(direction===0){
//                mainview.zoominNavi();
//            } else {
//                mainview.zoomoutNavi();
//            }
//        }

//        //        function handleDirDown(){
//        //            console.log("handleDirDown");
//        //            viewsSwitcher.goToMenu(4);//4==MenuNavigation
//        //        }

//        function handleDirUp(){
//            console.log("viewsSwitcher-handleDirUp");
//            //TODO: refactor
//            mainview.m_current = 1;
//            //            viewsSwitcher.navigateTo(8);//8==MenuMain
//        }

//        Item {
//            id: viewsSwitcherItem
//            width: parent.width; height: parent.height;
//            anchors.fill: parent
//            //0
//            Item {
//                id: viewFoo;
//                objectName: "foo"
//                width: parent.width; height: parent.height;
////                anchors.fill: parent
//                Rectangle { color: "green"; anchors.fill: parent; }
//            }
//            //1
//            Item {
//                id: viewBar;
//                objectName: "bar"
//                width: parent.width; height: parent.height;
////                anchors.fill: parent
//                Rectangle { color: "blue"; anchors.fill: parent; }
//            }
//        }
//    }

    ViewsSwitcher {
        id: viewsSwitcher
        objectName: "viewsSwitcher"
        width: parent.width;
        property int m_viewsSwitcher_current: -1;
        height: Math.floor(parent.height*0.7);
        anchors {
            top: mainMenu.bottom;
            //bottom: statusBar.top;
            //bottom: viewSteerings.top;
        }

        function goToView(view){
            m_viewsSwitcher_current = view;
            console.log("viewsSwitcher-goToView: " + view +" ("+m_current+")");
            console.log(pages[view]);
            jumpTo(view);
        }

//        property Item currentView;

////        signal backToPrevious;
////        signal goToMenu(int menu);
////        signal navigateTo(int widget);
////        signal zoominNavi;
////        signal zoomoutNavi;

//        function goToView(view){
//            console.log("goToView: " + view);
//            viewsSwitcher.switchTo(view);
//            currentView = viewsSwitcher.pages[view];
//        }

        function handleRot(direction){
            console.log("ViewsSwitcher.handleRot"+ direction);
            pages[m_viewsSwitcher_current].handleRot(direction);
////            if(direction===0){
////                viewsSwitcher.zoominNavi();
////            } else {
////                viewsSwitcher.zoomoutNavi();
////            }
        }
        function handleRelease() {
            pages[m_viewsSwitcher_current].handleRelease();
        }

////        function handleDirDown(){
////            console.log("handleDirDown");
////            viewsSwitcher.goToMenu(4);//4==MenuNavigation
////        }

//        function handleDirUp(){
//            console.log("handleDirUp");
////            viewsSwitcher.navigateTo(8);//8==MenuMain
//        }
////        function setList(list){
////            viewSettings.fooList = list;
////        }

        pages: [
            //0
            //ACIMedia - list: Music, Video, Pictures, Radio, Television
            //ACIMusic - list: all from Music,
            //ACIVideo - list: all from Videos
            //ACIPictures - list: all from Pictures
            //ACIRadio - list: radio stations
            //ACITelevision - list: Streams, DVB
            //0
            Item {
                id: acimediaview;
                width: parent.width; height: parent.height;

                function handleRelease() {
                    console.log("acimediaview.handleRelease");
                    mediaplayer.stop();
                    mediaplayer.source = list.model.getCurrentDescr(list.currentIndex);
                    mediaplayer.play();
                }

                function handleRot(direction){
                    console.log("acimediaview.handleRot: "+direction)
                    if(direction === 0){
                        rotateCW();
                    } else {
                        rotateCCW();
                    }
                }

                function rotateCW(){
                    if((list.currentIndex + 1) < list.count){
                        list.currentIndex = list.currentIndex + 1;
                    }
                    list.positionViewAtIndex(list.currentIndex, ListView.Center);
                }

                function rotateCCW(){
                    if((list.currentIndex-1)  >=0){
                        list.currentIndex = list.currentIndex-1;
                    }
                    list.positionViewAtIndex(list.currentIndex, ListView.Center);
                }

                MediaPlayer {
                    id: mediaplayer
                    source: ""
                }

                ListView {
                    id: list;
                    width: Math.floor(parent.width);
                    height: Math.floor(parent.height);
                    focus: true
                    anchors.fill: parent;
                    model: listModel;
                    anchors {
                        fill: parent;
                    }
                    delegate:
                        ACIStandardListItem {
                        height: Math.floor(list.height / 5);
                        property string foo: ""
                        onItemClicked: {
                            list.currentIndex = index;
                            listModel.listClicked(index);
                            console.log(descr);

                            mediaplayer.source = descr;
                            mediaplayer.play();
                        }
                    }
                    onCurrentIndexChanged: {
                        console.log(list.model.getCurrentName(list.currentIndex));
                    }
                }
            },
//            //1
//            ACICamera {
//                id: acicam;
//                width: parent.width; height: parent.height;
//            },

            //2
            Item {
                id: viewFoo;
                objectName: "foo"
                width: parent.width; height: parent.height;
                Rectangle { color: "transparent"; anchors.fill: parent;
                    Text {
                        id: name
                        text: qsTr("10:05")
                        color: "white"
                        font.pixelSize: 40;
                        anchors.centerIn: parent;
                    }
                }
            }
            //1
//            Item {
//                id: viewBar;
//                objectName: "bar"
//                width: parent.width; height: parent.height;
//                Rectangle { color: "blue"; anchors.fill: parent; }
//                Camera {
//                    id: camera1
//                    deviceId: "/dev/video0"
//                    viewfinder.resolution.width: 320;
//                    viewfinder.resolution.height: 240;
////                    viewfinder.minimumFrameRate: 0;
////                    viewfinder.maximumFrameRate: 15;
//               }
//                Camera{
//                    id: camera2
//                    deviceId: "/dev/video1"
//                    viewfinder.resolution.width: 320;
//                    viewfinder.resolution.height: 240;
////                    viewfinder.maximumFrameRate: 25;
//                }


//                MediaPlayer {
//                        id: mediaplayer
//                        source: "file:///home/simon/Videos/Cud-niepamięci-cover.mp4"
//                    }
//                VideoOutput {
//                    id: vid1;
//                    source: camera1; //
////                    source: mediaplayer; //
//                    anchors.left: parent.left
//                    anchors.top: parent.top
//                    width: parent.width/2;
//                    height: parent.height;
//                    focus : visible // to receive focus and capture key events when visible
//                    MouseArea {
//                        anchors.fill: parent;
//                        onClicked: {
//                            console.log(camera1.supportedViewfinderResolutions().length);
//                            for(var i=0; i<camera1.supportedViewfinderResolutions().length;i++){
//                                console.log(camera1.supportedViewfinderResolutions()[i].width+" x "+camera1.supportedViewfinderResolutions()[i].height);
//                            }
//                            console.log(camera1.viewfinder.maximumFrameRate);
//                            console.log(camera1.supportedViewfinderFrameRateRanges().length);
//                            for(var k=0;k<camera1.supportedViewfinderFrameRateRanges().length;k++){
//                                console.log(camera1.supportedViewfinderFrameRateRanges()[k].minimumFrameRate+", "+camera1.supportedViewfinderFrameRateRanges()[k].maximumFrameRate);
//                            }


//                        }
////                        onClicked: camera.imageCapture.capture();
////                        onPressed: mediaplayer.play();
//                    }
//                }
//                VideoOutput {
//                    id: vid2;
//                    source: camera2; //
////                    source: mediaplayer; //
//                    anchors.right: parent.right
//                    anchors.top: parent.top
//                    width: parent.width/2;
//                    height: parent.height;
//                    focus : visible // to receive focus and capture key events when visible
//                    MouseArea {
//                        anchors.fill: parent;
//                        onClicked: {
//                            console.log(camera2.supportedViewfinderResolutions().length);
//                            for(var i=0; i<camera2.supportedViewfinderResolutions().length;i++){
//                                console.log(camera2.supportedViewfinderResolutions()[i].width+"x"+camera2.supportedViewfinderResolutions()[i].height);
//                            }

//                            console.log(camera2.viewfinder.maximumFrameRate);
//                            console.log(camera2.supportedViewfinderFrameRateRanges().length);
//                            for(var k=0;k<camera2.supportedViewfinderFrameRateRanges().length;k++){
//                                console.log(camera2.supportedViewfinderFrameRateRanges()[k].minimumFrameRate+", "+camera2.supportedViewfinderFrameRateRanges()[k].maximumFrameRate);
//                            }
//                        }

////                        onClicked: camera2.imageCapture.capture();
////                        onPressed: mediaplayer.play();
//                    }
//                }
//            }
        ]
//            //1
////            Item {
////                id: dummy;
////                objectName: "dummy"
////                width: parent.width; height: parent.height;
////            }


////            //1
////            SettingsView {
////                id: viewSettings;
////                objectName: "viewSettings"
////                width: parent.width; height: parent.height;

////            }

    }

/*    Steerings {
        id: viewSteerings
        objectName: "viewSteerings"
        width: parent.width;
        height: Math.floor(parent.height*0.15);
        g_cssprefix: "/usr/share/arcomivi/";
        onVolup: mediaplayer.volume = mediaplayer.volume + 0.1;
        onVoldown: mediaplayer.volume = mediaplayer.volume - 0.1;
        onBackToPrevious: { mainview.m_current=2; }
        anchors {
//            top: viewsSwitcher.bottom;
            bottom: statusBar.top;
        }
    }*/

    //status bar
    StatusBar {
        id: statusBar;
        objectName: "statusBar"
        width: parent.width;
        height: Math.floor(parent.height*0.05);
        g_cssprefix: "/usr/share/arcomivi/";
        anchors {
            bottom: mainview.bottom;
        }
    }

}
