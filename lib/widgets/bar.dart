import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Bar extends StatelessWidget{
  final String label;
  final double spent;
  final double percent;

  Bar(this.label, this.spent, this.percent);

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(builder: (ctx, constraints){

      return Column(children: <Widget>[
        SizedBox(height: constraints.maxHeight*0.04),
        Container(
          height: constraints.maxHeight*0.145,
          child: FittedBox
            (child: Text('\$${spent.toStringAsFixed(0)}')),
        ),
        SizedBox(
          height: constraints.maxHeight*0.04,
        ),
        Container(
          height: constraints.maxHeight*0.575,
          width: 10,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black38, width: 1),
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: percent,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

              )
            ],
          ),
        ),
        SizedBox(
          height: constraints.maxHeight*0.04,
        ),
        Container(
            height: constraints.maxHeight*0.12,
            child: FittedBox(child: Text(label))),
        SizedBox(
            height: constraints.maxHeight*0.04
        ),
      ],);
    },);
  }
}



