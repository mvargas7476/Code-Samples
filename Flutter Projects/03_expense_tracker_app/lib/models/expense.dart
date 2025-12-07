import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

// Adding the uuid for the id of my items
const uuid = Uuid();
// Adding a formatter for the date
final formatter = DateFormat.yMd();

// Enums just allows for the use of a special type of list
enum Category {food, travel, leisure, work}

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work
};

class Expense {
  // Note that the id is not passed in the constructor but assigned after using the : notation
  Expense({
    required this.title, 
    required this.amount, 
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  // This is just a getter special function. Normally. this would be a getFormattedDate function
  // However is is much easier because then we can just call this as expense.formattedDate and it'll work
  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenses});

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category) 
    : expenses = allExpenses.where( (expense) => expense.category == category).toList();
  
  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;

    for(final expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }

}