import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Rectangle{
    id: dialog
    property date selectedDate: new Date()
    //onSelectedDateChanged: console.log(dialog.objectName + " sel: " + selectedDate)

    //standardButtons: Dialog.Ok | Dialog.Cancel

    //width: 300
    //height: 500
    //padding: 0
    //topPadding: 0

    //onAccepted: selectedDate = stack.tmp_date

    property  alias cDate: stack.tmp_date

    Page {
        id: column

        anchors.fill: parent
        anchors.margins: 0

        /*Rectangle {
            id: rectangle
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: app.fs*4
            color: Material.primary

            Button {
                id: bt_year
                flat: true
                text: stack.tmp_date.getFullYear()
                font.pixelSize: 10
                anchors.top: parent.top
                anchors.left: parent.left

                enabled: false//stack.depth === 1

                contentItem: Text {
                    text: parent.text
                    font: parent.font
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    color: "white"
                    opacity: parent.enabled ? 1 : 0.5
                }
                background.opacity: down ? 1 : 0

                onClicked: stack.push(year_view, StackView.Immediate)
            }
            Button {
                id: bt_date
                anchors.top: bt_year.bottom
                anchors.left: parent.left
                flat: true
                enabled: false//stack.depth === 2

                contentItem: Text {
                    text: parent.text
                    font.pointSize: 20
                    font.weight: Font.DemiBold
                    anchors.centerIn: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    color: "white"
                    opacity: parent.enabled ? 1 : 0.5
                }
                background.opacity: down ? 1 : 0
                onClicked: stack.pop(null, StackView.Immediate)

                text: Qt.locale().dayName(stack.tmp_date.getDay(), Locale.ShortFormat) + ", " + Qt.locale().monthName(stack.tmp_date.getMonth(), Locale.ShortFormat) + " " + stack.tmp_date.getFullYear()
            }
        }*/


        Text {
            id: rectangle
            text: 'Fecha: '+stack.tmp_date.getFullYear()+'/'+parseInt(stack.tmp_date.getMonth()+1)+'/'+stack.tmp_date.getDate()
            font.pixelSize: app.fs
        }
        StackView {
            id: stack
            property date tmp_date: selectedDate
            //onTmp_dateChanged: console.log(dialog.objectName + " tmp: " + tmp_date)

            initialItem: calendar

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: rectangle.bottom
            anchors.bottom: parent.bottom
        }

        Component {
            id: calendar
            Page {
                leftPadding: app.fs*0.5
                rightPadding: app.fs*0.5
                bottomPadding: 0
                id: calendar_view

                Item {
                    id: controls
                    width: dialog.width-app.fs
                    z: 1
                    height: app.fs*3
                    Boton{
                        text: '<'
                        fontSize: app.fs
                        onClicked: listview.decrementCurrentIndex()
                        //Layout.alignment: Qt.AlignLeft
                    }
                    Boton{
                        text: '>'
                        fontSize: app.fs
                        onClicked: listview.incrementCurrentIndex()
                        anchors.right: parent.right
                        anchors.rightMargin: app.fs
                        //Layout.alignment: Qt.AlignLeft
                    }
                }

                ListView {
                    id: listview

                    property var currentYear: model.yearAt(currentIndex)
                    property var currentMonth: model.monthAt(currentIndex)

                    anchors.fill: parent

                    spacing: 20

                    snapMode: ListView.SnapOneItem
                    orientation: ListView.Horizontal
                    highlightRangeMode: ListView.StrictlyEnforceRange
                    clip: true
                    currentIndex: monthDiff(from, stack.tmp_date)

                    function monthDiff(date1, date2) {
                        return (date2.getFullYear() * 12 + date2.getMonth()) - (date1.getFullYear() * 12 + date1.getMonth())
                    }

                    property date from: new Date(1900, 0, 1)
                    property date to: new Date(2099, 11, 31)

                    highlightMoveDuration: 0

                    model: CalendarModel {
                        id: model
                        from: listview.from
                        to: listview.to
                    }

                    delegate: Page {

                        width: listview.width
                        height: listview.height

                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: Qt.locale().monthName(model.month) + " " + model.year
                            anchors.topMargin: app.fs*0.25
                            anchors.top: parent.top
                            font: grid.font
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }

                        DayOfWeekRow {
                            locale: model.locale
                            anchors.bottom: grid.top
                            anchors.left: grid.left
                            anchors.right: grid.right
                            Layout.alignment: Qt.AlignBottom
                            delegate: Text {
                                text: model.narrowName
                                font.pixelSize: app.fs*0.75
                                color: 'black'//Material.color(Material.Grey)
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                        }

                        MonthGrid {
                            id: grid
                            font.pixelSize: app.fs
                            month: model.month
                            year: model.year
                            locale: model.locale
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: parent.bottom

                            height: Math.min(Layout.width, Layout.height)
                            width: Math.min(Layout.width, Layout.height)

                            delegate: RadioButton {
                                opacity: model.month === grid.month ? 1 : 0
                                text: model.day
                                font: grid.font
                                width: 32
                                height: 32
                                checked: (stack.tmp_date.getDate() === model.day) && (stack.tmp_date.getFullYear() === model.year) && (stack.tmp_date.getMonth() === model.month)

                                //Component.onCompleted: checked = (stack.tmp_date.getDate() === model.day) && (stack.tmp_date.getFullYear() === model.year) && (stack.tmp_date.getMonth() === model.month) ? true : false

                                indicator: Rectangle {
                                    anchors.fill: parent
                                    radius: Math.max(width, height)/2
                                    visible: parent.checked
                                    color: Material.primary
                                }

                                contentItem: Text {
                                    text: parent.text
                                    font: parent.font
                                    anchors.centerIn: parent
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    color: parent.checked ? "white" : Material.foreground
                                    z: 1
                                }

                                onClicked: {
                                    if (checked) {
                                        var d=model.date
                                        d.setDate(d.getDate() +1)
                                        stack.tmp_date = d//model.date
                                    }
                                }
                            }
                        }
                    }
                }
            }

        }

        Component {
            id: year_view

            Page {
                id: page
                Tumbler {
                    id: yearTumbler
                    model: calcModel(start, end)
                    property int start: 1900
                    property int end: 2100
                    visibleItemCount: 5
                    wrap: false
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: parent.height

                    delegate: Text {
                        id: label
                        text: modelData
                        color: Material.foreground
                        font.pointSize: 16
                        opacity: 1
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    currentIndex: stack.tmp_date.getFullYear() - start

                    onCurrentIndexChanged: {
                        var _date = stack.tmp_date
                        _date.setFullYear(currentIndex + start)
                        stack.tmp_date = _date
                    }

                    function calcModel(start, end) {
                        var tmp = [];
                        if (start > end) {
                            model = [];
                            return;
                        }
                        for (var i = start; i <= end; i++) {
                            tmp.push(i);
                        }
                        model = tmp;
                    }
                }
            }
        }
    }
}
