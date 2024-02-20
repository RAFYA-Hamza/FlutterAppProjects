import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/widgets/expenses_list/expenses_widget.dart';
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
      title: "USA",
      amount: 25.9,
      date: DateTime.now(),
      category: Category.travel,
    ),
    Expense(
      title: "Burger",
      amount: 29.8,
      date: DateTime.now(),
      category: Category.food,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Flutter Expense Tracker",
          style: TextStyle(
            fontSize: 12,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 100,
            color: Colors.amber,
          ),
          Expanded(
            child: ExpensesWidget(
              expense: _registredExpense,
            ),
          ),
        ],
      ),
    );
  }
}
