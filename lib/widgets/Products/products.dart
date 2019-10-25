import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './product_card.dart';
import '../../models/product.dart';
import '../../scoped_models/main.dart';

class Products extends StatelessWidget {


  Widget _buildProductsList(List<Product> products) {
    Widget productsCard;
    if (products.length > 0) {
      productsCard = ListView.builder(
        itemBuilder: (BuildContext context, int index) => ProductCard(products[index], index),
        itemCount: products.length,
      );
    } else {
      productsCard = Center(
        child: Text('No produts Found'),
      );
    }
    return productsCard;
  }

  @override
  Widget build(BuildContext context) {
    print('[Products_Widget] build()');
    return ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget child, MainModel model) {
      return _buildProductsList(model.displayedProducts);
    },); 
  }
  }