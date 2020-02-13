import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:expense/widgets/newTransaction.dart';
import './models/transaction.dart';
import './widgets/transactionList.dart';
import './widgets/newTransaction.dart';
import './widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.deepOrangeAccent,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  bool showChart = false;
  final List<Transaction> transaction = [];
  List<Transaction> get recentTx {
    return transaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),),
      );
    }).toList();
  }

  void addTransaction(String txTitle, double txAmount, DateTime date){
    final newtx = Transaction(
        title: txTitle,
        value: txAmount,
        id: DateTime.now().toString(),
        date: date
    );
    setState((){
      transaction.add(newtx);
    });
  }

  void deleteTransaction(String id){
    setState(() {
      transaction.removeWhere((tx){
        return tx.id == id;
      });
    });
  }

  void startNewTransaction(BuildContext context) {
    showModalBottomSheet(context: context, builder: (_) {
      return GestureDetector(
        onTap: (){},
        child: NewTransaction(addTransaction),
        behavior: HitTestBehavior.opaque,
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    final appBar = AppBar(
      title: Text('Expense List'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => startNewTransaction(context),
        )
      ],
    );

    final txList =  Container(
        height: (mediaQuery.size.height-appBar.preferredSize.height - mediaQuery.padding.top)*0.725,
        child: TransactionList(transaction, deleteTransaction));

    return Scaffold(
      appBar: appBar,
      body: SafeArea(child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if(isLandscape)  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Show Chart!',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),
          ),
          Switch.adaptive(
            activeColor: Theme.of(context).accentColor,
            value: showChart, onChanged: (val){
            setState(() {
              showChart = val;
            });
          },)
        ],
      ),
            if (!isLandscape) Container(
              height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top)*0.25,
              child: Chart(recentTx),
            ),
            if(!isLandscape) txList,

            if(isLandscape) showChart ?
              Container(
                height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top)*0.75,
                child: Chart(recentTx))
            : txList

          ],
        ),
      ),
    ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS ? Container():
      FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => startNewTransaction(context),
      ),
    );
  }
}