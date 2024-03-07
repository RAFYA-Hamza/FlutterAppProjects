import 'package:flutter/material.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/widgets/new_item.dart';
import 'package:http/http.dart' as http;

class GroceriesScreen extends StatefulWidget {
  const GroceriesScreen({super.key});

  @override
  State<GroceriesScreen> createState() => _GroceriesScreenState();
}

class _GroceriesScreenState extends State<GroceriesScreen> {
  final List<GroceryItem> _groceryItems = [];

  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (context) {
          return const NewItem();
        },
      ),
    );

    if (newItem == null) {
      return;
    }

    setState(() {
      _groceryItems.add(newItem);
    });
  }

  void _removeItem(GroceryItem newItem) {
    setState(() {
      _groceryItems.remove(newItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Groceries',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: _groceryItems.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "No Item add yet!",
                  ),
                  Text(
                    "Click on add buttun to add some items.",
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _groceryItems.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: ValueKey(_groceryItems[index]),
                  background: Container(
                    color: Colors.amber,
                  ),
                  child: ListTile(
                    leading: Container(
                      height: 24,
                      width: 24,
                      color: _groceryItems[index].category.color,
                    ),
                    title: Text(
                      _groceryItems[index].name,
                    ),
                    trailing: Text(
                      _groceryItems[index].quantity.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  onDismissed: (direction) {
                    _removeItem(_groceryItems[index]);
                  },
                );
              },
            ),
    );
  }
}
