import 'package:expense_tracker_app/models/expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registredExpense = [
    Expense(
      title: "Flutter course",
      amount: 23.7,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: "Flutter course",
      amount: 23.7,
      date: DateTime.now(),
      category: Category.work,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("data"),
        actions: const [
          Icon(Icons.add),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(25),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: const ListTile(
                title: Text("Flutter course"),
                subtitle: Text("Price"),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(height: 25),
                    Text("data time"),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
