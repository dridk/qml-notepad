import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Dialogs 1.1

ApplicationWindow {
    id:root
    visible: true
    width: 640
    height: 480
    title: currentFile + (changed?"*":"")
    property bool changed : false
    property string currentFile

   statusBar : StatusBar {

       Text {
           anchors.centerIn: parent
           text:notepad.date
       }

   }

    menuBar: MenuBar {
        Menu {
            title: qsTr("File")
            MenuItem {
                text:qsTr("New")
                shortcut: StandardKey.New
                onTriggered: {

                }

            }
            MenuItem {
                text:qsTr("Open...")
                shortcut: StandardKey.Open
                onTriggered:  openFileDialog.open()




            }
            MenuItem {
                text:qsTr("Save")
                shortcut: StandardKey.Save
                onTriggered:{
                    notepad.save(area.text, currentFile)
                    root.changed = false
                }
            }
            MenuItem {
                text:qsTr("Save as...")
                shortcut: StandardKey.SaveAs
                onTriggered: saveFileDialog.open()
            }

            MenuItem {
                text: qsTr("Exit")
                shortcut: StandardKey.Quit

                onTriggered: Qt.quit();
            }
        }

        Menu {
            title: qsTr("Edit")

            MenuItem {
                text:qsTr("Undo")
                enabled: area.canUndo
                shortcut: StandardKey.Undo
                onTriggered: area.undo()

            }
            MenuItem {
                text:qsTr("Redo")
                enabled: area.canRedo
                shortcut: StandardKey.Redo
                onTriggered: area.redo()

            }
            MenuItem {
                text:qsTr("Copy")
                shortcut: StandardKey.Copy
                onTriggered: area.copy()

            }
            MenuItem {
                text:qsTr("Paste")
                shortcut: StandardKey.Paste
                enabled: area.canPaste
                onTriggered:  area.paste()

            }

        }


    }



    TextArea {
        id:area
        anchors.fill: parent
        onTextChanged: {
            changed = true

        }

    }




    FileDialog {
        id: openFileDialog
        title: "Please choose a file"
        onAccepted: {

            area.text = notepad.open(openFileDialog.fileUrl)
            currentFile = openFileDialog.fileUrl
            changed = false
        }
    }


    FileDialog {
        id: saveFileDialog
        title: "Please choose a file"
        onAccepted: {

            notepad.save(area.text, saveFileDialog.fileUrl)
            currentFile = saveFileDialog.fileUrl
            changed = false
        }


    }




}
