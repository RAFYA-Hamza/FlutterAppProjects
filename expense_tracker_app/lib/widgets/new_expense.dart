import 'package:expense_tracker_app/models/expense.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({required this.onAddExpense, super.key});
  final void Function(Expense newElement) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedTime;
  Category _selectedCategory = Category.food;

  bool isValidateTitle = true;
  bool isValidateAmount = true;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );

    setState(() {
      _selectedTime = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);

    _checkSubmitAmount(enteredAmount.toString());
    _checkSubmitTitle(_titleController.text);

    if (!isValidateTitle || !isValidateAmount || _selectedTime == null) {
      // do something

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Input data invalid"),
            content: const Text(
                "Please make sure a valid title, amount, date and category was entered"),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Ok"),
              )
            ],
          );
        },
      );
      return;
    }

    widget.onAddExpense(
      Expense(
        title: _titleController.text,
        amount: enteredAmount!,
        date: _selectedTime as DateTime,
        category: _selectedCategory,
      ),
    );

    Navigator.of(context).pop();
  }

  void _checkSubmitTitle(String titleTaped) {
    bool isAlphabetic = RegExp(r'^[a-zA-Z\s1-9]+$').hasMatch(titleTaped);

    setState(() {
      if (isAlphabetic && _titleController.text.trim().isNotEmpty) {
        isValidateTitle = true;
      } else {
        isValidateTitle = false;
      }
    });
  }

  void _checkSubmitAmount(String amountTaped) {
    bool isNumber = RegExp(r'^[0.0-9.0]+$').hasMatch(amountTaped);

    final amountValidation = double.tryParse(amountTaped);
    final amountIsValid = amountValidation == null || amountValidation <= 0;

    setState(() {
      if (isNumber && !amountIsValid) {
        isValidateAmount = true;
      } else {
        isValidateAmount = false;
      }
    });
  }

  // the second method to save a user input text for the textField

  // void _saveTitleInput(String inputValue) {
  //   _entredTitle = inputValue;
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            onSubmitted: _checkSubmitTitle,
            maxLength: 50,
            decoration: InputDecoration(
              label: const Text("Title"),
              errorText: isValidateTitle == false
                  ? "Please enter a valid title."
                  : null,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextField(
                  onSubmitted: _checkSubmitAmount,
                  // onEditingComplete: _checkSubmitAmount,
                  controller: _amountController,
                  decoration: InputDecoration(
                    errorText: isValidateAmount == false
                        ? "Please enter a valid amount"
                        : null,
                    prefixText: "\$ ",
                    label: const Text("Amount"),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      _selectedTime == null
                          ? "No date selected"
                          : formatter.format(_selectedTime!),
                    ),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(Icons.date_range_outlined),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 60),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: Category.values.map((category) {
                  return DropdownMenuItem<Category>(
                    value: category,
                    child: Text(category.name.toUpperCase()),
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
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Cancel"),
                  ),
                  ElevatedButton(
                    onPressed: _submitExpenseData,
                    child: const Text("Save Expense"),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
