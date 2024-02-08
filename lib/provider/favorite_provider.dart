import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:testapp/models/product.dart';


class FavoriteRestaurantsNotifier extends StateNotifier<List<Product>> {
  FavoriteRestaurantsNotifier(this.userId) : super([]);

  final int userId;

  Future<void> setInitialFavorites(int userId) async {
    var client = http.Client();
   final response = await client.post(Uri.parse('http://192.168.0.108:3000/getFavorite'),body: {'id_user' : '1'});
    
    if (response.statusCode == 200) {
      // Парсимо відповідь у форматі JSON
     // List<dynamic> data = json.decode(response.body);
      print('get favorite');
      // Конвертуємо JSON у об'єкти Product
     List<dynamic> data = json.decode(response.body);
    List<Product> restaurants =  data.map((json) => Product.fromMap(json)).toList();
      
      // Оновлюємо стан з отриманими даними
    //  _products = restaurants;
      state = restaurants;
     // return restaurants;
      // Сповіщаємо слухачів про зміни в даних
     
    } else {
      throw Exception('Failed to load data from server');
    }
  }


  Future<void>  toggleFavorite(Product restaurantId) async {
    if (state.any((element) => element.id == restaurantId.id)) {
      state = state.where((id) => id.id != restaurantId.id).toList();
  
      final response = await http.post(
        Uri.parse('http://192.168.0.108:3000/delFavorite'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "id_product": restaurantId.id,
          "id_user": "1"
        }),
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
      } else {
        throw Exception('Failed to load restaurants');
      }
    } else {
      state = [...state, restaurantId];
      final response = await http.post(
        Uri.parse('http://192.168.0.108:3000/setFavorite'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "id_product": restaurantId.id,
          "id_user": "1"
        }),
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
      } else {
        throw Exception('Failed to load restaurants');
      }
    }
  }
}



final favoriteRestaurantsProvider = StateNotifierProvider<FavoriteRestaurantsNotifier, List<Product>>((ref) {
  // Отримайте userId з контексту або з іншого джерела, якщо потрібно
  final userId = 1;
  return FavoriteRestaurantsNotifier(userId);
});


