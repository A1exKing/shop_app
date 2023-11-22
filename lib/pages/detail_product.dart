import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testapp/pages/home_page.dart';
import 'package:testapp/provider/cart_provider.dart';

class DetailProduct extends StatelessWidget {
   DetailProduct( {super.key, required this.product,});
 final  Product product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xffD5D5D5),Colors.white])
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.chevron_left, size: 32,),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      color: Colors.white  
                    ),
                    child: Text("High Rated", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)),
                  Consumer(
                     builder: (context, ref, child) {
                        final favorites = ref.watch(favoritesProvider);
                      return IconButton(
                        onPressed: (){
                          ref.read(favoritesProvider.notifier).toggleFavorite(product.id);
                        },
                        icon : Icon(favorites.contains(product.id) ? Icons.favorite : Icons.favorite_border,));
                    }
                  )
                ],
              ),
            ),
            Expanded(child: Image.asset(product.image, )),
            Container(
              padding: EdgeInsets.only(left: 24, right: 24, top: 26, bottom: 18),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Color(0xffE6E6E6 ), offset: Offset(0, -2), blurRadius: 12, spreadRadius: 5)],
                borderRadius: BorderRadius.vertical(top: Radius.circular(36))
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(product.name , style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                          Text(product.description, style: TextStyle(fontSize: 14, color: Colors.grey))
                        ],
                      ),
                      RichText(
                        text: TextSpan(
                          text: '\$', style: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(text: product.price.toString(), style: TextStyle(color: Colors.black))
                          ]
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 8,),
                  Divider(color: Color(0xffe6e6e6),),
                  SizedBox(height: 8,),
                  Text("Select Size", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SelectedSizeWidget(sizes : product.sizes),
                  SizedBox(height: 8,),
                  Text("Select Color", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SelectedColorWidget(colors : product.colors),
                  SizedBox(height: 18,), 
                  Spacer(),
                  Row(
                    children: [
                      Container(
                        width: 54,
                        height: 54,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Color(0xffe6e6e6))
                        ),
                        child: Center(
                          child: Icon(Icons.comment_outlined),
                        ),
                      ),
                      SizedBox(width: 8,),
                       Container(
                        width: 54,
                        height: 54,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Color(0xffe6e6e6))
                        ),
                        child: Center(
                          child: Icon(Icons.shopping_bag_outlined),
                        ),
                      ),
                      SizedBox(width: 8,),
                      
                      Expanded(
                        child: SizedBox(
                          height: 54,
                          child: Consumer(
                            builder: (context, ref, child) {
                              final cart = ref.read(cartProvider.notifier);
                              return ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll<Color>(Color(0xff111111)),
                                  shape: MaterialStatePropertyAll<RoundedRectangleBorder>( RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0), // Задайте бажаний радіус тут
              ),)
                                ),
                                
                                onPressed: (){
                                  cart.addItem(product.id, 1, product.price, _selectedSize, _selectedColor.toString());
                                }, child: Text("Add to cart", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),)
                              );
                            }
                          ),
                        )
                      )
                    ],
                  )
    
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
  late num _selectedColor = 0;

class SelectedColorWidget extends StatefulWidget {
  const SelectedColorWidget({
    super.key, required this.colors,
  });
final List<Color> colors;
  @override
  State<SelectedColorWidget> createState() => _SelectedColorWidgetState();
}

class _SelectedColorWidgetState extends State<SelectedColorWidget> {
  // final List _colors = [
  //   Color(0xff6DB7A2),
  //   Color(0xff111111),
  //   Color(0xffCECFD5),
  //    Color(0xffffffff),
  // ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical : 12.0),
      child: SizedBox(
        height: 48,
        child: ListView.builder(
          itemCount: widget.colors.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  _selectedColor = index;
                  setState(() {
                    
                  });
                },
                child: Container(
                  padding: _selectedColor == index ? EdgeInsets.all(2) : EdgeInsets.zero,
                  margin: const EdgeInsets.only(right: 12),
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      //strokeAlign:BorderSide.strokeAlignOutside,
                      color: _selectedColor == index ? Color(0xffFF5538) : Color(0xffe6e6e6)),
                    
                  ),
                  child: Container(
                  decoration : BoxDecoration(
                    color: widget.colors[index],
                    borderRadius: _selectedColor == index ? BorderRadius.circular(10) : BorderRadius.circular(11),)
                  ),
                  )
          )
        ),
      ),
    );
  }
}
late int _selectedSize = 0;
class SelectedSizeWidget extends StatefulWidget {
  const SelectedSizeWidget( {required this.sizes,  
    super.key,
  });
  final List<int>sizes;
  @override
  State<SelectedSizeWidget> createState() => _SelectedSizeWidgetState();
}

class _SelectedSizeWidgetState extends State<SelectedSizeWidget> {
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical : 12.0),
      child: SizedBox(
      height: 48,
        child: ListView.builder(
          itemCount: widget.sizes.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context,index) => GestureDetector(
            onTap: () {
              _selectedSize = index;
              setState(() {
                
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _selectedSize == index ? Color(0xffFF5538) : Color(0xffe6e6e6)),
                color: _selectedSize == index ? Color(0xffFF5538).withOpacity(0.4) : Colors.transparent
              ),
              child: Center(
                child: Text((widget.sizes[index]).toString(), style: TextStyle(fontSize: 16, color : _selectedSize == index ? Color(0xffFF5538) : Colors.black),),
              ),
            ),
          )
        ),
      ),
    );
  }
}