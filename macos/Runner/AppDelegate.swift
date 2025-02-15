// Imports.
import Cocoa
import FlutterMacOS

// The AppDelegate class which is the entry point of the application.
@main
class AppDelegate: FlutterAppDelegate {
    override func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

    override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        NSApp.setActivationPolicy(.accessory)
        return false
    }

    override func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.setActivationPolicy(.regular)
        NSApp.activate(ignoringOtherApps: true)
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

    // When reopening the app, show the previously opened window.
    override func applicationShouldHandleReopen(
        _ sender: NSApplication, hasVisibleWindows flag: Bool
    ) -> Bool {
        NSApp.setActivationPolicy(.regular)
        if !flag, let window = NSApp.windows.first {
            NSApp.activate(ignoringOtherApps: true)
            window.makeKeyAndOrderFront(self)
        }
        return true
    }
}
