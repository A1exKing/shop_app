import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testapp/pages/detail_product.dart';
import 'package:testapp/provider/get_product.dart';

class SearchResultsPage extends StatelessWidget {
  const SearchResultsPage({super.key, required this.query});
final String query;
  @override
  Widget build(BuildContext context) {
    
    
      return Scaffold(
      appBar: AppBar(
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.chevron_left),
        onPressed: (){
          Navigator.of(context).pop();
        },
      ),
      title: Expanded(
        child: TextField(
          
          decoration:  InputDecoration(
                     contentPadding: EdgeInsets.symmetric(vertical: 0),
                     hoverColor: Color(0xfff6f6f6),
                     prefixIcon: Icon(Icons.search),
                     hintText: query,
                     border: OutlineInputBorder(
                       borderSide: BorderSide.none,
                       borderRadius: BorderRadius.circular(8)
                     ),
                     
                   ),
              ),
        
      ),
      actions: [
        IconButton(onPressed: (){}, icon: Icon(Icons.more_vert))
      ],
    ),
      body: Consumer(
       builder: (context, ref, child) {
//final favoriteProductID = ref.watch(favoritesProvider);
        final products = ref.watch(searchProductProvider(query));
      //  print(favoriteProductID);
         //late List favoriteProductList = allproduct.value!.where((value) => favoriteProductID.contains(value.id)).toList();
    //  print(products[3].id);
       // = products.where((element) => favoriteProductID.contains(element.id)).toList();
        //(favoriteProductList);
       return  products.when(
        data: (data) => Padding(
            padding: const EdgeInsets.all(18.0),
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              cacheExtent: 12,
              semanticChildCount: 22,
                gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent  : 222, mainAxisSpacing : 10, crossAxisSpacing: 12),
              
              itemBuilder: (context, index) =>GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DetailProduct(product : data[index])));
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
                              color: Color(0xfff3f3f3)
                            ),
                            child: Image.network( data[index].image[0],  height: 150,),
                          ),
                          SizedBox(height: 12,),
                          Text(data[index].name, maxLines: 1, style: TextStyle(fontWeight: FontWeight.bold),),
                          Text(data[index].description, maxLines: 2, style: TextStyle(color: Colors.grey),)
                        ],
                      ),
                    ) ),
          ),
          
          error: ((error, stackTrace) => Text(error.toString())), 
          loading: ()=> CircularProgressIndicator()
        );
           
        }
      ),
    
  
    );
  }
}