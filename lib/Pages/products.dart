import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../widgets/Products/products.dart';
import './auth.dart';
import '../scoped_models/main.dart';

class ProductsPage extends StatefulWidget {

  final MainModel model ;
  ProductsPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _ProductsPageState();
  }
}

class _ProductsPageState extends State<ProductsPage> {
  
  initState() {
    widget.model.fetchProducts();
    super.initState();
  }

  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('choose'),
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Products'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/admin');
            },
          ),
          ListTile(
            leading: Icon(Icons.ac_unit),
            title: Text('Log out'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => AuthPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProductsList() {
    return ScopedModelDescendant(builder: (BuildContext context, Widget child, MainModel model) {
      Widget content =Center(child: Text('no prods found'),);
      if (model.displayedProducts.length > 0 && !model.isLoading) {
        content =Products();
      }else if(model.isLoading){
        content = Center(child: CircularProgressIndicator());
      }
      return RefreshIndicator(onRefresh: 
        model.fetchProducts, child: content,) ;
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildSideDrawer(context),
      appBar: AppBar(
        actions: <Widget>[
          ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget child, MainModel model) {
              return IconButton(
                icon: Icon(model.displayFavoritesOnly
                    ? Icons.favorite
                    : Icons.favorite_border),
                onPressed: () {
                  model.toggleDisplayMode();
                },
              );
            },
          ),
        ],
        title: Text('Products'),
      ),
      body: _buildProductsList(),
    );
  }
}
