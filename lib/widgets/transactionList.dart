
import 'package:expense/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget{
  final List<Transaction> transaction;
  final Function deleteTransaction;
  TransactionList(this.transaction, this.deleteTransaction);
  @override
  Widget build(BuildContext context) {

    return transaction.isEmpty ?
          Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Text("No transaction added yet..!", style: TextStyle(
                fontSize: 20
              ),),

            ],
          )
       : ListView(
      children: transaction.map((tx) {
      return Card(
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            child: Padding
              (
                padding: EdgeInsets.all(5),
                child: FittedBox(
                  child: Text('\$${tx.value.toStringAsFixed(1)}'),
                ),
            ),
        ),
        title: Text('${tx.title}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
          subtitle: Text(DateFormat().format(tx.date), style: TextStyle(color: Colors.black38),),
          trailing:
          MediaQuery.of(context).size.width > 500 ?
          FlatButton.icon(
              onPressed: () {
                deleteTransaction(tx.id);
                },
              icon: Icon(Icons.delete),
              label: Text('Delete!'),
              textColor: Colors.deepOrangeAccent,
          ) :
          IconButton(
            icon: Icon(Icons.delete),
            color: Colors.deepOrangeAccent,
            onPressed: (){
              deleteTransaction(tx.id);
            },
          ),
        ),
      );
    }).toList(),
    );
  }
}