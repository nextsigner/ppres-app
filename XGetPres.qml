import QtQuick 2.0
import QtQuick.Controls 2.12

XArea {
    id: r
    width: xApp.width
    height: col.height
    anchors.horizontalCenter: parent.horizontalCenter
    property alias list: xListProd
    onVisibleChanged: {
        if(visible){
            xListProd.updateData()
            setTotal()
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
            height: xApp.height-xMenu.height-cabLV.height-xTotalSinIVA.height-rowTotalConDescuento.height-rowDescuento.height-app.fs*2
            onDataChanged: {
                console.log('GP Data changed!')
                xTotalSinIVA.total=parseFloat(getTotal()).toFixed(2)
            }
        }
        Item{
            width: 2
            height: app.fs
        }
        Row{
            id: rowDescuento
            spacing: app.fs
            Text {
                id: labelDescuento
                text: '<b>Descuento: %</b>'
                font.pixelSize: app.fs
                anchors.verticalCenter: parent.verticalCenter
            }
            ComboBox{
                id: cbDescuento
                model: [0,10,20,30]
                font.pixelSize: app.fs
                width: app.fs*8
                height: app.fs*2
                anchors.verticalCenter: parent.verticalCenter
                onCurrentTextChanged: calcTotal()
            }
        }
        Item{
            width: 2
            height: app.fs
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
                    calcTotal()
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
                    text: '<b>Total c/IVA: $</b> '+xTotalConIVA.total
                    font.pixelSize: app.fs
                    anchors.centerIn: parent
                    wrapMode: Text.WordWrap
                }
            }
        }
        Row{
            id: rowTotalConDescuento
            anchors.right: parent.right
            Rectangle{
                id: xTotalConDescuento
                width: r.width*0.4
                height: app.fs*2
                border.width: 1
                border.color: 'black'
                property real total: 0
                Text {
                    text: '<b>Total: $</b> '+xTotalConDescuento.total
                    font.pixelSize: app.fs
                    anchors.centerIn: parent
                    wrapMode: Text.WordWrap
                }
            }
        }
    }
    function calcTotal(){
        xTotalConIVA.total=xTotalSinIVA.total+(xTotalSinIVA.total/100*21)
        xTotalConDescuento.total=xTotalConIVA.total-(xTotalConIVA.total/100*parseInt(cbDescuento.currentText))
    }
    function setTotal(){
        xTotalSinIVA.total=parseFloat(xListProd.getTotal()).toFixed(2)
    }
    function getJsonProds(){
        let json='{'
        for(var i=0;i<xListProd.listModel.count;i++){
            if(i!==0){
                json+=','
            }
            json+='"item'+i+'":{"cant":'+xListProd.listModel.get(i).cant+','
            json+='"descripcion":"'+xListProd.listModel.get(i).descripcion+'",'
            json+='"codigo":"'+xListProd.listModel.get(i).codigo+'",'
            json+='"precioinstalacion":"'+xListProd.listModel.get(i).precioinstalacion+'",'
            json+='"precioabono":"'+xListProd.listModel.get(i).precioabono+'",'
            json+='"adicionalriesgo":"'+xListProd.listModel.get(i).adicionalriesgo+'",'
            json+='"observaciones":"'+xListProd.listModel.get(i).observaciones+'",'
            json+='"totalItem":"'+xListProd.listModel.get(i).totalItem+'"'
            json+='}'
        }
        json+='}'
        return json
    }
}
