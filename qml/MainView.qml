import QtQuick 2.5

//import ACIElements 1.0

Item {
    id: mainview

    // ==> properties
    property int m_current: -1
    property string g_cssprefix: Qt.platform.os==="windows"?"file:///C:/Qt/ws/Test/Test/":"/usr/share/arcomivi/";

    signal update
    signal restart
    signal navigateTo(int widget);
    signal zoominNavi;
    signal zoomoutNavi;

    signal loadMedia
    signal volup
    signal voldown


    //  ==> functions
    function sendProgress(progress){
        console.log("progress: "+progress);
        viewSteerings.setMusicProgress(progress);
    }

    function handleRot(direction){
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
        mainview.children[m_current].handleDirUp();
    }

    function handleDirDown(){
        mainview.children[m_current].handleDirDown();
    }

    Component.onCompleted: {
        if(m_current===-1) { m_current = 0; }
        mainview.children[m_current].handleEnter();
        viewsSwitcher.pages[0].source = "ACIHomeView.qml";
    }

    // ==> UI elements
    // ===> Main Menu (m_current === 0)
    MainMenu {
        id: mainMenu;
        width: parent.width;
        height: Math.floor(parent.height*0.1);
        anchors.top: mainview.top;

        onGoDown: {
            handleLeave();
            mainview.m_current = 1;
            viewsSwitcher.handleEnter();
        }

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
            handleLeave();
            mainview.m_current = 1;
            viewsSwitcher.enterMedia();
        }
        onEnterSettings: {
            handleLeave();
            mainview.m_current = 1;
            viewsSwitcher.enterSettings();
        }
    }

    //    (m_current === 1)
    ViewsSwitcher {
        id: viewsSwitcher
        width: parent.width;
        property int m_viewsSwitcher_current: -1;
        height: Math.floor(parent.height*0.7);
        anchors {
            top: mainMenu.bottom;
        }

        function enterMedia(){
            loadMedia();
            viewsSwitcher.pages[2].source = "";
            viewsSwitcher.pages[0].source = "";
            viewsSwitcher.pages[1].source = "ACIMediaView.qml";
            viewsSwitcher.goToView(1);
        }
        function enterSettings(){
            viewsSwitcher.pages[0].source = "";
            viewsSwitcher.pages[1].source = "";
            viewsSwitcher.pages[2].source = "ACISettingsView.qml";
            viewsSwitcher.goToView(2);
        }

        function handleEnter(){

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
            //ACIHomeView
            //ACIMedia - list: Music, Video, Pictures, Radio, Television
            //ACIMusic - list: all from Music,
            //ACIVideo - list: all from Videos
            //ACIPictures - list: all from Pictures
            //ACIRadio - list: radio stations
            //ACITelevision - list: Streams, DVB

            //0
            Loader { id: homeViewLoader; anchors.fill: parent; },
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
                mainview.children[m_current].handleEnter();
            }            
        }
        Connections {
            target: settingsViewLoader.item;
            onGoUp: {
                console.log("go up");
                mainview.m_current = 0;
                mainview.children[m_current].handleEnter();
            }
        }
    }

    //    (m_current === 2)
    Steerings {
        id: viewSteerings
        objectName: "viewSteerings"
        width: parent.width;
        height: Math.floor(parent.height*0.15);
        anchors {
            bottom: statusBar.top;
        }

        onVolup: mainview.volup();
        onVoldown: mainview.voldown();
        onPrevMusic: mediaViewLoader.item.handlePrevious();
        onPlaypauseMusic: mediaViewLoader.item.handleRelease();
        onNextMusic: mediaViewLoader.item.handleNext();
        onBackToPrevious: { mainview.m_current = 2; }

    }

    //status bar
    //    (m_current === 3)
    StatusBar {
        id: statusBar;
        objectName: "statusBar"
        width: parent.width;
        height: Math.floor(parent.height*0.05);
        anchors {
            bottom: mainview.bottom;
        }
    }

}
