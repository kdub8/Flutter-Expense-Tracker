import 'package:expense_tracker_app/data/expense_data.dart';
import 'package:expense_tracker_app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async {
  //initialize hive
  await Hive.initFlutter();
  //open hive box
  await Hive.openBox("expense_database");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExpenseData(),
      builder: (context, child) => const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}

//HIVE DATABASE IS NOT WORKING
//STILL NEED TO FIGURE OUT HOW TO FIX WHEN HOT RELOADING AND REOPENING THE APP, IT JUST IS NOT SAVING