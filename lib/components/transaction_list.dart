import 'package:dispesas/models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<TransactionModel> transaction;

  final void Function(String) onRemove;

  TransactionList({this.transaction, this.onRemove});

  @override
  Widget build(BuildContext context) {
    return transaction.isEmpty
        ? Column(
            children: [
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 70, bottom: 20),
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                  height: 150,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Para criar uma novas dispesas use o botão de +',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          )
        : ListView.builder(
            //shrinkWrap: true,
            itemCount: transaction.length,
            itemBuilder: (context, index) {
              final tr = transaction[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                child: ListTile(
                  leading: Container(
                    width: 110,
                    child: FittedBox(
                      child: Text(
                        'R\$ ${tr.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    tr.title,
                    style: TextStyle(fontSize: 17),
                  ),
                  subtitle: Text(
                    DateFormat('d MMM y').format(tr.date),
                    style: TextStyle(color: Colors.grey),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.remove,
                      color: Colors.red,
                    ),
                    onPressed: () => onRemove(tr.id),
                  ),
                ),
              );
            },
          );
  }
}
