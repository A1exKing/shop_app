import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:testapp/models/product.dart';

class FavoritesNotifier extends StateNotifier<List<String>> {
  FavoritesNotifier() : super(<String>[]);

  void toggleFavorite(String productId) async {
   if(state.contains(productId)){
     state.remove(productId);
   

   }else{
      var headers = {
  'Content-Type': 'application/json'
};
var request = http.Request('POST', Uri.parse('http://192.168.0.108:3000/setFavorite'));
request.body = json.encode({
  "id_product": productId,
  "id_user": "1"
});
request.headers.addAll(headers);
request.followRedirects = false;

http.StreamedResponse response = await request.send();

if (response.statusCode == 200) {
   state.add(productId);
  print(await response.stream.bytesToString());
}
else {
  print(response.reasonPhrase);
}
     
   }
    state = [...state];
  }
}

final favoritesProvider = StateNotifierProvider<FavoritesNotifier, List<String>>((ref) {
  return FavoritesNotifier();
});


final favoriteProductsProvider = FutureProvider<List<Product>>((ref) async {
  var client = http.Client();
  final response = await client.post(Uri.parse('http://192.168.0.108:3000/getFavorite'),body: {'id_user' : '1'});

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    return data.map((json) => Product.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load products');
  }
});
