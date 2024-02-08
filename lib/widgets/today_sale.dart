import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testapp/pages/detail_product.dart';
import 'package:testapp/provider/get_product.dart';

class TodaySale extends ConsumerWidget {
   TodaySale({super.key});

  @override
   Widget build(BuildContext context, WidgetRef ref) {
    final productsAsyncValue = ref.watch(todaySaleProvider);
    // final favoriteProduct = ref.watch(favoriteRestaurantsProvider);
    //print(productsAsyncValue.value?.first.name);
    return productsAsyncValue.when(
      data: (data) {
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
            itemCount: data.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => SizedBox(width: 12,),
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  
                  MaterialPageRoute(
                   settings: RouteSettings(),
                    builder: (context)=>DetailProduct(product : data[index], tag : "sale"))
                );
              },
              child: Container(
                 width: 160,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   Hero(
                      transitionOnUserGestures: true,
                      tag: "sale${data[index].image[0]}",
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Color(0xfff6f6f6)
                        ),
                        child:  Image.network(data[index].image[0], width: 140, height: 140,)//Image.asset( products[index].image[0],),
                      ),
                    ),
                    SizedBox(height: 12,),
                    Text(data[index].name, maxLines: 1, style: TextStyle(fontWeight: FontWeight.bold),),
                    Text(data[index].description, maxLines: 2, style: TextStyle(color: Colors.grey, overflow: TextOverflow.ellipsis),)
                  ],
                ),
              ),
            )
          ),
        )
      ],
    );
      }, error: (Object error, StackTrace stackTrace) { return Center(child: Text(error.toString()),) ; }, 
      loading: () { return CircularProgressIndicator(); }
    );
    
    
  }
}