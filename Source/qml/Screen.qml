
import QtQuick 2.5
import QtQuick.Window 2.2
import QtWayland.Compositor 1.0

WaylandOutput {
    id: output

    property ListModel shellSurfaces: ListModel {}
    property bool isNestedCompositor: Qt.platform.pluginName.startsWith("wayland") || Qt.platform.pluginName === "xcb"

    function handleShellSurface(shellSurface) {
        shellSurfaces.append({shellSurface: shellSurface});
    }

    // During development, it can be useful to start the compositor inside X11 or
    // another Wayland compositor. In such cases, set sizeFollowsWindow to true to
    // enable resizing of the compositor window to be forwarded to the Wayland clients
    // as the output (screen) changing resolution. Consider setting it to false if you
    // are running the compositor using eglfs, linuxfb or similar QPA backends.
    sizeFollowsWindow: output.isNestedCompositor

    window: Window {
        width: 1024
        height: 760
        visible: true

        WaylandMouseTracker {
            id: mouseTracker

            anchors.fill: parent

            // Set this to false to disable the outer mouse cursor when running nested
            // compositors. Otherwise you would see two mouse cursors, one for each compositor.
            windowSystemCursorEnabled: output.isNestedCompositor

            Image {
                id: background

                anchors.fill: parent
                fillMode: Image.Tile
                source: "qrc:/images/background.jpg"
                smooth: true

                Repeater {
                    model: output.shellSurfaces
                    // Chrome displays a shell surface on the screen (See Chrome.qml)
                    Chrome {
                        shellSurface: modelData
                        onDestroyAnimationFinished: output.shellSurfaces.remove(index)
                    }
                }
            }

            // Virtual Keyboard
            Loader {
                anchors.fill: parent
                source: "Keyboard.qml"
            }

            // Draws the mouse cursor for a given Wayland seat
            WaylandCursorItem {
                inputEventsEnabled: false
                x: mouseTracker.mouseX
                y: mouseTracker.mouseY
                seat: output.compositor.defaultSeat
            }
        }

        Shortcut {
            sequence: "Ctrl+Alt+Backspace"
            onActivated: Qt.quit()
        }
    }
}
