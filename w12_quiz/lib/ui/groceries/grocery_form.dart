import 'package:flutter/material.dart';
import '../../models/grocery.dart';

class GoceryForm extends StatefulWidget {
  const GoceryForm({super.key});

  @override
  State<GoceryForm> createState() {
    return _GoceryFormState();
  }
}

class _GoceryFormState extends State<GoceryForm> {
  // Default settings
  static const defautName = "New grocery";
  static const defaultQuantity = 1;
  static const defaultCategory = GroceryCategory.fruit;

  // Inputs
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();
  GroceryCategory _selectedCategory = defaultCategory;

  @override
  void initState() {
    super.initState();

    // Initialize intputs with default settings
    _nameController.text = defautName;
    _quantityController.text = defaultQuantity.toString();
  }

  @override
  void dispose() {
    super.dispose();

    // Dispose the controlers
    _nameController.dispose();
    _quantityController.dispose();
  }

  void onReset() {
    // Will be implemented later - Reset all fields to the initial values
  }

  void onAdd() {
    // Will be implemented later - Create and return the new grocery
    final enteredName = _nameController.text.trim();
    final enteredQuantity = int.tryParse(_quantityController.text) ?? 1;
    final newGrocery = Grocery(
      name: enteredName.isEmpty ? defautName : enteredName,
      quantity: enteredQuantity,
      category: _selectedCategory,
      id: '',
    );
    Navigator.of(context).pop(newGrocery);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add a new item')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              maxLength: 50,
              decoration: const InputDecoration(label: Text('Name')),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextField(
                    controller: _quantityController,
                    decoration: const InputDecoration(label: Text('Quantity')),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButtonFormField<GroceryCategory>(
                    initialValue: _selectedCategory,
                    decoration: const InputDecoration(label: Text('Category')),
                    items: GroceryCategory.values.map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Row(
                          children: [
                            Container(
                              width: 15,
                              height: 15,
                              color: category.color,
                            ),
                            const SizedBox(width: 8),
                            Text(category.name),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _selectedCategory = value;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: onReset, child: const Text('Reset')),
                ElevatedButton(onPressed: onAdd, child: const Text('Add Item')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
