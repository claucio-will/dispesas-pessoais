import 'dart:math';

import 'package:dispesas/components/chart_component.dart';
import 'package:dispesas/components/transaction_form.dart';
import 'package:dispesas/components/transaction_list.dart';
import 'package:dispesas/models/transaction_model.dart';
import 'package:dispesas/theme/theme_app.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<TransactionModel> _transaction = [];

  List<TransactionModel> get _recentTrasaction {
    return _transaction.where((tr) {
      return tr.date.isAfter(
        DateTime.now().subtract(Duration(days: 7)),
      );
    }).toList();
  }

  void _addTransaction(String title, double price, DateTime date) {
    final newTransaction = TransactionModel(
        id: Random().nextDouble().toString(),
        title: title,
        price: price,
        date: date);
    setState(() {
      _transaction.add(newTransaction);
    });
    Navigator.of(context).pop();
  }

  void _removeTrasaction(String id) {
    setState(() {
      _transaction.removeWhere((element) => element.id == id);
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (_) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: TransactionForm(_addTransaction),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 50, left: 20, bottom: 20),
            width: double.infinity,
            child: Text(
              'Dispesas Pessoais',
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ChartComponent(_recentTrasaction),
          Expanded(
            child: TransactionList(
              transaction: _transaction,
              onRemove: _removeTrasaction,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ThemeApp.colorPrimary,
        onPressed: () => _openTransactionFormModal(context),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
