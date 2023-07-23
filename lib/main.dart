// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'package:flutter/material.dart';
import 'package:my_budget_app/Screens/home.dart';
import 'package:my_budget_app/Screens/expense_list.dart';
import 'expense.dart';
import 'expense_card.dart';
import 'package:provider/provider.dart';
import 'package:my_budget_app/expense_list model.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => ExpenseListModel(),
    child: MaterialApp(
      home: Home(),
      routes: {
        '/expense': (context) => ExpenseList(),
      },
    ),
  ));
}
