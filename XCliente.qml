import QtQuick 2.0

XArea {
    id: r
    width: xApp.width
    height: xApp.height
    Rectangle{
        anchors.fill: r
        color: 'red'
        border.color: 'blue'
        border.width: 4
        visible: false
    }
    Column{
        id: col
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: app.fs
        spacing: app.fs
        Text {
            text: '<b>Datos del Cliente</b>'
            font.pixelSize: app.fs*2
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Row{
            id: rowNombre
            spacing: app.fs
            Text {
                id: labelNombre
                text: 'Nombre:'
                anchors.verticalCenter: parent.verticalCenter
            }
            Rectangle{
                id: xTiNombre
                width: r.width-labelNombre.contentWidth-app.fs*2
                height: app.fs*2
                border.width: 2
                clip: true
                anchors.verticalCenter: parent.verticalCenter
                TextInput{
                    id: tiNombre
                    width: parent.width-app.fs*0.5
                    height: parent.height-app.fs
                    font.pixelSize: app.fs
                    anchors.centerIn: parent
                    //Keys.onReturnPressed: getSearch(tiSearch.text)
                    //onTextChanged: xListProdSearch.clear()
                }
            }
        }
        Row{
            id: rowTel
            spacing: app.fs
            Text {
                id: labelTel
                text: 'Teléfono:'
                anchors.verticalCenter: parent.verticalCenter
            }
            Rectangle{
                id: xTiTel
                width: r.width-labelTel.contentWidth-app.fs*2
                height: app.fs*2
                border.width: 2
                clip: true
                anchors.verticalCenter: parent.verticalCenter
                TextInput{
                    id: tiTel
                    width: parent.width-app.fs*0.5
                    height: parent.height-app.fs
                    font.pixelSize: app.fs
                    anchors.centerIn: parent
                    //Keys.onReturnPressed: getSearch(tiSearch.text)
                    //onTextChanged: xListProdSearch.clear()
                }
            }
        }
        Row{
            id: rowDom
            spacing: app.fs
            Text {
                id: labelDom
                text: 'Domicilio:'
                anchors.verticalCenter: parent.verticalCenter
            }
            Rectangle{
                id: xTiDom
                width: r.width-labelDom.contentWidth-app.fs*2
                height: app.fs*2
                border.width: 2
                clip: true
                anchors.verticalCenter: parent.verticalCenter
                TextInput{
                    id: tiDom
                    width: parent.width-app.fs*0.5
                    height: parent.height-app.fs
                    font.pixelSize: app.fs
                    anchors.centerIn: parent
                    //Keys.onReturnPressed: getSearch(tiSearch.text)
                    //onTextChanged: xListProdSearch.clear()
                }
            }
        }
        Row{
            id: rowCorreo
            spacing: app.fs
            Text {
                id: labelCorreo
                text: 'E-Mail:'
                anchors.verticalCenter: parent.verticalCenter
            }
            Rectangle{
                id: xTiCorreo
                width: r.width-labelCorreo.contentWidth-app.fs*2
                height: app.fs*2
                border.width: 2
                clip: true
                anchors.verticalCenter: parent.verticalCenter
                TextInput{
                    id: tiCorreo
                    width: parent.width-app.fs*0.5
                    height: parent.height-app.fs
                    font.pixelSize: app.fs
                    anchors.centerIn: parent
                    //Keys.onReturnPressed: getSearch(tiSearch.text)
                    //onTextChanged: xListProdSearch.clear()
                }
            }
        }
        Row{
            id: rowContrato
            spacing: app.fs
            Text {
                id: labelContrato
                text: 'Contrato:'
                anchors.verticalCenter: parent.verticalCenter
            }
            Rectangle{
                id: xTiContrato
                width: r.width-labelContrato.contentWidth-app.fs*2
                height: app.fs*2
                border.width: 2
                clip: true
                anchors.verticalCenter: parent.verticalCenter
                TextInput{
                    id: tiContrato
                    width: parent.width-app.fs*0.5
                    height: parent.height-app.fs
                    font.pixelSize: app.fs
                    anchors.centerIn: parent
                    //Keys.onReturnPressed: getSearch(tiSearch.text)
                    //onTextChanged: xListProdSearch.clear()
                }
            }
        }
        Boton{
            text: 'Enviar Presupuesto'
            fontSize: app.fs
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                sendPres()
            }
        }
    }
//    Text {
//        text: '<b>Módulo en Construcción</b>'
//        width: r.width*0.8
//        wrapMode: Text.WordWrap
//        font.pixelSize: app.fs*3
//        color: 'red'
//        opacity: 0.5
//        anchors.centerIn: r
//    }
    function sendPres(){
        let url=app.serverUrl+':'+app.portRequest+'/ppres/nuevopresupuesto'//+consulta
        console.log('Post '+app.moduleName+' server from '+url)
        let d = new Date(Date.now())
        var params = 'tecnico='+apps.cTec+'&cliente='+tiNombre.text+'&contrato='+tiContrato.text+'&productos={"productos":{"p1":"dato1"}}&fechaInstalacion='+d.getTime();
        var req = new XMLHttpRequest();
        req.open('POST', url, true);
        req.setRequestHeader('Content-type', 'application/x-www-form-urlencoded')//.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
        req.onreadystatechange = function (aEvt) {
            if (req.readyState === 4) {
                if(req.status === 200){
                    let json=JSON.parse(req.responseText)
                    console.log('Response Pres: '+req.responseText)
                    //setSearchResult(json)
                }else{
                    console.log("Error el cargar el servidor de Ppres. Code 1\n");
                }
            }
        };
        req.send(params);
    }
}
