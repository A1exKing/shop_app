import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testapp/models/product.dart';

final productsProvider = FutureProvider<List<Product>>((ref) async {
  final response = await http.get(Uri.parse('http://192.168.0.108:3000/products'));

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    return data.map((json) => Product.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load products');
  }
});


final productsOfCategoryProvider = FutureProviderFamily<List<Product>, String>((ref, companyName) async {
  final response = await http.get(Uri.parse('http://192.168.0.108:3000/products_of_company/$companyName'));

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    return data.map((json) => Product.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load products');
  }
});

final searchProductProvider = FutureProviderFamily<List<Product>, String>((ref, query) async {
    if (query.length >= 3) {
    final response = await http.get(Uri.parse('http://192.168.0.108:3000/search/products?q=$query'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      print(data);
      return data.map((json) => Product.fromJson(json)).toList();
      // setState(() {
      //   _searchResults = data.map((json) => Product.fromJson(json)).toList();
      // });
    } else {
      //print('Failed to load search results');
       throw Exception('Failed to load search results');
    }
    }else{
      return [];
    }
});

