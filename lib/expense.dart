// ignore_for_file: prefer_initializing_formals

class Expense {
  String name = "Expense";
  int amount = 0;
  late String id;
  Expense(String name, int amount, String id) {
    this.name = name;
    this.amount = amount;
    this.id = id;
  }
}
