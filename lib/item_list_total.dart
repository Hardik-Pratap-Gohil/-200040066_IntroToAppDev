import 'package:flutter/material.dart';
import 'expense.dart';
import 'database.dart';
// Your existing Expense class and getItems() function
// ...

class ItemsListTotal extends StatefulWidget {
  @override
  _ItemsListState createState() => _ItemsListState();
}

class _ItemsListState extends State<ItemsListTotal> {
  FirestoreService firestoreService = FirestoreService();
  late Stream<int> totalAmountStream;

  @override
  void initState() {
    super.initState();
    totalAmountStream =
        firestoreService.getTotalAmountStream(firestoreService.getItems());
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Expense>>(
      stream: firestoreService.getItems(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Expense> itemList = snapshot.data!;
          return StreamBuilder<int>(
            stream: totalAmountStream,
            builder: (context, totalAmountSnapshot) {
              int totalAmount = totalAmountSnapshot.data ?? 0;

              // Build the Column widget with the list of items and the total amount
              return Container(
                color: Colors.white,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        "Total:",
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        '$totalAmount',
                        style: const TextStyle(
                          fontSize: 24,
                        ),
                      ),
                      IconButton(
                          iconSize: 24,
                          color: Colors.black,
                          onPressed: () =>
                              {Navigator.pushNamed(context, '/expense')},
                          icon: const Icon(Icons.arrow_drop_down))
                    ],
                  ),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
