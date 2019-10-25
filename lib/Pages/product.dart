import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:async';
import '../models/product.dart';
import '../scoped_models/main.dart';

class ProductPage extends StatelessWidget {
  final Product product;

  ProductPage(this.product);

  // _showWarningDialog(BuildContext context) {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         //adding a dialog
  //         return AlertDialog(
  //           title: Text('Are you sure ?'),
  //           content: Text('this action cannot be undone'),
  //           actions: <Widget>[
  //             FlatButton(
  //               child: Text('DISCARD'),
  //               onPressed: () {
  //                 Navigator.pop(context);
  //               },
  //             ),
  //             FlatButton(
  //               child: Text('DELETE'),
  //               onPressed: () {
  //                 Navigator.pop(context);
  //                 Navigator.pop(context, true);
  //               },
  //             ),
  //           ],
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        print('back button pressed');
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Product Detail'),
        ),
        body: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              FadeInImage(
                image: NetworkImage(product.image),
                height: 300.0,
                fit: BoxFit.cover,
                placeholder: AssetImage('assets/food.jpg'),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Text(product.title),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Text(product.description),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//RaisedButton(
//   color: Theme.of(context).primaryColor,
//   child: Text('DELETE'),
//   onPressed: () => _showWarningDialog(context)
// ),
// ),

//RaisedButton(
//   color: Theme.of(context).primaryColor,
//   child: Text('DELETE'),
//   onPressed: () => _showWarningDialog(context)
// ),
// ),
