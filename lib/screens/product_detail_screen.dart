import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  // final String title;
  static const routeName = '/product-detail';

  // const ProductDetailScreen(this.title);

  @override
  Widget build(BuildContext context) {
    final productId =
        ModalRoute.of(context).settings.arguments as String; //is the id
    final loadedProduct = Provider.of<Products>(context,
            listen: false //you do not need the update here, rebuild the screen
            )
        .findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 300,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            child: Image.network(loadedProduct.imageUrl, fit: BoxFit.cover),
          ),
          SizedBox(height: 10),
          Text(
            '\$${loadedProduct.price}',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(loadedProduct.description,
                textAlign: TextAlign.center, softWrap: true),
          ),
        ],
      ),
    );
  }
}
