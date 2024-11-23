// Third-party imports.
import 'package:alter/utils/app_adding_seq.dart';
import 'package:flutter/cupertino.dart';
import 'package:macos_ui/macos_ui.dart';

// The starter page widget.
// This is the first page that the user sees if the have no apps added to the database yet.
class StarterPage extends StatelessWidget {
  const StarterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MacosScaffold(
      children: [
        ContentArea(
          builder: (BuildContext context, scrollController) {
            return GestureDetector(
              onTap: () async {
                await initiateAppAddingSequence(context);
              },
              child: Center(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(20),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('assets/alter_empty_page_front.png'),
                        width: 250,
                        height: 250,
                      ),
                      Text(
                        'Left-click to start customizing.',
                        style: TextStyle(
                          fontSize: 25,
                          color: CupertinoColors.systemGrey,
                          letterSpacing: -2,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
