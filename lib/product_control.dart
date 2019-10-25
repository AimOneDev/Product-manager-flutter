import 'package:flutter/Material.dart'; // no use for now or ever

class ProductContorl extends StatelessWidget{
  final Function addProduct;
  
  ProductContorl(this.addProduct);

  @override
  Widget build(BuildContext context) {
   
    return RaisedButton(
            color: Theme.of(context).primaryColor,
            onPressed: () {
             addProduct({'title': 'Chocolate', 'image': 'assets/food.jpg'});
            },
            child: Text('Add Product'),
          );
  }
}