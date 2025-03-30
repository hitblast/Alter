import Cocoa
import FlutterMacOS
import ServiceManagement
import macos_window_utils

class MainFlutterWindow: NSWindow {
    override func awakeFromNib() {
        let flutterViewController = FlutterViewController.init()
        let windowFrame = self.frame
        self.contentViewController = flutterViewController
        self.setFrame(windowFrame, display: true)

        FlutterMethodChannel(
            name: "alter_methods", binaryMessenger: flutterViewController.engine.binaryMessenger
        )
        .setMethodCallHandler { (_ call: FlutterMethodCall, result: @escaping FlutterResult) in
            switch call.method {
            case "enableLaunchAtLogin":
                do {
                    try SMAppService.mainApp.register()
                    result(true)
                } catch {
                    result(
                        FlutterError(
                            code: "ERROR_REGISTER", message: error.localizedDescription,
                            details: nil))
                }
            case "disableLaunchAtLogin":
                do {
                    try SMAppService.mainApp.unregister()
                    result(true)
                } catch {
                    result(
                        FlutterError(
                            code: "ERROR_UNREGISTER", message: error.localizedDescription,
                            details: nil))
                }
            case "isLaunchAtLoginEnabled":
                let isEnabled = SMAppService.mainApp.status == .enabled
                result(isEnabled)
            default:
                result(FlutterMethodNotImplemented)
            }
        }

        RegisterGeneratedPlugins(registry: flutterViewController)

        super.awakeFromNib()
    }
}
