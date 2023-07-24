// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables, override_on_non_overriding_member, unused_local_variable

import 'package:flutter/material.dart';
import 'package:my_budget_app/expense_card.dart';
import 'package:my_budget_app/expense.dart';
import 'package:my_budget_app/Screens/expense_list.dart';
import 'package:provider/provider.dart';
import 'package:my_budget_app/expense_list model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
          leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
        ),
        body: Column(
          children: [
            IconButton(
              onPressed: () => {},
              icon: Icon(Icons.person_2_rounded),
              color: Colors.white,
              iconSize: 200,
            ),
            Text(
              "Welcome",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                letterSpacing: 2,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Back!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                letterSpacing: 2,
              ),
            ),
            SizedBox(height: 80),
            Center(
              child: Card(
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
                          onPressed: () =>
                              {Navigator.pushNamed(context, '/expense')},
                          icon: Icon(Icons.arrow_drop_down))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
