import QtQuick 2.5

//import ACIElements 1.0

Item {
    id: mainview

    // ==> properties
    property int m_current: -1

    signal update
    signal restart
    signal navigateTo(int widget);
    signal zoominNavi;
    signal zoomoutNavi;

    signal loadMedia


    //  ==> functions
    function handleRot(direction){
        console.log("mainview-handleRot: "+ direction + " ("+m_current+")");
        if(m_current===-1) { m_current = 0; }
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

        if(mainview.m_current===0) {
            mainview.m_current = 1;
            viewsSwitcher.goToView(1);
        } else if(mainview.m_current===1) {
            mainview.m_current = 2;
            mainview.children[m_current].handleEnter();
        }
    }

    // ==> UI elements
    // ===> Main Menu (m_current === 0)
    MainMenu {
        id: mainMenu;
        objectName: "mainMenu"
        width: parent.width;
        height: Math.floor(parent.height*0.1);
        anchors.top: mainview.top;
        //g_cssprefix: "/usr/share/arcomivi/";
        g_cssprefix: "file:///C:/Qt/ws/Test/Test/"

        onNavigateTo: {
//            mainview.navigateTo(widget);
            switch(widget){
            case 0:
                break;
            case 3:

                break;
            case 9:
                //update
                mainview.update();
                break;
            }
        }
        onEnterMedia: {
            loadMedia();
            mainview.m_current = 1;
            viewsSwitcher.pages[2].source = "";
            viewsSwitcher.pages[1].source = "ACIMediaView.qml";
            viewsSwitcher.goToView(1);
        }
        onEnterSettings: {
            console.log("onEnterSettings");
            mainview.m_current = 1;
            viewsSwitcher.pages[0].visible = false;
            viewsSwitcher.pages[1].source = "";
            console.log("onEnterSettings: "+viewsSwitcher.pages[2]);
            viewsSwitcher.pages[2].source = "ACISettingsView.qml";
            console.log("onEnterSettings: "+viewsSwitcher.pages[2].source);
            viewsSwitcher.goToView(2);
        }
    }

    //    (m_current === 1)
    ViewsSwitcher {
        id: viewsSwitcher
        objectName: "viewsSwitcher"
        width: parent.width;
        property int m_viewsSwitcher_current: -1;
        height: Math.floor(parent.height*0.7);
        anchors {
            top: mainMenu.bottom;
        }

        function goToView(view){
            m_viewsSwitcher_current = view;
            console.log("viewsSwitcher-goToView: " + view +" ("+m_current+")");
            console.log(pages[view]);
            jumpTo(view);
        }

        function handleDirUp(){
            console.log("ViewsSwitcher.handleDirUp");
            pages[m_viewsSwitcher_current].item.handleDirUp();
        }

        function handleRot(direction){
            console.log("ViewsSwitcher.handleRot"+ direction);
            pages[m_viewsSwitcher_current].item.handleRot(direction);
        }
        function handleRelease() {
            pages[m_viewsSwitcher_current].item.handleRelease();
        }

        pages: [
            //0
            //ACIMedia - list: Music, Video, Pictures, Radio, Television
            //ACIMusic - list: all from Music,
            //ACIVideo - list: all from Videos
            //ACIPictures - list: all from Pictures
            //ACIRadio - list: radio stations
            //ACITelevision - list: Streams, DVB

            //0
            ACIHomeView{ },
            //1
            Loader { id: mediaViewLoader; anchors.fill: parent; },
            //2
            Loader { id: settingsViewLoader; anchors.fill: parent; }
        ]
        Connections {
            target: mediaViewLoader.item;
            onGoUp: {
                console.log("go up");
                mainview.m_current = 0;
            }
        }
    }

    //    (m_current === 2)
    Steerings {
        id: viewSteerings
        objectName: "viewSteerings"
        width: parent.width;
        height: Math.floor(parent.height*0.15);
        //g_cssprefix: "/usr/share/arcomivi/";
        g_cssprefix: "file:///C:/Qt/ws/Test/Test1/"
        anchors {
            bottom: statusBar.top;
        }

        onVolup: mediaplayer.volume = mediaplayer.volume + 0.1;
        onVoldown: mediaplayer.volume = mediaplayer.volume - 0.1;
        onPlaypauseMusic: acimediaview.handleRelease();
        onBackToPrevious: { mainview.m_current = 2; }

    }

    //status bar
    //    (m_current === 3)
    StatusBar {
        id: statusBar;
        objectName: "statusBar"
        width: parent.width;
        height: Math.floor(parent.height*0.05);
        //g_cssprefix: "/usr/share/arcomivi/";
        g_cssprefix: "file:///C:/Qt/ws/Test/Test/"
        anchors {
            bottom: mainview.bottom;
        }
    }

}
