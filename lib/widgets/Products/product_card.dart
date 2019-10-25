import 'package:flutter/material.dart';
import './price_tag.dart';
import '../../models/product.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../scoped_models/main.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final int productIndex;

  ProductCard(this.product, this.productIndex);

  Widget _priceTitleContainer() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            product.title,
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Oswald'),
          ),
          SizedBox(
            width: 10.0,
          ),
          PriceTag(product.price.toString()),
        ],
      ),
    );
  }

  Widget _buildButtonContext(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return ButtonBar(
        alignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.info),
            //child: Text('Details'),
            onPressed: () => Navigator.pushNamed<bool>(
                context, '/product/' + model.allProducts[productIndex].id),
          ),
          IconButton(
              icon: Icon(model.allProducts[productIndex].isFavorite
                  ? Icons.favorite
                  : Icons.favorite_border),
              //child: Text('Details'),
              onPressed: () {
                model.selectProduct(model.allProducts[productIndex].id);
                model.toggleProductFavoriteStatus();
              }),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          FadeInImage(
            image: NetworkImage(product.image),
            height: 300.0,
            fit: BoxFit.cover,
            placeholder: AssetImage('assets/food.jpg'),
          ),
          _priceTitleContainer(),
          SizedBox(
            height: 5.0,
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5),
              child: Text('Union Square, San Francisco'),
            ),
          ),
          Text(product.userEmail),
          _buildButtonContext(context),
        ],
      ),
    );
  }
}
