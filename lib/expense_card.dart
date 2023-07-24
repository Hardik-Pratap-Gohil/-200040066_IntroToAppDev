// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, unused_import, prefer_initializing_formals, annotate_overrides, use_key_in_widget_constructors, file_names, must_be_immutable, unused_local_variable

import 'package:flutter/material.dart';
import 'expense.dart';
import 'package:provider/provider.dart';
import 'package:my_budget_app/expense_list model.dart';

class ExpenseCard extends StatefulWidget {
  Expense expense;
  ExpenseCard({required this.expense});

  @override
  State<ExpenseCard> createState() => _ExpenseCardState();
}

class _ExpenseCardState extends State<ExpenseCard> {
  Widget build(BuildContext context) {
    final expenseListModel = Provider.of<ExpenseListModel>(context);
    return Card(
        color: Colors.white,
        margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: FractionallySizedBox(
          widthFactor: 0.8,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Text(
              widget.expense.name,
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            Text(
              '${widget.expense.amount}',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            IconButton(
                onPressed: () => {
                      setState(() {
                         expenseListModel.deleteExpense(widget.expense);
                      })
                    },
                icon: Icon(Icons.delete))
          ]),
        ));
  }
}
