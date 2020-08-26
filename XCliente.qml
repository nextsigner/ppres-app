import QtQuick 2.0
import QtQuick.Controls 1.4
XArea {
    id: r
    width: xApp.width
    height: xApp.height
    property string uFormSended: ''
    property int vUFSended: 1
    property var uDateFI
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
                    maximumLength: 50
                    //validator: RegExpValidator{regExp: /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/}
                    //Keys.onReturnPressed: getSearch(tiSearch.text)
                    onTextChanged: {
                        labelStatus.text=''
                    }
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
                    maximumLength: 20
                    //validator: RegExpValidator{regExp: /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/}
                    //Keys.onReturnPressed: getSearch(tiSearch.text)
                    onTextChanged: {
                        labelStatus.text=''
                    }
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
                    //validator: RegExpValidator{regExp: /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/}
                    //Keys.onReturnPressed: getSearch(tiSearch.text)
                    onTextChanged: {
                        labelStatus.text=''
                    }
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
                    validator: RegExpValidator{regExp: /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/}
                    //Keys.onReturnPressed: getSearch(tiSearch.text)
                    onTextChanged: {
                        labelStatus.text=''
                    }
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
        Item{
            width: 2
            height: app.fs
        }
        Text {
            id: labelFechaInstalacion
            text: 'Fecha de Instalación:'
        }
        Row{
            id: rowFechaInstalacion
            spacing: app.fs
            Rectangle{
                id: xTiFechaInstalacion
                width: r.width-btnSetFInst.width-app.fs*2
                height: app.fs*2
                border.width: 2
                clip: true
                enabled: false
                anchors.verticalCenter: parent.verticalCenter
                TextInput{
                    id: tiFechaInstalacion
                    width: parent.width-app.fs*0.5
                    height: parent.height-app.fs
                    font.pixelSize: app.fs
                    anchors.centerIn: parent
                    //Keys.onReturnPressed: getSearch(tiSearch.text)
                    //onTextChanged: xListProdSearch.clear()
                }
            }
            Boton{
                id:btnSetFInst
                text: 'Cambiar Fecha'
                fontSize: app.fs
                anchors.verticalCenter: parent.verticalCenter
                onClicked: {
                    xCalFI.visible=true
                }
            }
        }
        Boton{
            id:btnEnviarPres
            text: 'Enviar Presupuesto'
            fontSize: app.fs
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                enabled: false
                apps.vdev++
                if(tiNombre.text!==''&&tiCorreo.text!==''&&tiContrato.text!==''&&tiDom.text!==''&&tiTel.text!==''){
                    if(uFormSended===getStringUF()){
                        vUFSended++
                        labelStatus.text='Enviando presupuesto por °'+r.vUFSended+' vez...'
                    }else{
                        vUFSended=1
                        labelStatus.text='Enviando presupuesto...'
                    }
                    r.uFormSended=getStringUF()
                    sendPres()
                }else{
                    labelStatus.text='Error. Faltan datos en el formulario.'
                }
            }
        }
        Text {
            id: labelStatus
            width: r.width-app.fs*2
            wrapMode: Text.WordWrap
        }
    }

    Rectangle{
        id: xCalFI
        width: r.width
        height: r.height
        visible: false
        onVisibleChanged: {
            if(!visible){
                xApp.focus=true
            }
        }
        Column{
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: app.fs
            width: parent.width-app.fs
            spacing: app.fs
            Text {
                id: labelCalFI
                text: 'Fecha de Instalación'
                width: parent.width
                wrapMode: Text.WordWrap
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Calendar{
                id: calFI
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Row{
                spacing: app.fs
                Text {
                    text: 'Hora:'
                    font.pixelSize: app.fs
                    anchors.verticalCenter: parent.verticalCenter
                }
                SpinBox{
                    id:spHora
                    minimumValue: 0
                    maximumValue: 23
                    stepSize: 1
                    value: 0
                    anchors.verticalCenter: parent.verticalCenter
                }
                Text {
                    text: 'Minutos:'
                    font.pixelSize: app.fs
                    anchors.verticalCenter: parent.verticalCenter
                }
                SpinBox{
                    id:spMinutos
                    minimumValue: 0
                    maximumValue: 59
                    stepSize: 5
                    value: 0
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
            Boton{
                id:btnSetCalFI
                text: 'Listo'
                fontSize: app.fs
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    xCalFI.visible=false
                    let d = calFI.selectedDate
                    let dia=d.getDate()
                    let mes=d.getMonth()
                    let anio=d.getFullYear()
                    let nd= new Date(anio, mes, dia, spHora.value, spMinutos.value)
                    r.uDateFI=nd
                    tiFechaInstalacion.text=nd.toString()
                }
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
    Component.onCompleted: {
        let d=new Date(Date.now())
        spHora.value=d.getHours()
        spMinutos.value=d.getMinutes()
        calFI.minimumDate=new Date(Date.now())
        tiFechaInstalacion.text=new Date(Date.now()).toString()
    }
    function sendExample(){
        app.devSending=true
        tiNombre.text='Clientino Pruebeira'
        tiDom.text='República La Pruebata 315 Villa La Falla Fatal'
        tiCorreo.text='qtpizarro@gmail.com'
        tiTel.text='315315315'
        tiContrato.text='00001'
        uDateFI=new Date(Date.now())
        uDateFI.setMonth(uDateFI.getMonth()+1)
        let d = uDateFI
        let dia=d.getDate()
        let mes=d.getMonth()
        let anio=d.getFullYear()
        let nd= new Date(anio, mes, dia, 15, 30)
        tiFechaInstalacion.text=nd.toString()
        btnEnviarPres.clicked()
    }
    function getStringUF(){
        return tiNombre.text+tiCorreo.text+tiContrato.text+tiDom.text+tiTel.text
    }
    function sendPres(){
        let d = new Date(Date.now())
        let url=app.serverUrl+':'+app.portRequest+'/ppres/nuevopresupuesto?r='+d.getTime()//+consulta
        console.log('Post '+app.moduleName+' server from '+url)
        var jsonTec='{"tecnico":{"nombre":"'+apps.cTec+'", "telefono":"'+apps.cTecTel+'", "email":"'+apps.cTecEMail+'"}}'
        var jsonCli='{"cliente":{"nombre":"'+tiNombre.text+'", "direccion":"'+tiDom.text+'", "telefono":"'+tiTel.text+'", "email":"'+tiCorreo.text+'", "contrato":"'+tiContrato.text+'"}}'
        var params = 'devSending='+app.devSending+'&vdev='+apps.vdev+'&tecnico='+jsonTec+'&cliente='+jsonCli+'&productos='+xGetPres.getJsonProds()+'&fechaInstalacion='+r.uDateFI.getTime();
        var req = new XMLHttpRequest();
        req.open('POST', url, true);
        req.setRequestHeader('Content-type', 'application/x-www-form-urlencoded')//.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
        req.onreadystatechange = function (aEvt) {
            if (req.readyState === 4) {
                if(req.status === 200){
                    //console.log('Response Pres: '+req.responseText)
                    let json
                    try {
                        json=JSON.parse(req.responseText)
                        labelStatus.text='El presupuesto se ha enviado corractatemte.'
                    } catch(e) {
                        labelStatus.text='Error al enviar el presupuesto. '+e
                    }
                    btnEnviarPres.enabled=true
                }else{
                    console.log("Error el cargar el servidor de Ppres. Code 1\n");
                    btnEnviarPres.enabled=true
                    labelStatus.text='Error al enviar el presupuesto. El servidor no está respondiendo correctamente a este requerimiento.'
                }
            }
        };
        req.send(params);
    }
}
