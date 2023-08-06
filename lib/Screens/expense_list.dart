// ignore_for_file: unused_element, unused_local_variable

import 'package:flutter/material.dart';
import 'package:my_budget_app/database.dart';
import 'package:my_budget_app/item_list.dart';
import 'package:my_budget_app/item_list_total.dart';

class ExpenseList extends StatefulWidget {
  const ExpenseList({super.key});

  @override
  State<ExpenseList> createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
  FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          "Budget Tracker",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
            onPressed: () => {Navigator.pop(context)},
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Column(
        children: [
          ItemsListTotal(),
          Expanded(
            child: ItemsList(),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String? name;
          int? amount;

          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Add Expense'),
                content: Form(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        onChanged: (value) {
                          name = value;
                        },
                        decoration:
                            const InputDecoration(labelText: 'Expense Name'),
                      ),
                      TextFormField(
                        onChanged: (value) {
                          amount = int.tryParse(value) ?? 0;
                        },
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: 'Amount'),
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      if (name != null && amount != null) {
                        setState(() {
                          firestoreService.addExpense(name!, amount!);
                        });
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text('Save'),
                  ),
                ],
              );
            },
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}
