// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:testapp/widgets/banner.dart';
import 'package:testapp/widgets/bottom_nav_bar.dart';
import 'package:testapp/widgets/main_app_bar.dart';
import 'package:testapp/widgets/model_list.dart';
import 'package:testapp/widgets/today_sale.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final num price;
  final List<int>sizes;
  final List<Color>colors;
  late bool isFavorite ;
  final String image ;
  
  Product({required this.sizes, required this.colors, 
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
     this.isFavorite = false,
  });
}
class FavoritesNotifier extends StateNotifier<List<String>> {
  FavoritesNotifier() : super(<String>[]);

  void toggleFavorite(String productId) {
    state.contains(productId) ? state.remove(productId) : state.add(productId);
    state = [...state];
  }
}

final favoritesProvider = StateNotifierProvider<FavoritesNotifier, List<String>>((ref) {
  return FavoritesNotifier();
});


List <Product> products =[
  Product(sizes:  [38, 39, 40, 41, 42], colors : [Colors.red, Colors.green, Colors.blue], id: "id_1", name: "Nike Alphafly 2", description: "Men's Roda Racing Shoes", price: 102.50, image : "assets/images/alphafly_2.png",),
  Product(sizes:  [40, 41, 42], colors : [Colors.brown, Colors.grey, Colors.black], id: "id_2", name: "nike dunk low", description: "description 2", price: 95.00, image : "assets/images/dunk_low.png",),
  Product(sizes:  [38, 39, 40], colors : [Colors.white, Colors.black, Colors.grey], id: "id_3 ", name: "name 3", description: "description 2", price: 84.60, image : "assets/images/nike_air_force.png",),
];

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
         
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 48,),
                MainAppBar(),
                const SizedBox(height: 18,),
                BannerWidget(),
                const SizedBox(height: 18,),
                ListModels(),
                 const SizedBox(height: 12,),
                TodaySale(products),
                const SizedBox(height: 12,),
                TodaySale(products)
                
              ],
            ),
          ),
           Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 1,
              width: double.infinity,
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: Colors.white, blurRadius: 12, spreadRadius: 20, )]
              ),
            ),
          ),
        ],
      ),
    );
  }
}
