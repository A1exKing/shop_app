
import 'package:flutter/material.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final dynamic price;
  final List<int>sizes;
  final List<Color>colors;
  late bool isFavorite ;
  final List<String> image ;
  
  Product({required this.sizes, required this.colors, 
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
     this.isFavorite = false,
  });


 factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['product_id'].toString(),
      name: map['product_name'] as String,
      description: map['description'] as String,
      price: num.parse(map['price']),
       sizes: List<int>.from(map['size']),
       image:List<String>.from(map['image']),
        colors: (map['colors'] as List).map((color) => Color(int.parse(color))).toList(), 
    );
  }


   factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['product_id'].toString(),
      name: json['product_name'],
      description: json['description'],
      price: num.parse(json['price']),
      sizes: List<int>.from(json['size']),
      colors: (json['colors'] as List).map((color) => Color(int.parse(color))).toList(),
     // isFavorite: json['isFavorite'],
      image: List<String>.from(json['image']),
    );
  }
}

