import 'package:flutter/material.dart';

import 'models.dart';

class YourItemManager extends ChangeNotifier {
  bool _createNewItem = false;
  final _yourItems = <YourItem>[];

  bool get isCreatingNewItem => _createNewItem;

  void createNewItem() {
    _createNewItem = true;
    notifyListeners();
  }

  void addItem(YourItem item) {
    _yourItems.add(item);
    _createNewItem = false;
    notifyListeners();
  }
}
