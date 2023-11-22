import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testapp/pages/home_page.dart';


class Cart {
  final List<CartItem> items;

  Cart(this.items);
}

class CartItem {
  final String productId;
  final num price;
   final int size;
    final String color;
  int quantity;

  CartItem(this.productId, this.quantity, this.price, this.size, this.color);
}



final cartProvider = StateNotifierProvider<CartNotifier, Cart>((ref) {
  return CartNotifier();
});

class CartNotifier extends StateNotifier<Cart> {
  CartNotifier() : super(Cart([]));

  void addItem(String productId, int quantity, num price, int size, String color) {
    state = Cart([...state.items, CartItem(productId, quantity, price, size, color)]);
  }

  void updateItemQuantity(String productId, int newQuantity) {
    state = Cart(
      state.items.map((item) {
        if (item.productId == productId) {
          return CartItem(productId, newQuantity, item.price, item.size, item.color);
        }
        return item;
      }).toList(),
    );
  }

  

  void removeItem(String productId) {
    state = Cart(
      state.items.where((item) => item.productId != productId).toList(),
    );
  }
}