import 'package:flutter/material.dart';
import 'package:testapp/pages/detail_product.dart';
import 'package:testapp/pages/home_page.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 5,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 2),
      itemBuilder: (context, index) =>GestureDetector(
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
            ) );
  }
}