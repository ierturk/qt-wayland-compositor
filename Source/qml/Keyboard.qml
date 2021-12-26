
import QtQuick 2.5
import QtQuick.VirtualKeyboard 2.1

InputPanel {
    visible: active
    y: active ? parent.height - height : parent.height
    anchors.left: parent.left
    anchors.right: parent.right
}

