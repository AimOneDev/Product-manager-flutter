import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/product.dart';
import '../scoped_models/main.dart';

class ProductCreatePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductCreatePageState();
  }
}

class _ProductCreatePageState extends State<ProductCreatePage> {
  // String titleValue = '';
  // String descriptionValue = '';
  // double priceValue;
  final Map<String, dynamic> _formValue = {
    'title': null,
    'description': null,
    'price': null,
    'image': 'assets/food.jpg',
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildTitleTextField(Product product) {
    return TextFormField(
      initialValue: product == null ? '' : product.title,
      //autovalidate: true,
      validator: (String value) {
        //if (value.trim().length <= 0)
        if (value.isEmpty || value.length < 5) {
          return 'Title is required and should be 5+ chars long';
        }
      },
      scrollPadding: const EdgeInsets.all(10.0),
      decoration: InputDecoration(
          //border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          labelText: 'Product Name'),
      onSaved: (String value) {
        // we do not need set state in forms
        _formValue['title'] = value;
      },
    );
  }

  Widget _buildDescriptionTextField(Product product) {
    return TextFormField(
      maxLines: 4,
      initialValue: product == null ? '' : product.description,
      validator: (String value) {
        //if (value.trim().length <= 0)
        if (value.isEmpty || value.length < 10) {
          return 'Title is required and should be 5+ chars long';
        }
      },
      decoration: InputDecoration(
          // border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          labelText: 'Product Description'),
      onSaved: (String value) {
        // descriptionValue =value;
        _formValue['description'] = value;
      },
    );
  }

  Widget _buildPriceTextField(Product product) {
    return TextFormField(
      initialValue: product == null ? '' : product.price.toString(),
      validator: (String value) {
        //if (value.trim().length <= 0)
        if (value.isEmpty ||
            !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
          return 'Price is required and should be a number';
        }
      },
      decoration: InputDecoration(
          //border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          labelText: 'Price'),
      keyboardType: TextInputType.number,
      onSaved: (String value) {
        _formValue['price'] = double.parse(value);
      },
    );
  }

  Widget _buildSubmitButton() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return model.isLoading
            ? Center(child: CircularProgressIndicator())
            : RaisedButton(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                // color: Colors.greenAccent,
                child: Text('Save'),
                onPressed: () => _submitForm(
                    model.addProduct,
                    model.updateProduct,
                    model.selectProduct,
                    model.selectedProductIndex),
              );
      },
    );
  }

  Widget _buildPageContent(BuildContext context, Product product) {
    final double _deviceWidth = MediaQuery.of(context).size.width;
    final double _targetWidth =_deviceWidth > 550.0 ? 500.0 : _deviceWidth * 0.95;
    final double _targetPadding = _deviceWidth - _targetWidth;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode()); //to hide the keyboard
      },
      child: Container(
        width: _targetWidth,
        // padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: _targetPadding / 2),
            children: <Widget>[
              _buildTitleTextField(product),
              _buildDescriptionTextField(product),
              _buildPriceTextField(product),
              SizedBox(
                height: 20.0,
              ),
              _buildSubmitButton(),
              // GestureDetector(
              //   onTap: _submitForm,
              //  child: Container(
              //   color: Colors.greenAccent,
              //   padding: EdgeInsets.all(10.0),
              //   child: Text('My Button'),
              // )
              // ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm(Function addProduct, Function updateProduct,Function setSelectedProduct,
      [int selectedProductIndex]) {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    if (selectedProductIndex == -1) {
      addProduct(
              _formValue['title'], 
              _formValue['description'],
              _formValue['image'], 
              _formValue['price'])
          .then((bool success) {
        if (success) {
          Navigator.pushReplacementNamed(context, '/products')
          .then((_) => setSelectedProduct(null));
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('No network'),
                  content: Text('check your network'),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('okay'),
                    )
                  ],
                );
              });
        }
      });
    } else {
      updateProduct(
        _formValue['title'],
        _formValue['description'],
        _formValue['image'],
        _formValue['price'],
      ).then(
        (_) => Navigator.pushReplacementNamed(context, '/products')
        .then((_) => setSelectedProduct(null)),
      );
    }
    // final Map<String, dynamic> product = {
    //   'title': titleValue,
    //   'description': descriptionValue,
    //   'price': priceValue,
    //   'image': 'assets/food.jpg',
    // };

    //Navigator.pushReplacementNamed(context, '/products');
    //.then((_) => setSelectedProduct(null));
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        final Widget pageContent =
            _buildPageContent(context, model.selectedProduct);
        return model.selectedProductIndex == -1
            ? pageContent
            : Scaffold(
                appBar: AppBar(
                  title: Text('editPage'),
                ),
                body: pageContent,
              );
      },
    );
  }
}

/*return Center(
      child: RaisedButton(
        child: Text('Modal'),
        colorBrightness: Brightness.dark,
        onPressed: () {
          showModalBottomSheet(context: context, builder: (BuildContext context){
            return Center(child: Text('this is a modal'),);
          },);
        },
      )
      
    );*/
