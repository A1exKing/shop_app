import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testapp/models/order.dart';
import 'package:testapp/pages/order_detail.dart';

class HistoryOrders extends StatelessWidget {
  const HistoryOrders({super.key});

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
        title: Text("My Orders"),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: OrderList()
      ),
    );
  }
}

class OrderList extends ConsumerWidget {
  const OrderList({
    super.key,
  });


  @override
   Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(ordersProvider);
    return ListView.builder(
      itemCount: value.length,
      itemBuilder: (context, index) => ItemOrderList(order : value[index]),
    );
  }
}

class ItemOrderList extends StatelessWidget {
   ItemOrderList(  { required this.order,super.key,
  });
  final Order order;
  late double totalPrice = order.shipping;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => OrderDetail(order: order)));
      },
      child: Container(
        //  width: 300,
        // height: 160,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 253, 253, 253),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Color(0xfff6f6f6))),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(order.status , style: TextStyle(color: order.status == "Active" ? Colors.orange : Colors.green, fontSize: 16),
                  ),
                  Text(
                    "26.11.2023",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
              Text("#${order.id_order}"),
              SizedBox(
                height: 6,
              ),
              ListView.separated(
                separatorBuilder: (context,_) => SizedBox(height: 8,),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: order.items.length,
                itemBuilder: (context, index) {
                  totalPrice += order.items[index].price;
                  
                  return Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          order.items[index].image,
                          width: 60,
                          height: 60,
                        ),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            order.items[index].name,
                            style: TextStyle(overflow: TextOverflow.ellipsis),
                          ),
                          Text(
                            "\$${order.items[index].price}",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
              // SizedBox(
              //   height: 55,
              //   child: ListView.builder(
              //     shrinkWrap: true,
              //     itemCount: 3,
              //     scrollDirection: Axis.horizontal,
              //     itemBuilder: (context, index) {
              //       return

              //      Container(
              //       height: 55,
              //       width: 170,
              //       margin: EdgeInsets.only(right: 6),
              //       decoration: BoxDecoration(
              //         color: Colors.white,
              //   borderRadius: BorderRadius.circular(12),
              //   border: Border.all(color: Color.fromARGB(255, 236, 236, 236))
              //             ),
              //        child: Row(
              //         mainAxisSize: MainAxisSize.min,
              //          children: [
              //           Image.asset("assets/images/alphafly_2.png", width: 50,height: 50,),
              //           SizedBox(width: 6,),
              //            Column(
              //             mainAxisSize: MainAxisSize.min,
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //              children: [
              //                Text("name", style: TextStyle(overflow: TextOverflow.ellipsis),),
              //                Text("price", style: TextStyle(color: Colors.grey, fontSize: 12),),
              //              ],
              //            ),
              //          ],
              //        ),

              //    );

              //     },
              //   ),
              // ),
              SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Text(
                    "Total",
                    style: TextStyle(fontSize: 16),
                  ),
                  Spacer(),
                  RichText(
                    text: TextSpan(
                        text: '\$',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                        children: [
                          TextSpan(
                              text: "${order.subtotal + order.shipping}",
                              style: TextStyle(color: Colors.black))
                        ]),
                  )
                ],
              ),
            ]),
      ),
    );
  }
}
