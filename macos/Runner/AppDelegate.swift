import Cocoa
import FlutterMacOS

@main
class AppDelegate: FlutterAppDelegate {
    override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return false
    }

    override func applicationShouldTerminate(_ sender: NSApplication)
        -> NSApplication.TerminateReply
    {
        return .terminateNow
    }
}
