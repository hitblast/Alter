import BackgroundTasks
import Cocoa
import FlutterMacOS

@main
class AppDelegate: FlutterAppDelegate {
    //override func applicationDidFinishLaunching(_ notification: Notification) {
    //    super.applicationDidFinishLaunching(notification)
    //    BGTaskScheduler.shared.register(
    //        forTaskWithIdentifier: "com.hitblast.alter.refresh", using: nil
    //    ) { task in
    //        self.handleAppRefresh(task: task as! BGAppRefreshTask)
    //    }
    //    scheduleAppRefresh()
    //}

    //func handleAppRefresh(task: BGAppRefreshTask) {
    //    scheduleAppRefresh()

    //    let flutterViewController = window?.rootViewController as! FlutterViewController
    //    let channel = FlutterMethodChannel(
    //        name: "com.hitblast.alter/update",
    //        binaryMessenger: flutterViewController.binaryMessenger)

    //    channel.invokeMethod("checkForUpdates", arguments: nil) { result in
    //        task.setTaskCompleted(success: (result as? Bool) ?? false)
    //    }
    //}

    //func scheduleAppRefresh() {
    //    let request = BGAppRefreshTaskRequest(identifier: "com.hitblast.alter.refresh")
    //    request.earliestBeginDate = Date(timeIntervalSinceNow: 15 * 60)  // Refresh every 15 minutes.

    //    do {
    //        try BGTaskScheduler.shared.submit(request)
    //    } catch {
    //        print("Could not schedule app refresh: \(error)")
    //    }
    //}

    override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return false
    }
}
