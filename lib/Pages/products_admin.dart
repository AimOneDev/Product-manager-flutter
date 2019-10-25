import 'package:flutter/material.dart';

//import './products.dart';
import './product_create.dart';
import './product_list.dart';
import '../scoped_models/main.dart';

class ProductsAdminPage extends StatelessWidget {

  final MainModel model;

  ProductsAdminPage(this.model);

  // final Function addProduct;
  // final Function deleteProduct;
  // final Function updateProduct;
  // final List<Product> products;

  // ProductsAdminPage(this.addProduct, this.updateProduct, this.deleteProduct, this.products);

  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('Choose'),
          ),
          ListTile(
            title: Text('All Products'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/products');
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: _buildSideDrawer(context),
        appBar: AppBar(
          // elevation: 10.0,
          // backgroundColor: Color.fromARGB(240, 250, 150, 250),
          title: Text('Manage Products'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.create),
                //  text: 'Create Product',
              ),
              Tab(
                icon: Icon(Icons.list),
                // text: 'My Products',
              ),
              // Tab(
              //   icon: Icon(Icons.home),
              //   // text: 'My Products',
              // ),
              // Tab(
              //   icon: Icon(Icons.supervised_user_circle),
              //   // text: 'My Products',
              // ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ProductCreatePage(),
            ProductListPage(model),
          ],
        ),
      ),
    );
  }
}

/*import 'package:flutter/material.dart';

import './product_create.dart';
import './product_list.dart';

class ProductsAdminPage extends StatelessWidget {
  final Function addProduct;
  final Function deleteProduct;

  ProductsAdminPage(this.addProduct, this.deleteProduct);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              AppBar(
                automaticallyImplyLeading: false,
                title: Text('Choose'),
              ),
              ListTile(
                title: Text('All Products'),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/');
                },
              )
            ],
          ),
        ),
        appBar: AppBar(
          title: Text('Manage Products'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.create),
                text: 'Create Product',
              ),
              Tab(
                icon: Icon(Icons.list),
                text: 'My Products',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[ProductCreatePage(addProduct), ProductListPage()],
        ),
      ),
    );
  }
}*/


 

  //  BottomNavigationBar(items: <BottomNavigationBarItem>[
  //         BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
  //         BottomNavigationBarItem(icon: Icon(Icons.business), title: Text('Business')),
  //         BottomNavigationBarItem(icon: Icon(Icons.school), title: Text('School')),
  //       ],
  //      // currentIndex: _selectedIndex,
  //       fixedColor: Colors.blue,
  //       //onTap: _onItemTapped,
        
  //       ),