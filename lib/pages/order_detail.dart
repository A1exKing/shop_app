import 'package:flutter/material.dart';
import 'package:testapp/models/order.dart';
import 'package:timeline_tile/timeline_tile.dart';

class OrderDetail extends StatelessWidget {
  const OrderDetail({super.key, required this.order});
  final Order order;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff6f6f6),
      appBar: AppBar(
        backgroundColor: const Color(0xfff6f6f6),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            //  Navigator.of(context).pop();
          },
        ),
        title: Text("Order Detail"),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ListView(
          //  crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        order.status,
                        style: TextStyle(color: Colors.green, fontSize: 16),
                      ),
                      Text(
                        "${order.dateTime.year}-${order.dateTime.month}-${order.dateTime.day} ${order.dateTime.hour}:${order.dateTime.minute}",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                  Text("#${order.id_order}"),
                  ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(height: 12,),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: order.items.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              order.items[index].image,
                              width: 80,
                              height: 80,
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
                                style:
                                    TextStyle(overflow: TextOverflow.ellipsis),
                              ),
                              Text(
                                "\$${ order.items[index].price}",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0, bottom: 8),
              child: Text(
                "Status Order",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  TimelineItem(
                      title: 'Accepted',
                      description: '',
                      date: DateTime(2023, 11, 27),
                      first: true,
                      isDone: true),
                  TimelineItem(
                      title: 'Sent',
                      description: '',
                      date: DateTime(2023, 12, 5),
                      isDone: false),
                  TimelineItem(
                      title: 'Completed',
                      description: '',
                      date: DateTime(2023, 12, 5),
                      last: true,
                      isDone: false),
                  // Додавайте більше TimelineItem за необхідністю
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0, bottom: 8),
              child: Text(
                "Delivery",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Post office",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(order.adress),
                  SizedBox(
                    height: 6,
                  ),
                  Text("Order ID:", style: TextStyle(color: Colors.grey)),
                  Text("262635654523"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0, bottom: 8),
              child: Text(
                "Payment method",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  Icon(Icons.payment),
                  SizedBox(
                    width: 8,
                  ),
                  Text("Postpaid")
                ],
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Subtotal"),
                      Text("\$${order.subtotal}"),
                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Shipping"),
                      Text("\$${order.shipping}"),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("\$${order.subtotal + 5.50}",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 28,
            ),
          ],
        ),
      ),
    );
  }
}

class TimelineItem extends StatelessWidget {
  final String title;
  final String description;
  final DateTime date;
  final bool? last;
  final bool? first;
  final bool isDone;

  TimelineItem(
      {super.key,
      required this.title,
      required this.description,
      required this.date,
      this.last,
      this.first,
      required this.isDone});

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.0,
      isFirst: first ?? false,
      isLast: last ?? false,
      afterLineStyle: LineStyle(
          thickness: 2, color: isDone ? Colors.blue : Color(0xffE4E4E4)),
      beforeLineStyle: LineStyle(
          thickness: 2, color: isDone ? Colors.blue : Color(0xffE4E4E4)),
      indicatorStyle: IndicatorStyle(
        drawGap: true,
        indicatorXY: 0.3,
        width: 20,
        color: isDone ? Colors.blue : Color(0xffE4E4E4),
        iconStyle: IconStyle(
            iconData: isDone ? Icons.check : Icons.circle,
            color: Colors.white,
            fontSize: 18),
        // indicator: Icon(Icons.check_circle_outline),
      ),
      endChild: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              description,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
