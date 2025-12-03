pragma ComponentBehavior: Bound

import qs.services
import qs.modules.common
import QtQuick
import QtQuick.Layouts

ColumnLayout {
    id: clockColumn
    spacing: 4

    property bool isVertical: Config.options.background.widgets.clock.digital.vertical
    property color textColor: Appearance.colors.colOnSurface
    property int textAlignment: Text.AlignHCenter

    Item {
        Layout.fillWidth: true
        implicitHeight: timeTextTop.font.pixelSize + (clockColumn.isVertical ? timeTextBottom.font.pixelSize + 10 : 0)
        implicitWidth: Math.max(timeTextTop.paintedWidth, timeTextBottom.paintedWidth)

        ClockText {
            id: timeTextTop
            color: clockColumn.textColor
            horizontalAlignment: clockColumn.textAlignment
            text: clockColumn.isVertical ? DateTime.time.substring(0, 2) : DateTime.time
            anchors {
                top: parent.top
                horizontalCenter: parent.horizontalCenter
            }
            font {
                pixelSize: Config.options.background.widgets.clock.digital.font.size
                weight: Config.options.background.widgets.clock.digital.font.weight
                variableAxes: ({
                    "wdth": Config.options.background.widgets.clock.digital.font.width,
                    "ROND": Config.options.background.widgets.clock.digital.font.roundness
                })
        }
        ClockText {
            id: timeTextBottom
            color: clockColumn.textColor
            horizontalAlignment: clockColumn.textAlignment
            text: clockColumn.isVertical ? DateTime.time.substring(3, 5) : ""
            visible: clockColumn.isVertical

    Loader {
        Layout.topMargin: -40
        Layout.fillWidth: true
        active: clockColumn.isVertical
        visible: active
        sourceComponent: ClockText {
            id: timeTextBottom
            text: DateTime.time.split(":")[1].split(" ")[0].padStart(2, "0")
            color: clockColumn.colText
            horizontalAlignment: clockColumn.textHorizontalAlignment
            font {
                pixelSize: timeTextTop.font.pixelSize
                weight: timeTextTop.font.weight
                family: timeTextTop.font.family
                variableAxes: timeTextTop.font.variableAxes
            }
        }
    }

    ClockText {
        color: clockColumn.textColor
        horizontalAlignment: clockColumn.textAlignment
        visible: Config.options.background.widgets.clock.digital.showDate
        Layout.topMargin: -20
        Layout.fillWidth: true
        text: DateTime.longDate
        color: clockColumn.colText
        horizontalAlignment: clockColumn.textHorizontalAlignment
    }

    // Quote
    ClockText {
        color: clockColumn.textColor
        horizontalAlignment: clockColumn.textAlignment
        visible: Config.options.background.widgets.clock.quote.enable && Config.options.background.widgets.clock.quote.text.length > 0
        font.pixelSize: Appearance.font.pixelSize.normal
        text: Config.options.background.widgets.clock.quote.text
        animateChange: false
        color: clockColumn.colText
        horizontalAlignment: clockColumn.textHorizontalAlignment
    }
}
