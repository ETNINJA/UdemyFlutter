
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product ({
    @required this.id, 
    @required this.title, 
    @required this.description, 
    @required this.price, 
    @required this.imageUrl, 
    this.isFavorite = false,
  });

  void _setFavValue (bool value) {
    isFavorite = value;
    notifyListeners();   
  }

  Future<void> toggleFavoritesStatus() async{
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();    
    final url = 'https://test-54c0b.firebaseio.com/products/$id.json';
    try {
      final response = await http.patch(url, body: json.encode({
      'isFavorite': isFavorite,
    }),);
    if(response.statusCode >= 400){
      _setFavValue(oldStatus);
      // isFavorite = oldStatus; put inside a fuction to avoid code duplication
      // notifyListeners();      
    }
    }catch (error) {
      _setFavValue(oldStatus);
      // isFavorite = oldStatus;
      // notifyListeners();      
    }    
  }

}