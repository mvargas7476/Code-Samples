import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker_app/models/expense.dart';

final formatter = DateFormat.yMd();

class NewExpense extends StatefulWidget{
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;
  
  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  // Have a controller but controllers need to be removed to your class
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  // Here we dispose the controllers so they don't clog up memory
  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day); // today minus a year
    final pickedDate = await showDatePicker(
      context: context, 
      initialDate: now, 
      firstDate: firstDate, 
      lastDate: now
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitEspenseData() {
    // Try parse returns null when text is not a number
    final enteredAmount = double.tryParse(_amountController.text);
    final amountInvalid = (enteredAmount == null || enteredAmount <= 0) ? true : false;

    // Checking that the title and amount are not empty and valid
    if (_titleController.text.trim().isEmpty || amountInvalid || _selectedDate == null) {
      showDialog(context: context, builder: (ctx) => AlertDialog(
        title: const Text('Invalid Input'),
        content: const Text('Please make sure a valid title, amount, and date is entered'),
        actions: [
          TextButton(onPressed: () {
            Navigator.pop(ctx);
          }, child: const Text('Okay'))
        ],
      ));
      return;
    }

    widget.onAddExpense(Expense(
      title: _titleController.text, 
      amount: enteredAmount, 
      date: _selectedDate!,  // The exclamation tells dart that for sure the variable will not be null
      category: _selectedCategory)
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: '\$ ', // Adding the dollar amount
                    label: Text('Amount'),
                  ),
                ),
              ),
              // Here we create our own Datepicker
              const SizedBox(width: 16,),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_selectedDate == null ? 'Select Date' : formatter.format(_selectedDate!)), // The exclamation tells dart that for sure the variable will not be null
                    IconButton(
                      onPressed: _presentDatePicker, 
                      icon: const Icon(Icons.calendar_month)
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 16,),
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: Category.values.map(
                  (category) => DropdownMenuItem(
                    value: category,
                    child: Text(category.name.toUpperCase()),
                  )
                ).toList(),
                onChanged: (value) {
                  if (value == null) {return;}
                  setState(() {
                    _selectedCategory = value;
                  });
                }
              ),
              const Spacer(),
              TextButton(onPressed: () {
                  Navigator.pop(context);
                }, 
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: _submitEspenseData, 
                child: const Text('Save Expense')
              ),
            ],
          ),
        ],
      ),
    );
  }
}