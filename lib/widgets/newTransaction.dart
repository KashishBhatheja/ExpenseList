
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget{

  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime selectedDate;

  void submit(){
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    if(amountController.text.isEmpty){
      return;
    }
    if(enteredTitle.isEmpty || enteredAmount <= 0 || selectedDate == null){
      return;
    }
    widget.addTx(enteredTitle, enteredAmount, selectedDate);
    Navigator.of(context).pop();
  }

  void datePicker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime.now()
    ).then((date) {
      if (date == null) {
        return;
      }
      else {
        setState(() {
          selectedDate = date;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  SingleChildScrollView(
      child: Card(
      child: Container(
        padding: EdgeInsets.only(
            top: 15,
            left: 15,
            right: 15,
            bottom: MediaQuery.of(context).viewInsets.bottom + 15
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration:
              InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => submit(),
            ),
            TextField(
              decoration:
              InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_)  => submit(),
            ),
            Container(
              height: 80,
              child: Row(
                children: <Widget>[
                  Text(selectedDate == null ? 'No Date Choosen!' : 'Picked Date: ${DateFormat.yMd().format(selectedDate)}'),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text('Choose Date', style: TextStyle(fontWeight: FontWeight.bold),),
                    onPressed: datePicker,
                  )
                ],
              ),
            ),
            RaisedButton(child: Text('Add Transaction'),
              textColor: Colors.white,
              color: Theme.of(context).primaryColor,
              onPressed: submit,
            ),
          ],
        ),
      ),
    )
    );
  }
}