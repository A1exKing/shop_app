import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testapp/pages/detail_product.dart';
import 'package:testapp/pages/home_page.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.chevron_left),
        onPressed: (){
         // Navigator.of(context).pop();
        },
      ),
      title: Text("Favorite"),
      actions: [
        IconButton(onPressed: (){}, icon: Icon(Icons.more_vert))
      ],
    ),
      body: Consumer(
       builder: (context, ref, child) {
        final favoriteProductID = ref.watch(favoritesProvider);
        print(favoriteProductID);
        late List favoriteProductList = products.where((element) => favoriteProductID.contains(element.id)).toList();
        print(favoriteProductList);
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: favoriteProductList.length,
              cacheExtent: 12,
              semanticChildCount: 22,
                gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent  : 220, mainAxisSpacing : 10, crossAxisSpacing: 12),
              
              itemBuilder: (context, index) =>GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DetailProduct(product : products[index])));
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: Color(0xfff6f6f6)
                            ),
                            child: Image.asset( favoriteProductList[index].image,  height: 150,),
                          ),
                          SizedBox(height: 12,),
                          Text(favoriteProductList[index].name, maxLines: 1, style: TextStyle(fontWeight: FontWeight.bold),),
                          Text(favoriteProductList[index].description, maxLines: 1, style: TextStyle(color: Colors.grey),)
                        ],
                      ),
                    ) ),
          );
        }
      ),
    );
  }
}