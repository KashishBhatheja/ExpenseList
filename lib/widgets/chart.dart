import 'package:expense/models/transaction.dart';
import 'package:expense/widgets/bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> rececntTx;
  Chart(this.rececntTx);

  List<Map<String,Object>> get weeklyTransaction{
    return List.generate(7, (index){
      final weekDays = DateTime.now().subtract(Duration(days: index),);
      double total = 0;
      for (var i = 0; i< rececntTx.length; i++ ){
        if(
          rececntTx[i].date.day == weekDays.day &&
            rececntTx[i].date.month == weekDays.month &&
            rececntTx[i].date.year == weekDays.year
        ){
          total = total + rececntTx[i].value;
        }

      }
      return{
        'day': DateFormat.E().format(weekDays).substring(0,1), 'amount': total,
      };
    }).reversed.toList();
  }
  double get weeklySpending{
    return weeklyTransaction.fold(0.0, (sum, item){
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: weeklyTransaction.map((data){
          return Flexible(
            fit: FlexFit.tight,
            child: Bar(
                data['day'],
                data['amount'],
                weeklySpending == 0.0 ? 0.0 : (data['amount'] as double)/weeklySpending),
          );
          }
        ).toList()
      ),
    );
  }
}