import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
    override func awakeFromNib() {
        super.awakeFromNib()

        let flutterViewController = FlutterViewController()
        self.contentViewController = flutterViewController
        self.setFrame(self.frame, display: true)
        self.minSize = NSSize(width: 640, height: 430)

        RegisterGeneratedPlugins(registry: flutterViewController)
    }
}
