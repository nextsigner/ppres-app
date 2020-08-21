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
        Boton{
            text: 'Enviar Presupuesto'
            fontSize: app.fs
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {

            }
        }
    }
    Text {
        text: '<b>Módulo en Construcción</b>'
        width: r.width*0.8
        wrapMode: Text.WordWrap
        font.pixelSize: app.fs*3
        color: 'red'
        opacity: 0.5
        anchors.centerIn: r
    }
}
