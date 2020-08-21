import QtQuick 2.0

XArea {
    id: r
    width: xApp.width
    height: xApp.height
    onVisibleChanged: {
        if(visible){
            tiTec.text=apps.cTec
            tiHost.text=apps.serverUrl
            tiHost.focus=true
        }
    }
    Rectangle{
        anchors.fill: r
        color: 'red'
        border.color: 'blue'
        border.width: 4
        visible: false
    }
    Column{
        id: col
        anchors.centerIn: r
        spacing: app.fs
        Text {
            text: '<b>Configurar</b>'
            font.pixelSize: app.fs*2
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Row{
            id: rowIp
            spacing: app.fs
            Text {
                id: labelHost
                text: 'Host:'
                anchors.verticalCenter: parent.verticalCenter
            }
            Rectangle{
                id: xTiHost
                width: r.width-labelHost.contentWidth-app.fs*2
                height: app.fs*2
                border.width: 2
                clip: true
                anchors.verticalCenter: parent.verticalCenter
                TextInput{
                    id: tiHost
                    width: parent.width-app.fs*0.5
                    height: parent.height-app.fs
                    font.pixelSize: app.fs
                    anchors.centerIn: parent
                    //Keys.onReturnPressed: apps.serverUrl=text
                    //onTextChanged: xListProdSearch.clear()
                }
            }
        }
        Row{
            id: rowTec
            spacing: app.fs
            Text {
                id: labelTec
                text: 'Técnico:'
                anchors.verticalCenter: parent.verticalCenter
            }
            Rectangle{
                id: xTiTec
                width: r.width-labelTec.contentWidth-app.fs*2
                height: app.fs*2
                border.width: 2
                clip: true
                anchors.verticalCenter: parent.verticalCenter
                TextInput{
                    id: tiTec
                    width: parent.width-app.fs*0.5
                    height: parent.height-app.fs
                    font.pixelSize: app.fs
                    anchors.centerIn: parent
                    //Keys.onReturnPressed: apps.serverUrl=text
                    //onTextChanged: xListProdSearch.clear()
                }
            }
        }
        Boton{
            text: 'Listo'
            fontSize: app.fs
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                apps.cTec=tiTec.text
                apps.serverUrl=tiHost.text
                app.serverUrl=tiHost.text
                app.mod=0
            }
        }
    }
}
