// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_budget_app/database.dart';
import 'package:my_budget_app/item_list.dart';
import 'package:my_budget_app/item_list_total.dart';
import 'package:my_budget_app/expense.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirestoreService firestoreService = FirestoreService();
  ItemsList expenseList = ItemsList();

  void signUserOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Budget Tracker",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                color: Colors.green[300],
                child: TextButton(
                    onPressed: signUserOut,
                    child: Text(
                      "Sign out",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    )),
              ),
            ],
          ),
          leading:
              IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back)),
        ),
        body: Column(
          children: [
            IconButton(
              onPressed: () => {},
              icon: const Icon(Icons.person_2_rounded),
              color: Colors.white,
              iconSize: 200,
            ),
            const Text(
              "Welcome",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Back!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 80),
            Center(
              child: Card(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  width: 400,
                  child: ItemsListTotal(),
                ),
              ),
            ),
          ],
        ));
  }
}
