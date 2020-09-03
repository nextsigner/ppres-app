import QtQuick 2.7
import QtQuick.Controls 2.0
import Qt.labs.settings 1.1

ApplicationWindow {
    id: app
    visible: true
    visibility: Qt.platform.os!=='android'?"Windowed":"FullScreen"
    width: 700
    height: 300
    title: "PPres"
    property string moduleName: 'ppres'
    property int fs: width*0.035
    property color c1: 'white'
    property color c2: 'black'
    property color c3: '#ccc'
    property color c4: 'red'

    property bool cfgValida: false

    property string serverUrl: 'http://66.97.46.73'
    property int portRequest: 8080
    property int portFiles: 8081

    property string cTec: apps.cTec


    property int mod: 0
    property var cProds: []

    property int widthMarcador: 2

    property bool devSending: false

    onModChanged: {
        if(mod===0){
            xXMenu.cBtn=bot1
        }
        if(mod===1){
            xXMenu.cBtn=bot2
        }
        if(mod===2){
            xXMenu.cBtn=bot3
        }
        if(mod===3){
            xXMenu.cBtn=bot4
        }
        if(mod===4){
            xXMenu.cBtn=bot5
        }
        marcador.x=xXMenu.cBtn.x+xXMenu.cBtn.width/2-marcador.width/2
    }
    Settings{
        id: apps
        fileName: 'config-ppres'
        property string serverUrl: 'http://66.97.46.73'
        property int portRequest: 8080
        property int portFiles: 8081
        property string cTec: ''
        property string cTecTel: ''
        property string cTecEMail: ''
        property int vdev: 1
    }
    Item{
        id: xApp
        anchors.fill: parent
        Flickable{
            id: flick
            anchors.fill: parent
            contentWidth: parent.width
            contentHeight: col1.height//+app.fs*4
            Column{
                id: col1
                width: xApp.width
                anchors.horizontalCenter: parent.horizontalCenter
                //anchors.horizontalCenter: parent.horizontalCenter
                Item{
                    id: xXMenu
                    width: xMenu.width
                    height: xMenu.height
                    property var cBtn:bot1
                    anchors.horizontalCenter: parent.horizontalCenter
                    Rectangle{
                        id: marcador
                        width: app.widthMarcador
                        height: xApp.height
                        x:bot1.x+bot1.width/2-width/2
                        color: 'black'
                        Behavior on x{
                            NumberAnimation{duration: 500; easing.type: Easing.InOutQuad}
                        }
                    }
                    Row{
                        id: xMenu
                        spacing: app.fs*0.1
                        anchors.horizontalCenter: parent.horizontalCenter
                        Boton{
                            id: bot1;
                            text: 'Buscar'
                            fontSize: app.fs
                            horizontalMargin: app.fs*0.1
                            onClicked: app.mod=0
                            opacity: app.mod===0?1.0:0.65
                        }
                        Boton{
                            id: bot2;
                            text: 'Presupuesto'
                            fontSize: app.fs
                           horizontalMargin: app.fs*0.1
                            onClicked: app.mod=1
                            opacity: app.mod===1?1.0:0.65
                        }
                        Boton{
                            id: bot3;
                            text: 'Enviar'
                            fontSize: app.fs
                            horizontalMargin: app.fs*0.1
                            onClicked: app.mod=2
                            opacity: app.mod===2?1.0:0.65
                        }
                        Boton{
                            id: bot4;
                            text: 'Configurar'
                            fontSize: app.fs
                            horizontalMargin: app.fs*0.1
                            onClicked: app.mod=3
                            opacity: app.mod===3?1.0:0.65
                        }
                        Boton{
                            id: bot5;
                            text: 'Acerca de'
                            fontSize: app.fs
                            horizontalMargin: app.fs*0.1
                            onClicked: app.mod=4
                            opacity: app.mod===4?1.0:0.65
                        }
                    }
                }
                XSearchProd{id: xSearchProd;visible: app.mod===0}
                XGetPres{id: xGetPres;visible: app.mod===1}
                XCliente{id: xCliente;visible: app.mod===2}
                XConfig{id: xConfig;visible: app.mod===3}
                XAbout{id: xAbout;visible: app.mod===4}

            }
        }
    }
    Shortcut{
        sequence: 'Esc'
        onActivated: Qt.quit()
    }
    Shortcut{
        sequence: 'Ctrl+a'
        onActivated: xCliente.sendExample()
    }
    Timer{
        id: tCheckCfgValida
        running: true
        repeat: true
        interval: 250
        onTriggered: {
            if(apps.cTec===''||apps.cTecTel===''||apps.cTecEMail===''){
                app.mod=3
            }
            if(apps.cTec!==''&&apps.cTecTel!==''&&apps.cTecEMail!==''){
                stop()
            }
        }
    }
    Component.onCompleted: {
        if(Qt.platform.os!=='android'){
            app.y=30
            app.x=500//+300
            app.width=350
            app.height=650
        }
        //console.log('Qt.args: '+Qt.application.arguments.toString())
        if(Qt.application.arguments.indexOf('-dev')>=0){
            app.serverUrl='http://localhost'
            return
        }
        getServerUrl()
    }

    function getServerUrl(){
        let url='https://raw.githubusercontent.com/nextsigner/nextsigner.github.io/master/ppres_server'
        console.log('Get '+app.moduleName+' server from '+url)
        var req = new XMLHttpRequest();
        req.open('GET', url, true);
        req.onreadystatechange = function (aEvt) {
            if (req.readyState === 4) {
                if(req.status === 200){
                    let m0=req.responseText.split('|')
                    if(m0.length>2){
                        app.serverUrl=m0[0]
                        app.portRequest=m0[1]
                        app.portFiles=m0[2]
                        console.log('Ppres Server='+app.serverUrl+' '+app.portRequest+' '+app.portFiles)
                    }else{
                        console.log("Error el cargar el servidor de Ppres. Code 2\n");
                    }
                }else{
                    console.log("Error el cargar la url del servidor Ppres. Code 1\n");
                }
            }
        };
        req.send(null);
    }
}
