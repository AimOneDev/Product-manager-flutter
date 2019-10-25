import 'package:flutter/material.dart';


class PriceTag extends StatelessWidget {

  final String price;

  PriceTag(this.price);

  @override
  Widget build(BuildContext context) {
    
    return  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Theme.of(context).accentColor,
                    ),
                    child: Text(' \$ $price',
                        style: TextStyle(color: Colors.grey)),
                  );
  }
}