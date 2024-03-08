import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/widgets/new_item.dart';
import 'package:http/http.dart' as http;

class GroceriesScreen extends StatefulWidget {
  const GroceriesScreen({super.key});

  @override
  State<GroceriesScreen> createState() => _GroceriesScreenState();
}

class _GroceriesScreenState extends State<GroceriesScreen> {
  List<GroceryItem> _groceryItems = [];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _loadItem();
  }

  void _loadItem() async {
    try {
      final url = Uri.https('calm-seeker-348402-default-rtdb.firebaseio.com',
          'shopping-list.json');
      final response = await http.get(url);

      final Map<String, dynamic>? dataList = json.decode(response.body);

      final List<GroceryItem> loadedItems = [];

      if (dataList == null) {
        return;
      }

      for (var item in dataList.entries) {
        final category = categories.entries
            .firstWhere(
                (catItem) => catItem.value.title == item.value['category'])
            .value;

        loadedItems.add(
          GroceryItem(
            id: item.key,
            name: item.value['name'],
            quantity: item.value['quantity'],
            category: category,
          ),
        );
      }

      setState(() {
        _groceryItems = loadedItems;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = 'Failed to fetch data. Please try again later';
      });
    }
  }

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

  void _removeItem(GroceryItem item) async {
    final groceryIndex = _groceryItems.indexOf(item);
    bool undoItem = false;

    setState(() {
      _groceryItems.remove(item);
    });

    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 5),
        content: const Text("Grocery deleted!"),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            undoItem = true;
            _removeItemFromDataBase(undoItem, item);

            setState(() {
              _groceryItems.insert(groceryIndex, item);
            });
          },
        ),
      ),
    );

    Future.delayed(const Duration(seconds: 7), () {
      _removeItemFromDataBase(undoItem, item);
    });
  }

  void _removeItemFromDataBase(bool undoItem, GroceryItem item) async {
    if (!undoItem) {
      final url = Uri.https('calm-seeker-348402-default-rtdb.firebaseio.com',
          'shopping-list/${item.id}.json');

      final response = await http.delete(url);

      if (response.statusCode >= 400) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: CircularProgressIndicator());

    if (error != null) {
      content = Center(child: Text(error!));
    }

    if (!isLoading) {
      if (_groceryItems.isNotEmpty) {
        content = ListView.builder(
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
        );
      } else {
        content = const Center(
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
        );
      }
    }

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
      body: content,
    );
  }
}
