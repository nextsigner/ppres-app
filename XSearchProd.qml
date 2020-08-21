import QtQuick 2.0

XArea {
    id: r
    width: xApp.width
    height: col.height
    anchors.horizontalCenter: parent.horizontalCenter
    property alias list: xListProdSearch
    onVisibleChanged: {
        if(visible){
            xListProdSearch.updateData()
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
        Item {
            width: 10
            height: app.fs
        }
        Row{
            id: rowSearch
            spacing: app.fs
            Text {
                id: labelSearch
                text: qsTr("Buscar: ")
                anchors.verticalCenter: parent.verticalCenter
            }
            Rectangle{
                id: xTiSearch
                width: r.width-labelSearch.contentWidth-btnSearch.width-app.fs*2
                height: app.fs*2
                border.width: 2
                clip: true
                anchors.verticalCenter: parent.verticalCenter
                TextInput{
                    id: tiSearch
                    width: parent.width-app.fs*0.5
                    height: parent.height-app.fs
                    font.pixelSize: app.fs
                    anchors.centerIn: parent
                    Keys.onReturnPressed: getSearch(tiSearch.text)
                    onTextChanged: xListProdSearch.clear()
                }
            }
            Boton{
                id: btnSearch
                text: 'Buscar'
                fontSize: app.fs
                onClicked: {
                    getSearch(tiSearch.text)
                }
            }
        }
        Item {
            width: 10
            height: app.fs
        }
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
            id: xListProdSearch
            width: cabLV.width
            height: xApp.height-xMenu.height-cabLV.height-rowBtns.height-xTotalConIVA.height-rowSearch.height-app.fs*2
            inSearch: true
            onDataChanged: {
                console.log('SP Data changed!')
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
        Row{
            id: rowBtns
            Boton{
                id: btnAddProd
                text: xListProdSearch.idsSelected.length<=1?'Agregar Producto':'Agregar Productos'
                fontSize: app.fs
                opacity: 0.0
                enabled: opacity===1.0
                //visible: xListProdSearch.listModel.count>=1
                onClicked: {
                    for(var i=0;i<xListProdSearch.listModel.count;i++){
                        //console.log('cccc '+i+': '+xListProdSearch.listModel.get(i).seleccionado)
                        if(xListProdSearch.listModel.get(i).seleccionado){
                            let existe=false
                            for(var i2=0;i2<xGetPres.list.listModel.count;i2++){
                                console.log('numId:['+xGetPres.list.listModel.get(i2).numId+'] id:['+xListProdSearch.listModel.get(i2).numId+']')
                                if(xGetPres.list.listModel.get(i2).numId===xListProdSearch.listModel.get(i).numId){
                                    existe=true
                                    //break
                                }
                            }
                            if(!existe){
                                console.log('Producto no existe: '+xListProdSearch.listModel.get(i).descripcion)
                                xGetPres.list.listModel.append(xGetPres.list.listModel.addItem(xListProdSearch.listModel.get(i).numId, xListProdSearch.listModel.get(i).descripcion, xListProdSearch.listModel.get(i).codigo, xListProdSearch.listModel.get(i).precioinstalacion, xListProdSearch.listModel.get(i).precioabono, xListProdSearch.listModel.get(i).adicionalriesgo, xListProdSearch.listModel.get(i).observaciones, xListProdSearch.listModel.get(i).cant))
                                //ncProds.push(app.cProds[i])
                            }else{
                                //Existe. Agregando cantidad
                                //console.log('Producto existe: '+xListProdSearch.listModel.get(i).nombre)
                                for(var i3=0;i3<xGetPres.list.listModel.count;i3++){
                                    if(xGetPres.list.listModel.get(i3).numId===xListProdSearch.listModel.get(i2).numId){
                                        let ncant=xListProdSearch.listModel.get(i2).cant+xGetPres.list.listModel.get(i3).cant
                                        xGetPres.list.listModel.get(i3).cant=ncant
                                        //break
                                    }
                                }
                            }
                        }
                    }
                    for(var i=0;i<xListProdSearch.listModel.count;i++){
                        xListProdSearch.listModel.get(i).seleccionado=false
                        xListProdSearch.listModel.get(i).cant=0
                    }
                    app.mod=1
                }
                Timer{
                    id: t2
                    running: true
                    repeat: true
                    interval: 500
                    onTriggered: {
                        let e=false
                        let v=0
                        for(var i=0;i<xListProdSearch.listModel.count;i++){
                            if(xListProdSearch.listModel.get(i).seleccionado===true){
                                e=true
                                v++
                            }
                            if(v===1){
                                btnAddProd.text='Agregar Producto'
                            }
                            if(v>=2){
                                btnAddProd.text='Agregar Productos'
                                break
                            }
                        }
                        btnAddProd.opacity=e?1.0:0.0
                    }
                }
            }
        }
    }
    Text{
        text: 'ids: '+xListProdSearch.idsSelected.toString()
        font.pixelSize: 30
        color: 'blue'
        visible: false
    }
    function setTotal(){
        xTotalSinIVA.total=parseFloat(xListProdSearch.getTotal()).toFixed(2)
    }
    function getSearch(consulta){
        let url=app.serverUrl+':'+app.portRequest+'/ppres/searchproducto?consulta='+consulta
        console.log('Get '+app.moduleName+' server from '+url)
        var req = new XMLHttpRequest();
        req.open('GET', url, true);
        req.onreadystatechange = function (aEvt) {
            if (req.readyState === 4) {
                if(req.status === 200){
                    let json=JSON.parse(req.responseText)
                    //console.log(req.responseText)
                    setSearchResult(json)
                }else{
                    console.log("Error el cargar el servidor de Mercurio. Code 1\n");
                }
            }
        };
        req.send(null);
    }
    function setSearchResult(json){
        for(var i=0;i<Object.keys(json.productos).length;i++){            
                //Rows 'descripcion', 'codigo', 'precioinstalacion', 'precioabono', 'adicionalriesgo', 'observaciones'
//                console.log('P1'+i+': '+json.productos[i].descripcion)
//                console.log('P2'+i+': '+json.productos[i].codigo)
//                console.log('P3'+i+': '+json.productos[i].precioinstalacion)
//                console.log('P4'+i+': '+json.productos[i].precioabono)
//                console.log('P5'+i+': '+json.productos[i].adicionalriesgo)
//                console.log('P6'+i+': '+json.productos[i].observaciones)
                let existe=false
                let cant=0
                for(var i2=0;i2<xGetPres.list.listModel.count;i2++){
                    //console.log('RS --> numId:['+xGetPres.list.listModel.get(i2).numId+'] id:['+json.productos[i]._id+']')
                    if(xGetPres.list.listModel.get(i2).numId===json.productos[i]._id){
                        existe=true
                        cant=xGetPres.list.listModel.get(i2).cant
                        break
                    }
                }
                xListProdSearch.addProd(json.productos[i]._id, json.productos[i].descripcion, json.productos[i].codigo, json.productos[i].precioinstalacion, json.productos[i].precioabono, json.productos[i].adicionalriesgo, json.productos[i].observaciones, cant)

        }
        xListProdSearch.focus=true
    }
}
