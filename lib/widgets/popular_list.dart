import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testapp/pages/detail_product.dart';
import 'package:testapp/provider/get_product.dart';




class PopularList extends ConsumerWidget {
   PopularList({super.key});

  @override
   Widget build(BuildContext context, WidgetRef ref) {
    final productsAsyncValue = ref.watch(productsProvider);

    return Column(
      children: [
         Padding(
          padding: const EdgeInsets.only(left: 24, right: 12, top: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Popular", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
              TextButton(
                style: ButtonStyle(splashFactory: NoSplash.splashFactory, visualDensity: VisualDensity.compact),
                onPressed: (){
              }, child: Text("See More", style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),))
            ],
          ),
        ),
        productsAsyncValue.when(
          data: (data) => GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 18),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: data.length,
                    cacheExtent: 12,
                    semanticChildCount: 22,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 222,
                        mainAxisSpacing: 24 ,
                        crossAxisSpacing: 12),
                    itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DetailProduct(
                                    product: data[index])));
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
                                  data[index].image[0],
                                  height: 150,
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Text(
                                data[index].name,
                                maxLines: 1,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                data[index].description,
                                maxLines: 2,
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                        )), 
          error: ((error, stackTrace) => Center(child: Text(error.toString()),)), 
          loading: () => const CircularProgressIndicator()
        ),
      ],
    );
    
    
   }
}