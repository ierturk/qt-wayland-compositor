
import QtQuick 2.0
import QtWayland.Compositor 1.3

WaylandCompositor {
    id: waylandCompositor

    Screen { id: screen; compositor: waylandCompositor }

    // Shell surface extension. Needed to provide a window concept for Wayland clients.
    // I.e. requests and events for maximization, minimization, resizing, closing etc.
    XdgShell {
        onToplevelCreated: screen.handleShellSurface(xdgSurface)
    }

    // Unstable version of xdg-shell still used by some clients
    XdgShellV6 {
        onToplevelCreated: screen.handleShellSurface(xdgSurface)
    }

    // Deprecated shell extension, still used by some clients
    WlShell {
        onWlShellSurfaceCreated: screen.handleShellSurface(shellSurface)
    }

    // Extension for Input Method (QT_IM_MODULE) support at compositor-side
    TextInputManager {}
}
