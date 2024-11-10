import 'package:flutter/cupertino.dart';
import 'package:desktop_window/desktop_window.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  Future<void> setWindowSize() async {
    await DesktopWindow.setMinWindowSize(const Size(400, 400));
    await DesktopWindow.setWindowSize(const Size(500, 500));
    await DesktopWindow.setMaxWindowSize(const Size(600, 600));
  }

  @override
  void initState() {
    super.initState();
    setWindowSize();
  }

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: CupertinoPageScaffold(
        child: Center(child: Text('Drag app to change icon!')),
      ),
    );
  }
}
