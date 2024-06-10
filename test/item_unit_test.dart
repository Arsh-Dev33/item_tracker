import 'package:flutter_test/flutter_test.dart';
import 'package:item_tracker/item_model.dart';
import 'package:item_tracker/item_provider.dart';

void main() {
  group('ItemProvider', () {
    test('initial items list is empty', () {
      final provider = ItemProvider();
      expect(provider.items, isEmpty);
    });

    test('addItem adds item to list', () {
      final provider = ItemProvider();
      final item =
          Item(id: '1', name: 'Item Test', description: 'Description Test');
      provider.addItem(item);
      expect(provider.items, [item]);
    });

    test('editItem updates item in list', () {
      final provider = ItemProvider();
      final item1 = Item(
          id: '1', name: 'Edit Test Item', description: 'Edit Description');
      final item2 = Item(
          id: '1',
          name: 'Edit Item Updated',
          description: 'Description Updated');
      provider.addItem(item1);
      provider.editItem(item2);
      expect(provider.items, [item2]);
    });

    test('removeItem removes item from list', () {
      final provider = ItemProvider();
      final item =
          Item(id: '1', name: 'Load Item', description: 'Load Description');
      provider.addItem(item);
      provider.removeItem('1');
      expect(provider.items, isEmpty);
    });

    test('notifyListeners is called when items list changes', () {
      final provider = ItemProvider();
      int notifyCount = 0;
      provider.addListener(() {
        notifyCount++;
      });
      provider
          .addItem(Item(id: '1', name: 'Payout', description: 'checkpayout'));
      expect(notifyCount, 1);
      provider
          .editItem(Item(id: '1', name: 'Payout Updated', description: 'done'));
      expect(notifyCount, 2);
      provider.removeItem('1');
      expect(notifyCount, 3);
    });
  });
}
