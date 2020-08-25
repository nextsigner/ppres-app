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
    signal dataChanged()
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
        //Rows 'descripcion', 'codigo', 'precioinstalacion', 'precioabono', 'adicionalriesgo', 'observaciones'
        function addItem(id, des, cod, pinst, pabono, adicriesgo, obs, cantidad){
            return{
                numId: id,
                descripcion: des,
                codigo: cod,
                precioinstalacion: pinst,
                precioabono: pabono,
                adicionalriesgo: adicriesgo,
                observaciones: obs,
                seleccionado: false,
                cant:cantidad,
                totalItem: 0.00
            }
        }
    }
    Component{
        id: rowList
        Item{
            width: lv.width//-app.fs
            height: !seleccionado?xDes.height:xDes.height+app.fs*2
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
                height: xDes.height
                anchors.centerIn: parent
                color: seleccionado?'white':'#ccc'
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        if(cant===0&&!seleccionado){
                            cant=1
                            r.dataChanged()
                        }
                        seleccionado=!seleccionado
                        if(!r.inSearch){
                            xGetPres.setTotal()
                        }
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
                        id: xDes
                        width: lv.width*0.6
                        height: txtDes.contentHeight+app.fs*2
                        border.width: seleccionado?3:1
                        border.color: 'black'
                        color: 'transparent'
                        //Rows 'descripcion', 'codigo', 'precioinstalacion', 'precioabono', 'adicionalriesgo', 'observaciones'
                        Text {
                            id: txtDes
                            text: '<b>Descripción: </b> '+descripcion+'<br /><br /><b>Código: '+codigo+'</b><br /><br /><b>Precio de Instalación: </b>$'+precioinstalacion+'<br /><br /><b>Precio Abono: </b> $'+precioabono+'<br /><b>Adicional por Riesgo: </b> $'+adicionalriesgo+'<br /><b>Observaciones: </b> $'+observaciones
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
                                    text: '<b>Precio: </b>$'+precioinstalacion
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
                                        r.dataChanged()
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
                                        r.dataChanged()
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
                                    r.dataChanged()
                                }
                            }
                        }
                    }
                }
            }
            Rectangle{
                id: xProdAgregado
                anchors.fill: parent
                opacity: 0.5
                visible: false
                Text{
                    text: '<b>Agregado</b>'
                    color: 'black'
                    font.pixelSize: app.fs*3
                    anchors.centerIn: parent
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        app.mod=1
                    }
                }
            }
            Component.onCompleted: {
                setEstado()
            }
            function setEstado(){
                let t=parseFloat(parseInt(cant) * parseFloat(precioinstalacion))
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
                        let nti=parseFloat(ncant * precioinstalacion).toFixed(2)
                        totalItem=nti
                        txtCant.text+='<br /><b>P. total:</b> $'+nti
                        //console.log('... numId:['+lm.get(i2).numId+'] id:['+xListProdSearch.listModel.get(i2).numId+']')
                        //existe=true
                        break
                    }
                }
                if(r.inSearch){
                    for(var i=0;i<xGetPres.list.listModel.count;i++){
                        if(numId===xGetPres.list.listModel.get(i).numId){
                            xProdAgregado.visible=true
                            break
                        }
                    }
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
            r.dataChanged()
        }
    }
    function clear(){
        lm.clear()
    }
    function addProd(id, des, cod, pinst, pabono, adicriesgo, obs, cant){
        lm.append(lm.addItem(id, des, cod, pinst, pabono, adicriesgo, obs, cant))
        if(!r.inSearch){
            lv.currentIndex=lm.count-1
        }
        sendSignal.restart()
    }
    function getTotal(){
        r.total=0.00
        for(var i=0;i<lm.count;i++){
            let p=parseFloat(lm.get(i).precioinstalacion * lm.get(i).cant).toFixed(2)
            r.total=parseFloat(r.total) + parseFloat(p)
        }
        return r.total
    }
    function updateData(){
        for(var i=0;i<lv.children.length;i++){
            if(lv.children[i].c){
                lv.children[i].setEstado()
            }
        }
    }
}
