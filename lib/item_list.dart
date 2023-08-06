import 'package:flutter/material.dart';
import 'package:my_budget_app/expense.dart';
import 'package:my_budget_app/database.dart';

class ItemsList extends StatefulWidget {
  @override
  State<ItemsList> createState() => _ItemsListState();
}

class _ItemsListState extends State<ItemsList> {
  @override
  Widget build(BuildContext context) {
    FirestoreService firestoreService = FirestoreService();
    return StreamBuilder<List<Expense>>(
      stream: firestoreService.getItems(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Expense> itemList = snapshot.data!;
          return ListView.builder(
            itemCount: itemList.length,
            itemBuilder: (context, index) {
              Expense expense = itemList[index];
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                margin: EdgeInsets.fromLTRB(65, 30, 65, 0),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(expense.name),
                      Text('${expense.amount}'),
                      IconButton(
                          onPressed: () async {
                            await firestoreService.deleteExpense(expense.id);
                          },
                          icon: const Icon(Icons.delete))
                    ],
                  ),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          print('${snapshot.error}');
          return Text('Error: ${snapshot.error}');
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
