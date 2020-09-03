import QtQuick 2.0

XArea {
    id: r
    width: xApp.width
    height: xApp.height
    onVisibleChanged: {
        if(visible){
            tiTec.text=apps.cTec
            tiTecTel.text=apps.cTecTel
            tiTecEMail.text=apps.cTecEMail
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
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: app.fs
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
                    KeyNavigation.tab: tiTec
                    Keys.onReturnPressed: tiTec.focus=true
                    //onTextChanged: xListProdSearch.clear()
                }
            }
        }
        Item{
            width: 2
            height: app.fs
        }
        Text {
            text: '<b>Técnico</b>'
            font.pixelSize: app.fs*2
        }
        Row{
            id: rowTec
            spacing: app.fs
            Text {
                id: labelTec
                text: 'Nombre: *'
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
                    KeyNavigation.tab: tiTecTel
                    Keys.onReturnPressed: tiTecTel.focus=true
                    //onTextChanged: xListProdSearch.clear()
                }
            }
        }
        Row{
            id: rowTecTel
            spacing: app.fs
            Text {
                id: labelTecTel
                text: 'Teléfono: *'
                anchors.verticalCenter: parent.verticalCenter
            }
            Rectangle{
                id: xTiTecTel
                width: r.width-labelTec.contentWidth-app.fs*2
                height: app.fs*2
                border.width: 2
                clip: true
                anchors.verticalCenter: parent.verticalCenter
                TextInput{
                    id: tiTecTel
                    width: parent.width-app.fs*0.5
                    height: parent.height-app.fs
                    font.pixelSize: app.fs
                    anchors.centerIn: parent
                    KeyNavigation.tab: tiTecEMail
                    Keys.onReturnPressed: tiTecEMail.focus=true
                    //onTextChanged: xListProdSearch.clear()
                }
            }
        }
        Row{
            id: rowTecEMail
            spacing: app.fs
            Text {
                id: labelTecEMail
                text: 'E-Mail: *'
                anchors.verticalCenter: parent.verticalCenter
            }
            Rectangle{
                id: xTiTecEMail
                width: r.width-labelTec.contentWidth-app.fs*2
                height: app.fs*2
                border.width: 2
                clip: true
                anchors.verticalCenter: parent.verticalCenter
                TextInput{
                    id: tiTecEMail
                    width: parent.width-app.fs*0.5
                    height: parent.height-app.fs
                    font.pixelSize: app.fs
                    anchors.centerIn: parent
                    validator: RegExpValidator{regExp: /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/}
                    KeyNavigation.tab: btnSetConfigData
                    Keys.onReturnPressed: btnSetConfigData.focus=true
                    //onTextChanged: xListProdSearch.clear()
                }
            }
        }
        Text {
            id: labelStatusTecConfig
            width: r.width-app.fs*2
            wrapMode: Text.WordWrap
            //anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: app.fs
        }
        Boton{
            id: btnSetConfigData
            text: focus?'<b>Listo</b>':'Listo'
            fontSize: app.fs
            anchors.horizontalCenter: parent.horizontalCenter
            KeyNavigation.tab: tiTec
            onClicked: {
                tiHost.focus=false
                tiTec.focus=false
                tiTecTel.focus=false
                tiTecEMail.focus=false
                if(tiTec.text!==''&&tiTecTel.text!==''&&tiTecEMail.text!==''){
                    apps.cTec=tiTec.text
                    apps.cTecTel=tiTecTel.text
                    apps.cTecEMail=tiTecEMail.text
                    apps.serverUrl=tiHost.text
                    app.serverUrl=tiHost.text
                    xAcceso.visible=true
                    app.mod=0
                }else{
                    labelStatusTecConfig.text='Para utilizar esta aplicación hay que llenar todos los campos de este formulario.'
                }
            }
        }
    }

    Rectangle{
        id: xAcceso
        anchors.fill: r
        property string uClaveAcc: ''
        onVisibleChanged: {
            if(!visible){
                tiClaveAcc.focus=false
            }
        }
        MouseArea{
            anchors.fill: parent
        }
        Column{
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: app.fs
            spacing: app.fs
            Text {
                text: '<b>Ingresar Clave</b>'
                font.pixelSize: app.fs*2
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Text {
                text:  'Solicitar clave de acceso a pizarromario@gmail.com'
                font.pixelSize: app.fs
                width: r.width-app.fs*2
                wrapMode: Text.WordWrap
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Row{
                id: rowAcc
                spacing: app.fs
                Text {
                    id: labelClaveAcc
                    text: 'Clave:'
                    anchors.verticalCenter: parent.verticalCenter
                }
                Rectangle{
                    id: xTiClaveAcc
                    width: r.width-labelHost.contentWidth-app.fs*2
                    height: app.fs*2
                    border.width: 2
                    clip: true
                    anchors.verticalCenter: parent.verticalCenter
                    TextInput{
                        id: tiClaveAcc
                        width: parent.width-app.fs*0.5
                        height: parent.height-app.fs
                        font.pixelSize: app.fs
                        anchors.centerIn: parent
                        echoMode: TextInput.Password
                        Keys.onReturnPressed: xAcceso.acceder()
                        onTextChanged: labelStatusAcc.text=''
                    }
                }
            }
            Text {
                id: labelStatusAcc
                width: r.width-app.fs*2
                wrapMode: Text.WordWrap
                font.pixelSize: app.fs
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Boton{
                text: 'Acceder'
                fontSize: app.fs
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    xAcceso.acceder()
                }
            }
        }
        function acceder(){
            let d=new Date(Date.now())
            let v1=d.getDate()*2
            let v2=(d.getMonth()+1)*2
            let c=''+v1+v2
            if(tiClaveAcc.text.indexOf(c)>=0&&xAcceso.uClaveAcc!==tiClaveAcc.text){
                xAcceso.visible=false
                xAcceso.uClaveAcc=tiClaveAcc.text
                tiClaveAcc.text=''
            }else{
                labelStatusAcc.text='Clave de acceso incorrecta.'
            }
        }
    }
}


