// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, unused_import

import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_budget_app/expense.dart';

class FirestoreService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final String _userUid;
  FirestoreService() {
    // Get the current user UID when the service is instantiated
    _userUid = _auth.currentUser!.uid;
  }
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('users');

  Future<void> addExpense(String name, int amount) async {
    try {
      await _collection.doc(_userUid).collection('expenses').add({
        'name': name,
        'amount': amount,
      });
    } catch (e) {
      // Handle the error
      print("Error adding item: $e");
    }
  }

  Future<void> deleteExpense(String expenseId) async {
    try {
      await _collection
          .doc(_userUid)
          .collection('expenses')
          .doc(expenseId)
          .delete();
    } catch (e) {
      // Handle the error
      print("Error deleting expense: $e");
    }
  }

  Stream<List<Expense>> getItems() {
    return _collection
        .doc(_userUid)
        .collection("expenses")
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Expense(doc['name'], doc['amount'], doc.id);
      }).toList();
    });
  }

  Stream<int> getTotalAmountStream(Stream<List<Expense>> itemsStream) {
    return itemsStream.map((expensesList) {
      int totalAmount = expensesList.fold(
          0, (previousValue, item) => previousValue + item.amount);
      return totalAmount;
    });
  }
}
