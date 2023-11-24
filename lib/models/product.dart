
import 'package:flutter/material.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final num price;
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

