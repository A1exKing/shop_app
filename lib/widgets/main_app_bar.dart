import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testapp/pages/cart.dart';
import 'package:testapp/provider/cart_provider.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color(0xfff6f6f6),
              ),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                  hoverColor: Color(0xfff6f6f6),
                  prefixIcon: Icon(Icons.search),
                  hintText: "Search",
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8)
                  )
                ),
              ),
            )
          ),
          const SizedBox(width: 12,),
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color(0xfff6f6f6)
            ),
            child: 
                Center(
                  child: Badge(
                    backgroundColor: Colors.red,
                    child: Icon(Icons.notifications_outlined)
                  )
                ),
                
          ),
         const SizedBox(width: 12,),
          Consumer(
            builder:  (context, ref, child) {
              final itemNum = ref.watch(cartProvider).items.length;
              return GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => CartPage())),
                child: Center(
                  child: Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0xfff6f6f6)
                    ),
                    child: Center(child: 
                    Badge(
                      backgroundColor: itemNum > 0? Colors.red : Colors.transparent,
                      label: itemNum > 0? Text(itemNum.toString()) : null,
                      child: Icon(Icons.shopping_bag_outlined))),
                  ),
                ),
              );
            }
          )
        ],
      ),
    );
  }
}