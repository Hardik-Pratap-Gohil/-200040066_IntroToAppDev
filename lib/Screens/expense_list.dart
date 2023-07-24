// ignore_for_file: unused_import, unused_local_variable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my_budget_app/expense.dart';
import 'package:my_budget_app/expense_card.dart';
import 'package:provider/provider.dart';
import 'package:my_budget_app/expense_list model.dart';

class ExpenseList extends StatefulWidget {
  const ExpenseList({super.key});

  @override
  State<ExpenseList> createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
  @override
  Widget build(BuildContext context) {
    final expenseListModel = Provider.of<ExpenseListModel>(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(200, 0, 0, 0),
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          "Budget Tracker",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
            onPressed: () => {Navigator.pop(context)},
            icon: Icon(Icons.arrow_back)),
      ),
      body: Center(
        child: Column(children: [
          SizedBox(
            height: 75,
          ),
          Card(
            child: Container(
              margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              width: 400,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total:",
                    style: TextStyle(fontSize: 24),
                  ),
                  Text(
                    '${expenseListModel.expenseList.fold(0, (previousValue, item) => previousValue + item.amount)}',
                    style: TextStyle(fontSize: 24),
                  ),
                  IconButton(
                      iconSize: 24,
                      color: Colors.black,
                      onPressed: () => {},
                      icon: Icon(Icons.arrow_drop_down))
                ],
              ),
            ),
          ),
          SizedBox(height: 50),
          Column(
            children: expenseListModel.expenseList
                .map((e) => ExpenseCard(expense: e))
                .toList(),
          )
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String? name;
          int? amount;

          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Add Expense'),
                content: Form(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        onChanged: (value) {
                          name = value;
                        },
                        decoration: InputDecoration(labelText: 'Expense Name'),
                      ),
                      TextFormField(
                        onChanged: (value) {
                          amount = int.tryParse(value) ?? 0;
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: 'Amount'),
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      if (name != null && amount != null) {
                        setState(() {
                          expenseListModel.addExpense(Expense(name!, amount!));
                        });
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text('Save'),
                  ),
                ],
              );
            },
          );
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
      ),
    );
  }
}
