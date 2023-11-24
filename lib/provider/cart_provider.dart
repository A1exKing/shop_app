import 'package:flutter_riverpod/flutter_riverpod.dart';



class Cart {
  final List<CartItem> items;

  Cart(this.items);
   // Функція для підрахунку загальної суми
  num get totalAmount {
    return items.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }
}

class CartItem {
  final String productId;
  final num price;
   final int size;
    final String color;
     final String image;
  int quantity;

  CartItem(this.productId, this.quantity, this.price, this.size, this.color, this.image);
}



final cartProvider = StateNotifierProvider<CartNotifier, Cart>((ref) {
  return CartNotifier();
});

class CartNotifier extends StateNotifier<Cart> {
  CartNotifier() : super(Cart([]));

  void addItem(String productId, int quantity, num price, int size, String color, String image) {
    state = Cart([...state.items, CartItem(productId, quantity, price, size, color, image)]);
  }

  void updateItemQuantity(String productId, int newQuantity) {
    state = Cart(
      state.items.map((item) {
        if (item.productId == productId) {
          return CartItem(productId, newQuantity, item.price, item.size, item.color, item.image);
        }
        return item;
      }).toList(),
    );
  }

  num get totalAmount {
    return state.totalAmount;
  }

  void removeItem(String productId) {
    state = Cart(
      state.items.where((item) => item.productId != productId).toList(),
    );
  }
}