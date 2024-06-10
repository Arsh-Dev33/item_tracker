import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:item_tracker/common/custom_text_field.dart';
import 'package:item_tracker/item_model.dart';
import 'package:item_tracker/item_provider.dart';
import 'package:provider/provider.dart';

class AddItemScreen extends StatefulWidget {
  final Item? item;

  AddItemScreen({this.item});

  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      _nameController.text = widget.item!.name;
      _descriptionController.text = widget.item!.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: LayoutBuilder(builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        double cardWidth = screenWidth > 600 ? 600 : screenWidth;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Card(
                elevation: 10,
                surfaceTintColor: Colors.white,
                child: SizedBox(
                  width: cardWidth,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30.0, horizontal: 10),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.item != null ? 'Edit Item' : 'Add Item',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          CustomTextField(
                              controller: _nameController,
                              hintText: "Name",
                              checkValidator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a name';
                                }
                                return null;
                              }),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                              controller: _descriptionController,
                              hintText: "Description",
                              checkValidator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a description';
                                }
                                return null;
                              }),
                          const SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: kIsWeb
                                  ? const Size(150, 50)
                                  : const Size(double.infinity, 50),
                              elevation: 5,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Item item = Item(
                                  id: widget.item != null
                                      ? widget.item!.id
                                      : DateTime.now()
                                          .millisecondsSinceEpoch
                                          .toString(),
                                  name: _nameController.text,
                                  description: _descriptionController.text,
                                );
                                if (widget.item != null) {
                                  Provider.of<ItemProvider>(context,
                                          listen: false)
                                      .editItem(item);
                                } else {
                                  Provider.of<ItemProvider>(context,
                                          listen: false)
                                      .addItem(item);
                                }
                                Navigator.pop(context);
                              }
                            },
                            child: Text(widget.item != null
                                ? 'Save Changes'
                                : 'Add Item'),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
