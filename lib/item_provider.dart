import 'package:flutter/material.dart';
import 'package:item_tracker/item_model.dart';

class ItemProvider with ChangeNotifier {
  List<Item> _items = [];

  set items(List<Item> value) {
    _items = value;
    notifyListeners();
  }

  List<Item> get items => _items;

  void addItem(Item item) {
    _items.add(item);
    notifyListeners();
  }

  void editItem(Item item) {
    int index = _items.indexWhere((i) => i.id == item.id);
    if (index != -1) {
      _items[index] = item;
      notifyListeners();
    }
  }

  void removeItem(String id) {
    _items.removeWhere((i) => i.id == id);
    notifyListeners();
  }
}
