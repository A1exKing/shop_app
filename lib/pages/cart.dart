import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testapp/main.dart';
import 'package:testapp/models/order.dart';
import 'package:testapp/provider/cart_provider.dart';
import 'package:testapp/widgets/bottom_nav_bar.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            //  Navigator.of(context).pop();
          },
        ),
        title: Text("My Chart"),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
      ),
      body: Consumer(builder: (context, ref, child) {
        final cart = ref.watch(cartProvider);
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: cart.items.length,
                itemBuilder: (context, index) {
                  return ItemProductCart(item: cart.items[index]);
                },
              ),
            ),

            // SizedBox(height: 12,),
            // ItemProductCart(),
            //  / Spacer(),
            Consumer(builder: (context, ref, child) {
              final cartNotifier = ref.read(cartProvider.notifier);
              return Container(
                  padding:
                      EdgeInsets.only(left: 24, right: 24, top: 26, bottom: 18),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.38,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xffE6E6E6),
                            offset: Offset(0, -2),
                            blurRadius: 12,
                            spreadRadius: 5)
                      ],
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(36))),
                  child: Column(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(color: Color(0xfff6f6f6)),
                            color: Color(0xfff6f6f6).withOpacity(0.7)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Promo Code or Voucher",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                            ),
                            Text(
                              "Savings with Your Promo Code or Voucher",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Row(
                        children: [
                          Text(
                            "Sub Total",
                            style: TextStyle(fontSize: 18),
                          ),
                          Spacer(),
                          RichText(
                            text: TextSpan(
                                text: '\$',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                                children: [
                                  TextSpan(
                                      text: cartNotifier.totalAmount.toString(),
                                      style: TextStyle(color: Colors.black))
                                ]),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Text(
                            "Shpping",
                            style: TextStyle(fontSize: 18),
                          ),
                          Spacer(),
                          RichText(
                            text: TextSpan(
                                text: '\$',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                                children: [
                                  TextSpan(
                                      text: "${5.50}",
                                      style: TextStyle(color: Colors.black))
                                ]),
                          )
                        ],
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total",
                            style: TextStyle(fontSize: 18),
                          ),
                          RichText(
                            text: TextSpan(
                                text: '\$',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                                children: [
                                  TextSpan(
                                      text: cartNotifier.totalAmount.toString(),
                                      style: TextStyle(color: Colors.black))
                                ]),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      SizedBox(
                        height: 54,
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Color(0xff111111)),
                                shape: MaterialStatePropertyAll<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        12.0), // Задайте бажаний радіус тут
                                  ),
                                )),
                            onPressed: () {

                              ref.read(ordersProvider.notifier).addOrder(Order(id: "23", status: "Active", dateTime: DateTime.now(), items: cart.items , subtotal: cartNotifier.totalAmount.toDouble(), adress: "adress", id_order: "346362", payment_method: "payment_method", shipping:  5.50));
                             final snackBar = SnackBar(
                              
                              backgroundColor: Colors.greenAccent,
                content: Text('Order added', style: TextStyle(color: Colors.white),),
                action: SnackBarAction(
                  textColor : Colors.black,
                  label: 'View',
                  onPressed: () {
                      pageNavController.animateToPage(
          1,
          duration: Duration(milliseconds: 1000),
          curve: Curves.easeInOut,
        );
        ref.read(selectedItemPosition.notifier).state = 1;
        Navigator.of(context).pop();
        
      ///  return false;  
                  },
                ),
              );

              // Відображення Snackbar
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            },
                            child: Text(
                              "Checout",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            )),
                      )
                    ],
                  ));
            }),
          ],
        );
      }),
    );
  }
}

class ItemProductCart extends StatelessWidget {
  const ItemProductCart({
    super.key,
    required this.item,
  });
  final CartItem item;
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final cartNotifier = ref.read(cartProvider.notifier);
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 18),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: Color(0xfff6f6f6))),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Row(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(color: Color(0xfff6f6f6)),
                        color: Color(0xffe6e6e6)),
                    child: Center(
                      child: Image.network(item.image),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${item.name}",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Men's Shoes",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                              color: Color(0xffEFEFEF),
                              borderRadius: BorderRadius.circular(30)),
                          child: Row(
                            children: [
                              Text(
                                "${item.size},",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black),
                              ),
                              Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: item.color
                                ),
                              )
                            ],
                          )),
                    ],
                  ),
                  Spacer(),
                  Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(Icons.more_vert),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        "\$${item.price * item.quantity}",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Divider(
              color: Color(0xfff6f6f6),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12),
              child: Row(
                children: [
                  Text(
                    "Add to wishlist",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      ref
                          .read(cartProvider.notifier)
                          .removeItem(item.productId);
                    },
                    icon: Icon(Icons.delete_outline),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Container(
                    // height: 40,
                    width: 100,
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xffEFEFEF)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            cartNotifier.updateItemQuantity(
                                item.productId, item.quantity - 1);
                          },
                          child: Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                              child: Icon(
                                Icons.remove,
                                size: 18,
                              )),
                        ),
                        Text(item.quantity.toString()),
                        GestureDetector(
                          onTap: () {
                            cartNotifier.updateItemQuantity(
                                item.productId, item.quantity + 1);
                          },
                          child: Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                              child: Icon(
                                Icons.add,
                                size: 18,
                              )),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
