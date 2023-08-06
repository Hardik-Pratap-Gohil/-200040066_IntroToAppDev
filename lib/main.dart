// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:my_budget_app/Screens/expense_list.dart';
import 'package:my_budget_app/firebase_options.dart';
import 'package:my_budget_app/sign_in.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MaterialApp(
      initialRoute: "/auth",
      routes: {
        "/auth": (context) => const AuthPage(),
        "/expense": (context) => const ExpenseList()
      },
    ),
  );
}
