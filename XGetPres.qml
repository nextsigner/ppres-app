import QtQuick 2.0

Item {
    id: r
    width: xApp.width
    height: col.height
    anchors.horizontalCenter: parent.horizontalCenter
    property alias list: xListProd
    onVisibleChanged: {
        if(visible){
            xTotalSinIVA.total=parseFloat(xListProd.getTotal()).toFixed(2)
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
        width: r.width
        Row{
            id: cabLV
            anchors.horizontalCenter: parent.horizontalCenter
            Rectangle{
                width: r.width*0.6
                height: app.fs*2
                border.width: 1
                border.color: 'black'
                Text {
                    text: 'Nombre del Producto'
                    width: parent.width-app.fs*2
                    font.pixelSize: app.fs
                    anchors.centerIn: parent
                    wrapMode: Text.WordWrap
                }
            }
            Rectangle{
                width: r.width*0.4
                height: app.fs*2
                border.width: 1
                border.color: 'black'
                Text {
                    text: '<b>Precio</b>'
                    font.pixelSize: app.fs
                    anchors.centerIn: parent
                    wrapMode: Text.WordWrap
                }
            }
        }
        XListProd{
            id: xListProd
            height: xApp.height-xMenu.height-cabLV.height-xTotalSinIVA.height
            onProductoAgregado: {
                console.log('Producto agregado!')
                xTotalSinIVA.total=parseFloat(getTotal()).toFixed(2)
            }
        }
        Row{
            id: row
            anchors.right: parent.right
            Rectangle{
                id: xTotalSinIVA
                width: r.width*0.4
                height: app.fs*2
                border.width: 1
                border.color: 'black'
                property real total: 0
                onTotalChanged: {
                    xTotalConIVA.total=total+(total/100*21)
                }
                Text {
                    text: '<b>Total sin IVA: $</b> '+xTotalSinIVA.total
                    font.pixelSize: app.fs
                    anchors.centerIn: parent
                    wrapMode: Text.WordWrap
                }
            }
            Rectangle{
                id: xTotalConIVA
                width: r.width*0.4
                height: app.fs*2
                border.width: 1
                border.color: 'black'
                property real total: 0
                Text {
                    text: '<b>Total: $</b> '+xTotalConIVA.total
                    font.pixelSize: app.fs
                    anchors.centerIn: parent
                    wrapMode: Text.WordWrap
                }
            }
        }
    }
}
