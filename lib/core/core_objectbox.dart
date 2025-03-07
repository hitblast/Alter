// First-party imports.
import 'dart:io';
import 'package:flutter/foundation.dart';

// Third-party imports.
import 'package:path_provider/path_provider.dart';

// Local imports.
import 'package:alter/models/app_model.dart';

// Use ObjectBox's generated file.
import '../objectbox.g.dart';

/// The primary class for database creation and management.
class ObjectBox {
  late final Store store;
  late final Box<App> appBox;

  ObjectBox._create(this.store) {
    appBox = store.box<App>();
  }

  /// Create the ObjectBox instance
  static Future<ObjectBox> create() async {
    final applicationDocumentsDirectory =
        await getApplicationSupportDirectory();
    final dir = Directory('${applicationDocumentsDirectory.path}/AppList');

    // Create the database directory if it doesn't exist.
    if (!(await dir.exists())) {
      debugPrint("Database does not exist, creating one in ${dir.path}");
      await dir.create();
    }

    final store = await openStore(directory: dir.path);
    return ObjectBox._create(store);
  }
}
