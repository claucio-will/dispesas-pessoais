import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double price;
  final double percentage;

  ChartBar({this.label, this.price, this.percentage});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 20,
          child: FittedBox(child: Text('${price.toStringAsFixed(2)}'))),
        SizedBox(height: 5),
        Container(
          height: 70,
          width: 10,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20))
                ),
              ),
              FractionallySizedBox(
                heightFactor: percentage,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 5),
        Text(label)
      ],
    );
  }
}
