import 'package:expense_tracker_app/widgets/chart/chart.dart';
import 'package:expense_tracker_app/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses ({super.key});
  
  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }

}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(title: 'Flutter Course', amount: 19.99, date: DateTime.now(), category: Category.work),
    Expense(title: 'Taco Bell', amount: 8.57, date: DateTime.now(), category: Category.food),
    Expense(title: 'Wicked', amount: 30.78, date: DateTime.now(), category: Category.leisure),
    Expense(title: 'Switzerland', amount: 58.61, date: DateTime.now(), category: Category.travel),
  ];

  // This will display the modal . Notice that the context refers to the position of the widget in the tree
  // ctx is the context for the builder function
  void _openAddExpenseOverlay() {
     showModalBottomSheet(
      useSafeArea: true, // This ignores the phones safe area features near the top
      isScrollControlled: true,
      context: context, 
      builder: (ctx) => NewExpense(onAddExpense: _addExpense)
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);

    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: Text('Expense Deleted.'),
        action: SnackBarAction(
          label: 'Undo', 
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          }
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Using this here to make sure that we are checking the width of an appß
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(
      child: Text('No expenses found. Start adding some!'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent =  ExpensesList(expenses: _registeredExpenses, onRemoveExpense: _removeExpense,);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay, 
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      // Notice here we are settin the landscape or portrait mode
      body: width < 600 ? Column(
        children: [
          Chart(expenses: _registeredExpenses),
          Expanded(
            child: mainContent,
          )
        ],
      ) : Row(
        children: [
          Expanded(child: Chart(expenses: _registeredExpenses)),
          Expanded(
            child: mainContent,
          )
        ],
      ), 
    );
  }

}