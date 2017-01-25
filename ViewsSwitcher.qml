import QtQuick 2.5

Item {
    id: viewsSwitcherContainer

    property alias pages: viewsSwitcherItem.children
    property Item currentPage

    function jumpTo(idx){
        console.log("jumpTo: "+idx);
        for(var i = 0; i < pages.length; i++)
        {
            pages[i].x = 1024;
            pages[i].visible = false;
//            console.log("jumpTo-move X to: "+pages[i].x);
        }
        pages[idx].x = 0;
        pages[idx].visible = true;
        currentPage = pages[idx];
        console.log("jumpTo:"+idx +", x: "+pages[idx].x +", visible:"+pages[idx].visible);
    }

    Item {
        id: viewsSwitcherItem
        anchors.fill: parent
    }
}
