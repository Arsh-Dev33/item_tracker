// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:item_tracker/add_item.dart';
import 'package:item_tracker/home_screen.dart';
import 'package:item_tracker/item_model.dart';
import 'package:item_tracker/item_provider.dart';
import 'package:provider/provider.dart';

void main() {
  group('HomeScreen', () {
    testWidgets('displays no items message when there are no items',
        (WidgetTester tester) async {
      final itemProvider = ItemProvider();

      await tester.pumpWidget(
        ChangeNotifierProvider<ItemProvider>(
          create: (_) => itemProvider,
          child: MaterialApp(
            home: HomeScreen(),
          ),
        ),
      );

      expect(find.text('No Items Added'), findsOneWidget);
    });

    testWidgets('displays items', (WidgetTester tester) async {
      final itemProvider = ItemProvider();
      itemProvider.items = [
        Item(id: '1', name: 'Item ABC', description: 'Description test'),
        Item(id: '2', name: 'Item Second', description: 'Description test2'),
      ];

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => itemProvider),
          ],
          child: MaterialApp(
            home: HomeScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Item ABC'), findsOneWidget);
      expect(find.text('Item Second'), findsOneWidget);
    });
    testWidgets(
        'navigates to AddItemScreen when floating action button is pressed',
        (WidgetTester tester) async {
      final itemProvider = ItemProvider();

      await tester.pumpWidget(
        ChangeNotifierProvider<ItemProvider>(
          create: (_) => itemProvider,
          child: MaterialApp(
            home: HomeScreen(),
          ),
        ),
      );

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      expect(find.byType(AddItemScreen), findsOneWidget);
    });
  });

  group('ItemTile', () {
    testWidgets('displays item name and description',
        (WidgetTester tester) async {
      final item =
          Item(id: '1', name: 'Item test', description: 'Description test');
      final itemProvider = ItemProvider();

      await tester.pumpWidget(
        ChangeNotifierProvider<ItemProvider>(
          create: (_) => itemProvider,
          child: MaterialApp(
            home: ItemTile(item: item, itemProvider: itemProvider),
          ),
        ),
      );

      expect(find.text('Item test'), findsOneWidget);
      expect(find.text('Description test'), findsOneWidget);
    });

    testWidgets('navigates to AddItemScreen when edit button is pressed',
        (WidgetTester tester) async {
      final item =
          Item(id: '1', name: 'Item test', description: 'Description test');
      final itemProvider = ItemProvider();

      await tester.pumpWidget(
        ChangeNotifierProvider<ItemProvider>(
          create: (_) => itemProvider,
          child: MaterialApp(
            home: ItemTile(item: item, itemProvider: itemProvider),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.edit));
      await tester.pumpAndSettle();

      expect(find.byType(AddItemScreen), findsOneWidget);
    });

    testWidgets('removes item when delete button is pressed',
        (WidgetTester tester) async {
      final itemProvider = ItemProvider();
      itemProvider.items = [
        Item(id: '1', name: 'Item test', description: 'Description test'),
        Item(id: '2', name: 'Item test2', description: 'Description test2'),
      ];

      await tester.pumpWidget(
        ChangeNotifierProvider<ItemProvider>(
          create: (_) => itemProvider,
          child: MaterialApp(
            home: ItemTile(
                item: itemProvider.items[0], itemProvider: itemProvider),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.delete));
      await tester.pumpAndSettle();

      expect(itemProvider.items.length, 1);
    });
  });
}
