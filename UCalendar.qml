import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Calendar{
    id: r
    property bool setTextInput: true
    property int num:-1
    property int currentYear: r.selectedDate.getFullYear()
    property int currentMonth: r.selectedDate.getMonth()+1
    property int currentDay: r.selectedDate.getDate()
    property var monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiempre', 'Octubre', 'Noviembre', 'Diciembre']
    property string monthString: 'Mes N°'
    property int widthBtns:  Qt.platform.os!=='android'?app.fs*1.2:app.fs*2
    signal selected(var newDate)

    onVisibleChanged:{
        if(parent.objectName==='itemCal1'){
            num=1
            return
        }
        if(parent.objectName==='itemCal2'){
            num=2
            return
        }
        num=-1
    }
    style: CalendarStyle {
        id: uCalendarStyle

        navigationBar: Rectangle{
            width: r.width-2
            height: r.widthBtns*4
            color: app.c1
            anchors.centerIn: parent
            Column{
                spacing: app.fs
                anchors.centerIn: parent
//                Row{
//                    spacing: app.fs
//                    anchors.horizontalCenter: parent.horizontalCenter
//                    Boton{
//                        text: '-10'
//                        width: app.fs*2
//                        height: r.widthBtns
//                        onClicked: {
//                            setTextInput=false
//                            var fecha = r.selectedDate;
//                            fecha.setYear(fecha.getFullYear() - 10);
//                            r.selectedDate=fecha
//                        }
//                    }
//                    Boton{
//                        text: '-1'
//                        width: app.fs*2
//                        height: r.widthBtns
//                        onClicked: {
//                            setTextInput=false
//                            var fecha = r.selectedDate;
//                            fecha.setYear(fecha.getFullYear() - 1);
//                            r.selectedDate=fecha
//                        }
//                    }
//                    Text{
//                        text: r.currentYear
//                        font.pixelSize: app.fs
//                        color: app.c2
//                        anchors.verticalCenter: parent.verticalCenter
//                    }
//                    Boton{
//                        text: '+1'
//                        width: app.fs*2
//                        height: r.widthBtns
//                        onClicked: {
//                            setTextInput=false
//                            var fecha = r.selectedDate;
//                            fecha.setYear(fecha.getFullYear() + 1);
//                            r.selectedDate=fecha
//                        }
//                    }
//                    Boton{
//                        text: '+10'
//                        width: app.fs*2
//                        height: r.widthBtns
//                        onClicked: {
//                            setTextInput=false
//                            var fecha = r.selectedDate;
//                            fecha.setYear(fecha.getFullYear() + 10);
//                            r.selectedDate=fecha
//                        }
//                    }
//                }

                Row{
                    spacing: app.fs
                    anchors.horizontalCenter: parent.horizontalCenter
                    Boton{
                        text: '<'
                        width: r.widthBtns
                        height: width
                        onClicked: {
                            setTextInput=false
                            var fecha = r.selectedDate;
                            fecha.setMonth(fecha.getMonth() - 1);
                            r.selectedDate=fecha
                        }
                    }
                    Text{
                        text: r.monthString+' '+r.currentMonth+' '+r.monthNames[r.currentMonth - 1]+' '+r.currentYear
                        font.pixelSize: app.fs
                        color: app.c2
                        width: r.width*0.6
                        horizontalAlignment: Text.AlignHCenter
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Boton{
                        text: '>'
                        width: r.widthBtns
                        height: width
                        onClicked: {
                            setTextInput=false
                            var fecha = r.selectedDate;
                            fecha.setMonth(fecha.getMonth() + 1);
                            r.selectedDate=fecha
                        }
                    }
                }
            }
        }


        dayOfWeekDelegate: Rectangle{
            width: r.width
            height: app.fs*4
            color: 'white'
            border.width: 1
            border.color: app.c2
            Label {
                id: l1
                text:control.__locale.dayName(styleData.dayOfWeek, control.dayOfWeekFormat)
                font.pixelSize: app.fs
                anchors.centerIn: parent
                color: 'black'
            }
//            Item{
//                visible: styleData.dayOfWeek===1
//                anchors.verticalCenter: l1.verticalCenter
//                anchors.right: parent.left
//                //anchors.rightMargin: parent.width-l1.width
//                width: parent.width
//                height: parent.height
//                Label {
//                    text:  'dom.'
//                    font.pixelSize: app.fs
//                    color: app.c2
//                    anchors.centerIn: parent
//                }
//            }
//            Rectangle {
//                width: parent.width
//                height: 1
//                color: app.c3
//                anchors.bottom: parent.bottom
//            }
        }
        dayDelegate: Rectangle{
            id: xDayDelegate
            color: styleData.selected ? 'red' : (styleData.visibleMonth && styleData.valid ? "white" : "#ccc");
            Label {
                text: styleData.date.getDate()
                font.pixelSize: app.fs
                anchors.centerIn: parent
                color: styleData.valid ? (styleData.selected ?'white':'black') : 'black'
            }
            Rectangle {
                width: parent.width
                height: 1
                color: 'black'
                anchors.bottom: parent.bottom
            }
            Rectangle {
                width: 1
                height: parent.height
                color: 'black'
                anchors.right: parent.right
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    r.setTextInput=true
                    r.selectedDate=styleData.date
                    //r.visible=false
                }
            }
        }
    }
    onSelectedDateChanged: {
        currentYear= r.selectedDate.getFullYear()
        currentMonth= r.selectedDate.getMonth()+1
        currentDay= r.selectedDate.getDate()
        if(setTextInput){
            var d = selectedDate
            let dia=''+d.getDate()
            let mes=''+parseInt(d.getMonth()+1)
            if(parseInt(dia)<10){
                dia='0'+dia
            }
            if(parseInt(mes)<10){
                mes='0'+mes
            }
            let an=d.getFullYear()
            let s=''+dia+'/'+mes+'/'+an
            //uLogView.showLog('set!'+cal.num)
            r.selected(d)
        }
        setTextInput=true
    }
    Rectangle{
        anchors.fill: parent
        color: 'red'
        z: parent.z-1
    }
    MouseArea{
        anchors.fill: parent
        z: r.z-1
    }
}
