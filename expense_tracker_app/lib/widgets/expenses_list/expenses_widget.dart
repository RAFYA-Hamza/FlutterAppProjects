import 'package:expense_tracker_app/models/expense.dart';
import 'package:flutter/material.dart';

class ExpensesWidget extends StatelessWidget {
  const ExpensesWidget({
    required this.expense,
    required this.onRemoveExpense,
    super.key,
  });
  final List<Expense> expense;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expense.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: ValueKey(expense[index]),
          onDismissed: (direction) {
            onRemoveExpense(expense[index]);
          },
          child: Card(
            child: ListTile(
              title: Text(
                expense[index].title,
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
              subtitle: Text(
                '\$ ${expense[index].amount.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(height: 25),
                  SizedBox(
                    width: 90,
                    child: Row(
                      children: [
                        Icon(categoryIcons[expense[index].category]),
                        const SizedBox(width: 8),
                        Text(
                          expense[index].formattedDate,
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
