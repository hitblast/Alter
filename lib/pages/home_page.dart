import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.darkBackgroundGray,
      child: Center(
        child: GestureDetector(
          onTap: () {
            if (kDebugMode) {
              print('Icon tapped. Trigger icon selection using path_provider.');
            }
          },
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('assets/alter_empty_page_front.png'),
                width: 250,
                height: 250,
              ),
              SizedBox(height: 10),
              Text('Tap to change icon!'),
            ],
          ),
        ),
      ),
    );
  }
}
