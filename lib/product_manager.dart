import 'package:flutter/material.dart'; // we dont need u brother

import './widgets/Products/products.dart';
import 'models/product.dart';
//import './product_control.dart';

class ProductManager extends StatelessWidget {
  final List<Product> products;

  
ProductManager(this.products);

  

  @override
  Widget build(BuildContext context) {
    print('[ProductsManager State] build()');
    return Column(
      children: [
        Expanded(child: Products())
      ],
    );
  }
}
