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
        function addItem(id, cat, nom, tipoviv, adixelem, prec, cantidad){
            return{
                numId: id,
                categoria: cat,
                nombre: nom,
                tipovivienda: tipoviv,
                adicionalporelemento: adixelem,
                precio: prec,
                seleccionado: false,
                cant:cantidad
            }
        }
    }
    Component{
        id: rowList
        Item{
            width: lv.width//-app.fs
            height: !seleccionado?xNom.height:xNom.height+app.fs*2
            anchors.horizontalCenter: parent.horizontalCenter
            property int c: cant
            onCChanged:{
                setEstado()
            }
            Behavior on height{
                NumberAnimation{duration: 500; easing.type: Easing.InOutQuad}
            }
            Rectangle{
                width: lv.width//-app.fs
                height: xNom.height
                anchors.centerIn: parent
                color: seleccionado?'white':'#ccc'
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        if(cant===0&&!seleccionado){
                            cant=1
                        }
                        seleccionado=!seleccionado
                        if(!r.inSearch){
                            xGetPres.setTotal()
                        }
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
                            text: '<b>Categoria: </b> '+categoria+'<br /><br /><b>'+nombre+'</b><br /><br /><b>Tipo de Vivienda: </b>'+tipovivienda+'<br /><br /><b>Adicional p/elemento: </b> $'+adicionalporelemento
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
                        color: 'transparent'
                        Column{
                            anchors.centerIn: parent
                            spacing: app.fs
                            Column{
                                spacing: app.fs
                                anchors.horizontalCenter: parent.horizontalCenter
                                Text {
                                    id: txtPres
                                    text: '<b>Precio: </b>$'+precio
                                    font.pixelSize: app.fs
                                    width: xPrec.width-app.fs
                                    wrapMode: Text.WordWrap
                                }
                                Text {
                                    id: txtCant
                                    text: '<b>Cantidad:</b> '+cant
                                    font.pixelSize: app.fs
                                    width: xPrec.width-app.fs
                                    wrapMode: Text.WordWrap
                                    //visible: cant>=1
                                }
                            }
                            Row{
                                anchors.horizontalCenter: parent.horizontalCenter
                                visible: seleccionado
                                Boton{
                                    id: btnRemoveCant
                                    text: '<b>-</b> Cant.'
                                    fontSize: app.fs
                                    horizontalMargin: 2
                                    onClicked: {
                                        if(cant>=1){
                                            cant--
                                        }
                                        if(cant>=1){
                                            seleccionado=true
                                        }else{
                                            seleccionado=false
                                        }
                                        setEstado()
                                        if(!r.inSearch){
                                            xGetPres.setTotal()
                                        }
                                    }
                                }
                                Boton{
                                    id: btnAddCant
                                    text: '<b>+</b> Cant.'
                                    fontSize: app.fs
                                    horizontalMargin: 2
                                    onClicked: {
                                        seleccionado=true
                                        cant++
                                        setEstado()
                                        if(!r.inSearch){
                                            xGetPres.setTotal()
                                        }
                                    }
                                }
                            }
                            Boton{
                                id: btnRemoveProd
                                text: 'Eliminar'
                                fontSize: app.fs
                                horizontalMargin: 2
                                visible: !r.inSearch&&seleccionado
                                onClicked: {
                                    lm.remove(index)
                                    if(r.inSearch){
                                        xGetPres.setTotal()
                                    }
                                }
                            }
                        }
                    }
                }
            }
            function setEstado(){
                let t=parseFloat(parseInt(cant) * parseFloat(precio))
                txtCant.text='<b>Cant.:</b> '+cant+' $'+t
                if(!inSearch){
                    return
                }
                for(var i2=0;i2<xGetPres.list.listModel.count;i2++){
                   //console.log('numId:['+lm.get(i2).numId+'] id:['+xListProdSearch.listModel.get(i2).numId+']')
//                    var existe=false
                    if(numId===xGetPres.list.listModel.get(i2).numId){
                        let ncant=parseInt(xGetPres.list.listModel.get(i2).cant + cant)
                        txtCant.text+='<br /><b>Cant. pres.:</b> '+xGetPres.list.listModel.get(i2).cant
                        txtCant.text+='<br /><b>Cant. total:</b> '+ncant
                        txtCant.text+='<br /><b>P. total:</b> $'+parseFloat(ncant * precio).toFixed(2)
                        //console.log('... numId:['+lm.get(i2).numId+'] id:['+xListProdSearch.listModel.get(i2).numId+']')
                        //existe=true
                        break
                    }
                }
        }
        Component.onCompleted: {
            setEstado()
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
function addProd(id, categoria, nom, tipoviv, adixelem, prec, cant){
    lm.append(lm.addItem(id, categoria, nom, tipoviv, adixelem, prec, cant))
    if(!r.inSearch){
        lv.currentIndex=lm.count-1
    }
    sendSignal.restart()
}
function getTotal(){
    r.total=0.00
    for(var i=0;i<lm.count;i++){
        let p=parseFloat(lm.get(i).precio * lm.get(i).cant).toFixed(2)
        r.total=parseFloat(r.total) + parseFloat(p)
    }
    return r.total
}
}
