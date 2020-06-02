import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import './cart_screen.dart';
import '../widgets/app_drawer.dart';
import '../providers/products.dart';

enum FilterOption { Favorites, All }

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showFavoritesOnly = false;
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    //Provider.of<Products>(context).fetchAndSetProducts(); // will work only with listen: false
    // Future.delayed(Duration.zero).then((_) { //didCahnge dependencies is better
    //   Provider.of<Products>(context).fetchAndSetProducts();
    // });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if(_isInit) {
      setState(() {
         _isLoading = true;
      });     
      Provider.of<Products>(context).fetchAndSetProducts().then((_){
        setState(() {
         _isLoading = false;
      });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyAnne'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOption selectedValue) {
              setState(() {
                if (selectedValue == FilterOption.Favorites) {
                  _showFavoritesOnly = true;
                } else {
                  _showFavoritesOnly = false;
                }
              });
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                  child: Text('Only Favorites'), value: FilterOption.Favorites),
              PopupMenuItem(child: Text('Show All'), value: FilterOption.All),
            ],
            icon: Icon(
              Icons.more_vert,
            ),
          ),
          Consumer<Cart>(
            builder: ( _ , cartData, ch) => Badge(
              child: ch,           //the child IconButton will be passed here  
              value: cartData.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart), 
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
                ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading ? Center(child: CircularProgressIndicator(),)
      :ProductsGrid(_showFavoritesOnly),
    );
  }
}
