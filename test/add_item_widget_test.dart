import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:item_tracker/add_item.dart';
import 'package:item_tracker/common/custom_text_field.dart';
import 'package:item_tracker/item_model.dart';
import 'package:item_tracker/item_provider.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('AddItemScreen displays form with name and description fields',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ItemProvider()),
        ],
        child: MaterialApp(
          home: AddItemScreen(),
        ),
      ),
    );

    expect(find.byType(Form), findsOneWidget);
    expect(find.byType(CustomTextField), findsNWidgets(2));
    expect(find.text('Name'), findsOneWidget);
    expect(find.text('Description'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('AddItemScreen displays edit form with pre-filled values',
      (WidgetTester tester) async {
    final item = Item(id: '1', name: 'Recipt', description: 'Check Recipt');

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ItemProvider()),
        ],
        child: MaterialApp(
          home: AddItemScreen(item: item),
        ),
      ),
    );

    expect(find.byType(Form), findsOneWidget);
    expect(find.byType(CustomTextField), findsNWidgets(2));
    expect(find.text('Edit Item'), findsOneWidget);
    expect(find.text('Recipt'), findsOneWidget);
    expect(find.text('Check Recipt'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}
