import QtQuick 2.0

Item {
    id: r
    width: xApp.width
    height: xApp.height*0.75
    anchors.horizontalCenter: parent.horizontalCenter
    property alias listModel: lm
    property real total: 0
    property bool inSearch: false
    property var idsSelected: []
    signal productoAgregado()
    ListView{
        id: lv
        width: r.width
        height: r.height
        model: lm
        delegate: rowList
        clip: true
        anchors.horizontalCenter: parent.horizontalCenter
    }
    ListModel{
        id: lm
        function addItem(id, cat, nom, tipoviv, adixelem, prec){
            return{
                numId: id,
                categoria: cat,
                nombre: nom,
                tipovivienda: tipoviv,
                adicionalporelemento: adixelem,
                precio: prec,
                seleccionado: false,
                cant:1
            }
        }
    }
    Component{
        id: rowList
        Rectangle{
            width: lv.width//-app.fs
            height: xNom.height
            anchors.horizontalCenter: parent.horizontalCenter
            property string mongoId: numId
            Rectangle{
                anchors.fill: parent
                color: seleccionado?'white':'#ccc'
                //opacity: seleccionado?1.0:0.5
                visible: r.inSearch
            }
            Row{
                Rectangle{
                    id: xNom
                    width: lv.width*0.6
                    height: txtDes.contentHeight+app.fs*2
                    border.width: seleccionado?3:1
                    border.color: 'black'
                    color: 'transparent'
                    Text {
                        id: txtDes
                        text: '<b>Categoria: </b> '+categoria+'<br /><br /><b>'+nombre+'</b><br /><br /><b>Tipo de Vivienda: </b>'+tipovivienda+'<br /><br /><b>Adicional p/elemento: </b> $'+adicionalporelemento+'<br /><b>Cantidad: </b>'+cant
                        width: parent.width-app.fs*2
                        height: contentHeight+app.fs
                        font.pixelSize: app.fs
                        anchors.centerIn: parent
                        wrapMode: Text.WordWrap
                        textFormat: Text.RichText
                    }
                }
                Rectangle{
                    id: xPrec
                    width: lv.width*0.4
                    height: txtDes.contentHeight+app.fs*2
                    border.width: seleccionado?3:1
                    border.color: 'black'
                    color: 'gray'
                    Column{
                        anchors.centerIn: parent
                        spacing: app.fs
                        Text {
                            id: txtPres
                            text: cant===1?'$'+precio:'Por unidad $'+precio+' <br />'
                            font.pixelSize: app.fs
                            wrapMode: Text.WordWrap
                        }
                        Column{
                            anchors.horizontalCenter: parent.horizontalCenter
                            Boton{
                                id: btnRemoveCant
                                text: 'Quitar Cantidad'
                                fontSize: app.fs
                                onClicked: {
                                    if(cant>=2){
                                        cant--
                                    }
                                }
                            }
                            Boton{
                                id: btnAddCant
                                text: 'Agregar Cantidad'
                                fontSize: app.fs
                                onClicked: {
                                    cant++
                                }
                            }
                        }
                    }
                }
            }

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    seleccionado=!seleccionado
                    /*var nIdsSelected=[]
                    if(r.idsSelected.indexOf(numId)<0){
                        for(var i=0;i<r.idsSelected.length;i++){

                            nIdsSelected[i]=r.idsSelected[i]

                        }
                        nIdsSelected.push(numId)
                        r.idsSelected=nIdsSelected
                        //r.idsSelected.push(numId)
                    }else{
                        for(var i=0;i<lm.count;i++){
                            if(r.idsSelected[i]!==''+numId&&r.idsSelected[i]!==''){
                                nIdsSelected[i]=r.idsSelected[i]
                            }
                        }
                        r.idsSelected=nIdsSelected
                    }
                    for(i=0;i<lm.count;i++){
                        lm.get(i).seleccionado=r.idsSelected.indexOf(lm.get(i).numId)>=0
                    }
                    console.log('ids:::'+r.idsSelected)*/
                }
            }
        }
    }
    Timer{
        id: sendSignal
        running: false
        repeat: false
        interval: 1000
        onTriggered: {
            r.productoAgregado()
        }
    }
    function clear(){
        lm.clear()
    }
    function addProd(id, categoria, nom, tipoviv, adixelem, prec){
        lm.append(lm.addItem(id, categoria, nom, tipoviv, adixelem, prec))
        if(!r.inSearch){
            lv.currentIndex=lm.count-1
        }
        sendSignal.restart()
    }
    function getTotal(){
        r.total=0.00
        for(var i=0;i<lm.count;i++){
            let p=parseFloat(lm.get(i).precio).toFixed(2)
            r.total=parseFloat(r.total) + parseFloat(p)
        }
        return r.total
    }
}
