import 'dart:math';
import 'package:flutter/material.dart';
import 'package:item_tracker/add_item.dart';
import 'package:item_tracker/item_model.dart';
import 'package:item_tracker/item_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart'; // Add this import

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Item Tracker',
          style: TextStyle(
            fontSize: kIsWeb ? 24 : 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Consumer<ItemProvider>(
        builder: (context, itemProvider, child) {
          if (itemProvider.items.isEmpty) {
            return const Center(
              child: Text(
                "No Items Added",
                style: TextStyle(
                  fontSize: kIsWeb ? 24 : 18,
                ),
              ),
            );
          } else {
            return kIsWeb
                ? GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, childAspectRatio: 2.8),
                    itemCount: itemProvider.items.length,
                    itemBuilder: (context, index) {
                      Item item = itemProvider.items[index];
                      return ItemTile(
                        item: item,
                        itemProvider: itemProvider,
                      );
                    },
                  )
                : ListView.builder(
                    itemCount: itemProvider.items.length,
                    itemBuilder: (context, index) {
                      Item item = itemProvider.items[index];
                      return ItemTile(
                        item: item,
                        itemProvider: itemProvider,
                      );
                    },
                  );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddItemScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ItemTile extends StatelessWidget {
  final ItemProvider itemProvider;
  final GlobalKey _cardKey = GlobalKey();

  ItemTile({super.key, required this.item, required this.itemProvider});

  final Item item;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox renderBox =
          _cardKey.currentContext!.findRenderObject() as RenderBox;
      final size = renderBox.size;
      final position = renderBox.localToGlobal(Offset.zero);

      print("Size: $size, Position: $position");
    });

    return Card(
      key: _cardKey,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.name.toUpperCase(),
              style: const TextStyle(
                fontSize: kIsWeb ? 20 : 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              item.description,
              style: const TextStyle(
                fontSize: kIsWeb ? 18 : 14,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddItemScreen(item: item)),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    itemProvider.removeItem(item.id);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
