import 'package:flutter/material.dart';
import 'package:testapp/pages/detail_product.dart';
import 'package:testapp/pages/home_page.dart';

class TodaySale extends StatelessWidget {
  const TodaySale(List<Product> products, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24, right: 12, top: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Today Sale!", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
              TextButton(
                style: ButtonStyle(splashFactory: NoSplash.splashFactory, visualDensity: VisualDensity.compact),
                onPressed: (){
              }, child: Text("See More", style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),))
            ],
          ),
        ),
        SizedBox(
          height: 232,
          child: ListView.separated(
            padding: EdgeInsets.only(left: 18, right: 18),
            itemCount: products.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => SizedBox(width: 12,),
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DetailProduct(product : products[index])));
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 160,
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Color(0xfff6f6f6)
                    ),
                    child: Image.asset( products[index].image, width: 150, height: 150,),
                  ),
                  SizedBox(height: 12,),
                  Text(products[index].name, maxLines: 1, style: TextStyle(fontWeight: FontWeight.bold),),
                  Text(products[index].description, maxLines: 1, style: TextStyle(color: Colors.grey),)
                ],
              ),
            )
          ),
        )
      ],
    );
  }
}