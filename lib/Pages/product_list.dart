import 'package:flutter/material.dart';
import './product_create.dart';

import 'package:scoped_model/scoped_model.dart';
import '../scoped_models/main.dart';

class ProductListPage extends StatefulWidget {
  final MainModel model;

  ProductListPage(this.model);
  @override
  State<StatefulWidget> createState() {
    return _ProductListState();
  }
}

class _ProductListState extends State<ProductListPage> {
  initState() {
    widget.model.fetchProducts();
    super.initState();
  }

  Widget _buildEditButton(BuildContext context, int index, MainModel model) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        model.selectProduct(model.allProducts[index].id);
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) {
            return ProductCreatePage();
          }),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              background: Container(
                color: Colors.redAccent,
              ),
              key: Key(model.allProducts[index].title),
              onDismissed: (DismissDirection direction) {
                if (direction == DismissDirection.endToStart) {
                  model.selectProduct(model.allProducts[index].id);
                  model.deleteProduct();
                } else if (direction == DismissDirection.startToEnd) {
                  print('swiped down');
                } else {
                  print('other swipe');
                }
              },
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        model.allProducts[index].image,
                      ),
                    ),
                    title: Text(model.allProducts[index].title),
                    subtitle:
                        Text('\$ ${model.allProducts[index].price.toString()}'),
                    trailing: _buildEditButton(context, index, model),
                  ),
                  Divider(
                    color: Colors.greenAccent,
                  )
                ],
              ),
            );
          },
          itemCount: model.allProducts.length,
        );
      },
    );
  }
}
