// First-party imports.
import 'package:flutter/cupertino.dart';

// Third-party imports.
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:package_info_plus/package_info_plus.dart';

// Local imports.
import 'package:alter/gen/assets.gen.dart';

/// The about sheet page.
/// This holds the developer details, logo, and other "about" information for the app.
/// As well as, probably, some quotes?
class AboutSheetPage extends StatelessWidget {
  const AboutSheetPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    final packageInfoFuture = PackageInfo.fromPlatform();

    return FutureBuilder<PackageInfo>(
      future: packageInfoFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: ProgressCircle(
              radius: 13,
              value: null,
            ),
          );
        }
        final packageInfo = snapshot.data!;
        return GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: MacosSheet(
            insetAnimationDuration: const Duration(milliseconds: 300),
            insetPadding: const EdgeInsets.all(50),
            insetAnimationCurve: Curves.easeInOut,
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Center(
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  child: FadingEdgeScrollView.fromSingleChildScrollView(
                    gradientFractionOnStart: 0.2,
                    gradientFractionOnEnd: 0.2,
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Assets.images.alterIcon.image(
                            width: 120,
                            height: 120,
                          ),
                          const Text(
                            'Alter',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                              letterSpacing: -2,
                              color: CupertinoColors.systemGrey,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            'Package name: ${packageInfo.packageName}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Build version: ${packageInfo.version}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 380),
                            child: Column(
                              children: [
                                const Text(
                                  'Special thanks to Raven and Firstrain for supporting the development and giving a ton of inspiration.\n\nThis is my first macOS app project which I took on in desperation since I wanted to add a personal look to most of my apps, but the most stable option at that time was paywalled and not really "stable".',
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 30),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    PushButton(
                                      onPressed:
                                          () {}, // TODO: Add external links.
                                      secondary: true,
                                      controlSize: ControlSize.regular,
                                      child: Text('Learn more'),
                                    ),
                                    const SizedBox(width: 10),
                                    PushButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      secondary: true,
                                      controlSize: ControlSize.regular,
                                      child: Text('Close'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
