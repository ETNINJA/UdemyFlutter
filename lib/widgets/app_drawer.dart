import 'package:flutter/material.dart';

import '../screens/order_screen.dart';
import '../screens/user_products_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer ({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer( child: Column( children: <Widget>[
      AppBar(title: Text('Hello Anne'),
      automaticallyImplyLeading: false, //don´t show go back buttom
      ),
      Divider(),
      ListTile(
        leading: Icon(Icons.shop), 
        title: Text('Shop'),
        onTap: (){
          Navigator.of(context).pushReplacementNamed('/');
        },
      ),
      Divider(),
      ListTile(
        leading: Icon(Icons.payment), 
        title: Text('Orders'),
        onTap: (){
          Navigator.of(context).pushReplacementNamed(OrderScreen.routeName);
        },
      ),
       Divider(),
      ListTile(
        leading: Icon(Icons.edit), 
        title: Text('Manage Products'),
        onTap: (){
          Navigator.of(context).pushReplacementNamed(UserProductsScreen.routeName);
        },
      ),    

    ],
    ),
    );
  }
}