// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testapp/pages/cart.dart';
import 'package:testapp/provider/cart_provider.dart';

class OrderItem {
  final String name;
  final String image;
  final int q;
  final double price;


  OrderItem({
    required this.name,
    required this.image,
    required this.q,
    required this.price,
  });
}

class Order {
  final String id;
  final String status;
  final DateTime dateTime;
  final List<CartItem> items;
  final double subtotal;
  final String adress;
  final String id_order;
  final String payment_method;
  final double shipping;
  Order({
    required this.id,
    required this.status,
    required this.dateTime,
    required this.items,
    required this.subtotal,
    required this.adress,
    required this.id_order,
    required this.payment_method,
    required this.shipping,
  });

}

late List<Order> listOrder = [
  //Order(id: "1", status: "Active", dateTime: DateTime.now(), items: [ItemProductCart(item: CartItem(productId, quantity, price, size, color, image),)], subtotal: 1232, adress: "adress", id_order: "124425255", payment_method: "payment_method", shipping: 31)
] ;


final ordersProvider = StateNotifierProvider<OrderNotifier, List<Order>>(
  (ref) => OrderNotifier(),
);

class OrderNotifier extends StateNotifier<List<Order>> {
  OrderNotifier() : super(listOrder);

  void addOrder(Order order) {
    state = [...state, order];
  }

  // Додайте інші методи, які вам потрібні для роботи з замовленнями
}

