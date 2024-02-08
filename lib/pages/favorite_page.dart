import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testapp/main.dart';
import 'package:testapp/pages/detail_product.dart';
import 'package:testapp/provider/favorite_provider.dart';

import 'package:testapp/widgets/bottom_nav_bar.dart';

class FavoritePage extends ConsumerWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WillPopScope(
      onWillPop: () async {
        pageNavController.animateToPage(
          0,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        ref.read(selectedItemPosition.notifier).state = 0;

        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () {
              pageNavController.animateToPage(
                0,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
              ref.read(selectedItemPosition.notifier).state = 0;
            },
          ),
          title: Text("Favorite"),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
        ),
        body: Consumer(builder: (context, ref, child) {
          final favoriteProduct = ref.watch(favoriteRestaurantsProvider);
          print(favoriteProduct);
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: GridView.builder(
                shrinkWrap: true,
                itemCount: favoriteProduct.length,
                cacheExtent: 12,
                semanticChildCount: 22,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 222,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 12),
                itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DetailProduct(
                                product: favoriteProduct[index])));
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            clipBehavior: Clip.hardEdge,
                            width: double.infinity,
                            // height: 180,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                color: Color(0xfff3f3f3)),
                            child: Image.network(
                              favoriteProduct[index].image[0],
                              height: 150,
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            favoriteProduct[index].name,
                            maxLines: 1,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            favoriteProduct[index].description,
                            maxLines: 2,
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                    )),
          );
        }),
      ),
    );
  }
}
