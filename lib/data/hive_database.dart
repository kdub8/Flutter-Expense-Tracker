import 'package:expense_tracker_app/models/expense_item.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveDataBase {
  //reference our box
  final _myBox = Hive.box("expense_database");

  //write data
  void saveData(List<ExpenseItem> allExpense) {
    /**
   * Hive can only store strings and dateTime,and not custom objects like expenseitem
   * convert expenseitem objects to types that can be stored
   * 
   * allExpense = 
   * [
   * ExpenseItem (name / amount / dateTime
   * ..
   * )]
   * 
   * -->
   * 
   * [ name, amount, dateTime
   * ..
   * ]
   */

    List<List<dynamic>> allExpensesFormatted = [];

    for (var expense in allExpense) {
      //convert each expenseitem into  list of storable types
      List<dynamic> expenseFormatted = [
        expense.name,
        expense.amount,
        expense.dateTime,
      ];
      allExpensesFormatted.add(expenseFormatted);
    }

    //finallyl lets store in our database
    _myBox.put("ALL EXPENSES", allExpensesFormatted);
  }

  //read data
  List<ExpenseItem> readData() {
    /**
     * Data is stored in hive as a list of strings + datetime
     * so lets convert our saved data into expenseitem objects
     * 
     * savedData = 
     * 
     * [
     * 
     * [name, amount, datetime],
     * ..
     * 
     * ]
     * 
     * ->
     * 
     * [
     * 
     * ExpenseItem (name / amount / datetime),
     * ..
     * 
     * ]
     */

    List savedExpenses = _myBox.get("ALL_EXPENSES") ?? [];
    List<ExpenseItem> allExpenses = [];

    for (int i = 0; i < savedExpenses.length; i++) {
      // collect individual expense data
      String name = savedExpenses[i][0];
      String amount = savedExpenses[i][1];
      DateTime dateTime = savedExpenses[i][2];
      //create expense item

      ExpenseItem expense =
          ExpenseItem(amount: amount, dateTime: dateTime, name: name);

      //add expense to overall list of expenses
      allExpenses.add(expense);
    }

    return allExpenses;
  }
}
