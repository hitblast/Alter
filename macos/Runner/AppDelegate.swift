import Cocoa
import FlutterMacOS

@main
class AppDelegate: FlutterAppDelegate {
    override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        NSApp.setActivationPolicy(.accessory)
        return false
    }

    override func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.setActivationPolicy(.regular)
    }

    override func applicationDidBecomeActive(_ notification: Notification) {
        NSApp.setActivationPolicy(.regular)
    }

    override func applicationShouldTerminate(_ sender: NSApplication)
        -> NSApplication.TerminateReply
    {
        NSApp.windows.first?.close()
        return .terminateCancel
    }

    override func applicationShouldHandleReopen(
        _ sender: NSApplication, hasVisibleWindows flag: Bool
    ) -> Bool {
        NSApp.setActivationPolicy(.regular)
        if !flag, let window = NSApp.windows.first {
            window.makeKeyAndOrderFront(self)
        }
        return true
    }
}
