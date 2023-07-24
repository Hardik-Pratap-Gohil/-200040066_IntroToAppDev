// ignore_for_file: unused_import, file_names

import 'package:flutter/foundation.dart';
import 'expense.dart';

class ExpenseListModel with ChangeNotifier {
  final List<Expense> _expenseList = [
    Expense("Salary", 50000),
    Expense("Fees", -22500)
  ];

  List<Expense> get expenseList => _expenseList;

  void addExpense(Expense expense) {
    _expenseList.add(expense);
    notifyListeners();
  }

  void deleteExpense(Expense expense){
    _expenseList.remove(expense);
    notifyListeners();
  // Add any other methods to modify the expenseList as needed
}
