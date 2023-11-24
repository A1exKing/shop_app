import 'package:photo_view/photo_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:testapp/models/product.dart';
import 'package:testapp/provider/cart_provider.dart';
import 'package:testapp/provider/favorite_provider.dart';

 
class DetailProduct extends StatefulWidget {
   DetailProduct( {super.key, required this.product,});
 final  Product product;

  @override
  State<DetailProduct> createState() => _DetailProductState();
}
late double  _currentPosition = 0;
class _DetailProductState extends State<DetailProduct> {
  late PageController _pageImageController = PageController(initialPage: 0);
  
  @override
  void initState() {
    _pageImageController.addListener(() {
      _currentPosition = _pageImageController.page!; 
      
   print(_currentPosition);
    } );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xffF1F1F1),Color(0xffF1F1F1)])
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 IconButton(onPressed: (){
                  Navigator.of(context).pop();
                 }, icon:  Icon(Icons.chevron_left, size: 32,),
                 ),
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
                          ref.read(favoritesProvider.notifier).toggleFavorite(widget.product.id);
                        },
                        icon : Icon(favorites.contains(widget.product.id) ? Icons.favorite : Icons.favorite_border,));
                    }
                  )
                ],
              ),
            ),
            Expanded (
              //height: 300,
              child: PageView.builder(
                controller: _pageImageController,
                itemCount: widget.product.image.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: (){
                    showDialog(context: context, builder: ((context) {
                    //  late int indexImage = index;
                      return Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: PhotoViewGallery.builder(
                        
                          backgroundDecoration: BoxDecoration(color: Colors.white, backgroundBlendMode: BlendMode.modulate),
                  scrollPhysics: const BouncingScrollPhysics(),
                  pageController: PageController(initialPage: index),
                  builder: (BuildContext context, int indexImage) {
                    
                    return PhotoViewGalleryPageOptions(
                      
                        minScale: PhotoViewComputedScale.contained,
                      maxScale: PhotoViewComputedScale.contained * 2,
                      imageProvider: NetworkImage(widget.product.image[indexImage]),
                      initialScale: PhotoViewComputedScale.contained * 1,
                      //heroAttributes: PhotoViewHeroAttributes(tag: galleryItems[index].id),
                    );
                    
                  },
                  itemCount: widget.product.image.length,
                  loadingBuilder: (context, event) => Center(
                    child: Container(
                      width: 20.0,
                      height: 20.0,
                      child: CircularProgressIndicator(
                        value: event == null
                ? 0
                : event.cumulativeBytesLoaded / event.expectedTotalBytes!.toInt(),
                      ),
                    ),
                  ),
                //  backgroundDecoration: widget.backgroundDecoration,
                //  pageController: widget.pageController,
                 // onPageChanged: onPageChanged,
                ),
                      );
                    }));
                  },
                  child: Hero(
                    transitionOnUserGestures: true,
                    tag: widget.product.image[0],
                    
                    child: Image.network(widget.product.image[index], )
                    ))
              )
            ),
           SmoothPageIndicator(  
            
   controller: _pageImageController,  // PageController  
   count:  widget.product.image.length,  
   effect:  WormEffect(dotHeight: 8, dotWidth: 8, dotColor: Color(0xffdddddd), activeDotColor : Color(0xff111111)),  // your preferred effect  
  //  onDotClicked: (index){  
         
  //  }  
) ,

SizedBox(height: 12,),
            Container(
              padding: EdgeInsets.only(left: 24, right: 24, top: 26, bottom: 18),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Color(0xffE6E6E6 ), offset: Offset(0, -2), blurRadius: 12, spreadRadius: 5)],
                borderRadius: BorderRadius.vertical(top: Radius.circular(36))
              ),
              child: ListView(
                padding: EdgeInsets.all(0),
               // crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        //mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(widget.product.name , style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                          
                        ],
                      ),
                      RichText(
                        text: TextSpan(
                          text: '\$', style: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(text: widget.product.price.toString(), style: TextStyle(color: Colors.black))
                          ]
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 8,),
                  Divider(color: Color(0xffe6e6e6),),
                  SizedBox(height: 8,),
                 
                  Text("Select Size", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SelectedSizeWidget(sizes : widget.product.sizes),
                  SizedBox(height: 8,),
                  Text("Select Color", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SelectedColorWidget(colors : widget.product.colors),
                  SizedBox(height: 12,), 
                   Text(widget.product.description, style: TextStyle(fontSize: 14, color: Colors.grey)),
                    SizedBox(height: 12,), 
               //   Spacer(),
                  
                
                ],
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(left: 18, right: 18, bottom: 12),
              child: Row(
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
                                    cart.addItem(widget.product.id, 1, widget.product.price, _selectedSize, _selectedColor.toString(), widget.product.image[0]);
                                  }, child: Text("Add to cart", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),)
                                );
                              }
                            ),
                          )
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