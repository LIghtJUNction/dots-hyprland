pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Services.Polkit
import qs.modules.common

Singleton {
    id: root
    property var agent: polkitAgentLoader.item
    property bool active: agent?.isActive ?? false
    property var flow: agent?.flow
    property bool interactionAvailable: false

    function cancel() {
        root.flow?.cancelAuthenticationRequest()
    }

    function submit(string) {
        root.flow?.submit(string)
        root.interactionAvailable = false
    }

    Connections {
        target: root.flow
        function onAuthenticationFailed() {
            root.interactionAvailable = true;
        }
    }

    Loader {
        id: polkitAgentLoader
        active: Config.options.polkit.enable ?? true
        sourceComponent: PolkitAgent {
            onAuthenticationRequestStarted: {
                root.interactionAvailable = true;
            }
        }
    }
}
