//@ pragma UseQApplication

import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import Quickshell.Hyprland
import QtQuick.Controls
import QtQuick

ShellRoot {
  id:root

  property color bg: "#282828"
  property color gray_dark: "#928374"
  property color gray_light: "#a89984"
  property color fg: "#ebdbb2"

  PanelWindow {
    anchors.top: true
    height: 30
    width: screen.width 
    color: root.bg
    id: bar

    Text {
      anchors.centerIn: parent
      id: clock
      text: Qt.formatTime(new Date(), "hh:mm")
      color: root.fg

      MouseArea {
        anchors.fill: parent
        onClicked: {
          root.calendarOpen = !root.calendarOpen
        }
      }
    }

    Timer {
      interval: 1000
      running: true
      repeat: true
      onTriggered: {
        clock.text = Qt.formatTime(new Date(), "hh:mm")
      }
    }

  // workspaces
    Row {
      anchors.left: parent.left
      Repeater {
        model: Hyprland.workspaces
        delegate: Rectangle {
          width: 30
          height: 32
          color: "transparent"

          Text {
            text: modelData.name
            anchors.centerIn: parent
            color: modelData.focused ? root.fg : root.gray_dark
          }

        MouseArea {
          anchors.fill: parent
          onClicked: modelData.activate() 
          }
        }
      }
    }

    // system tray
    Row {
      anchors.right: parent.right
      Repeater {
        model: SystemTray.items
        delegate: Rectangle {
          id: trayItem
          IconImage {
            anchors.centerIn: parent
            source: modelData.icon
            implicitSize: 20
          }

          MouseArea {
            id: mouseArea
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            onClicked: (mouse)=> {
              if (mouse.button === Qt.LeftButton) {
                modelData.activate()
              } else if (mouse.button === Qt.RightButton) {
                var pos = mapToItem(bar.contentItem, mouse.x, mouse.y)
                        console.log("mouse.x:", mouse.x, "mouse.y:", mouse.y)
        console.log("mapped pos.x:", pos.x, "pos.y:", pos.y)
                modelData.display(bar.contentItem, pos.x, pos.y)
              }
            }
          }

          width: 30
          height: 32
          color: "transparent"
        }
      }
    }
  }

  property bool calendarOpen: false

  // Calendar
  PanelWindow {
    implicitHeight: root.calendarOpen ? calendarDays.implicitHeight : 0
    implicitWidth: root.calendarOpen ? calendarDays.implicitWidth : 0
    id: calendar
    margins.top: 32
    anchors.top: true
    exclusiveZone: -1

    Column{
      id: calendarDays
      anchors.top: parent.top
      anchors.horizontalCenter: parent.horizontalCenter

      Text {
        width: month.implicitWidth
        horizontalAlignment: Text.AlignHCenter
        text: Qt.formatDate(new Date(), "MMMM yyyy")
        font.bold: true
      }

      DayOfWeekRow {
        width: month.implicitWidth
      }

      MonthGrid {
        id: month
        delegate: Rectangle {
          width: 30
          height: 30

          Text {
            font.bold: Qt.formatDate(model.date, "yyyy-MM-dd") === Qt.formatDate(new Date(), "yyyy-MM-dd")
            color: Qt.formatDate(model.date, "yyyy-MM-dd") === Qt.formatDate(new Date(), "yyyy-MM-dd") ? "red" : "black"
            anchors.centerIn: parent
            text: model.day
          }
        }
      }
    }
  }
}
