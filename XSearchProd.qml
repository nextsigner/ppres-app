import QtQuick 2.0

Item {
    id: r
    width: xApp.width
    height: col.height
    anchors.horizontalCenter: parent.horizontalCenter
    property alias list: xListProdSearch
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
            id: rowMarcadores
            anchors.horizontalCenter: parent.horizontalCenter
            Boton{
                text: 'Vigilancia'
                fontSize: app.fs
                enabled: xListProdSearch.idsSelected.length<=1
                onClicked: {
                    xListProdSearch.clear()
                    getSearch('vigilancia')
                }
            }
            Boton{
                text: 'Services'
                fontSize: app.fs
                enabled: xListProdSearch.idsSelected.length<=1
                onClicked: {
                    xListProdSearch.clear()
                    getSearch('service')
                }
            }

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
            height: xApp.height-xMenu.height-rowMarcadores.height-cabLV.height-rowBtns.height-xTotal.height-rowSearch.height-app.fs*2
            inSearch: true
            //            onProductoAgregado: {
            //                console.log('Producto agregado!')
            //                xTotal.total=parseFloat(getTotal()).toFixed(2)
            //            }
        }
        //        Row{
        //            id: row
        //            anchors.horizontalCenter: parent.horizontalCenter
        Rectangle{
            id: xTotal
            width: r.width*0.4
            height: app.fs*2
            border.width: 1
            border.color: 'black'
            property real total: 0
            anchors.right: parent.right
            Text {
                text: '<b>Total: $</b> '+xTotal.total
                font.pixelSize: app.fs
                anchors.centerIn: parent
                wrapMode: Text.WordWrap
            }
        }
        //}
        Row{
            id: rowBtns
            Boton{
                text: xListProdSearch.idsSelected.length<=1?'Agregar Producto':'Agregar Productos'
                fontSize: app.fs
                enabled: xListProdSearch.idsSelected.length<=1
                onClicked: {
                    for(var i=0;i<xListProdSearch.listModel.count;i++){
                        if(xListProdSearch.listModel.get(i).seleccionado){
                            //console.log('Producto: '+xListProdSearch.listModel.get(i).nombre)
                            xGetPres.list.listModel.append(xGetPres.list.listModel.addItem(xListProdSearch.listModel.get(i).numId, xListProdSearch.listModel.get(i).categoria, xListProdSearch.listModel.get(i).nombre, xListProdSearch.listModel.get(i).tipovivienda, xListProdSearch.listModel.get(i).adicionalporelemento, xListProdSearch.listModel.get(i).precio))
                            //ncProds.push(app.cProds[i])
                        }
                    }
                    for(var i=0;i<xListProdSearch.listModel.count;i++){
                       xListProdSearch.listModel.get(i).seleccionado=false
                    }
                    app.mod=1

                    /*let ncProds=[]
                    for(var i=0;i<app.cProds.length;i++){
                        ncProds.push(app.cProds[i])
                    }
                    for(i=0;i<xListProdSearch.idsSelected.length;i++){
                        ncProds.push(xListProdSearch.idsSelected[i])
                    }
                    app.cProds=ncProds*/
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
    function getSearch(consulta){
        let url=app.serverUrl+':'+app.portRequest+'/ppres/searchproducto?consulta='+consulta
        console.log('Get '+app.moduleName+' server from '+url)
        var req = new XMLHttpRequest();
        req.open('GET', url, true);
        req.onreadystatechange = function (aEvt) {
            if (req.readyState === 4) {
                if(req.status === 200){
                    let json=JSON.parse(req.responseText)
                    console.log(req.responseText)
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
            if(json.productos[i].precio&&json.productos[i].tipovivienda){
                console.log('P1'+i+': '+json.productos[i].categoria)
                console.log('P2'+i+': '+json.productos[i].nombre)
                console.log('P3'+i+': '+json.productos[i].tipovivienda)
                console.log('P4'+i+': '+json.productos[i].adicionalporelemento)
                console.log('P5'+i+': '+json.productos[i].precio)
                xListProdSearch.addProd(json.productos[i]._id, json.productos[i].categoria, json.productos[i].nombre, json.productos[i].tipovivienda, json.productos[i].adicionalporelemento, json.productos[i].precio)
            }
        }
    }
}
