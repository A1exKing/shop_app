
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:testapp/main.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
   int _selectedItemPosition = 0;
  @override
  Widget build(BuildContext context) {
    return SnakeNavigationBar.color(
      
        padding: EdgeInsets.symmetric(horizontal: 18),
        behaviour:  SnakeBarBehaviour.pinned,
        snakeShape: SnakeShape.circle,
        shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(35)),
  ),
        backgroundColor: Color(0xff111111),
        snakeViewColor: Color(0xffFF5538),
        unselectedItemColor: Color(0xfff6f6f6),
        currentIndex: _selectedItemPosition,
        onTap: (index) => setState(() {
          pageNavController.animateToPage(
            index,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
          _selectedItemPosition = index;
        } ),
        items: [
          BottomNavigationBarItem(icon:  Image.asset( _selectedItemPosition == 0 ? "assets/icons/home_active.png" : "assets/icons/home.png", color: Colors.white, width: 26,), label: 'home'),
          BottomNavigationBarItem(icon:  Image.asset( _selectedItemPosition == 1 ? "assets/icons/order_active.png" : "assets/icons/order.png", color: Colors.white, width: 26,), label: 'calendar'),
           BottomNavigationBarItem(icon:  Image.asset( _selectedItemPosition == 2 ? "assets/icons/favorite_active.png" : "assets/icons/favorite.png", color: Colors.white, width: 26,), label: 'microphone'),
          BottomNavigationBarItem(icon:  Image.asset( _selectedItemPosition == 3 ? "assets/icons/chat_active.png" : "assets/icons/chat.png", color: Colors.white, width: 26,), label: 'microphone'),
       BottomNavigationBarItem(icon:  Image.asset( _selectedItemPosition == 4 ? "assets/icons/profile_active.png" : "assets/icons/profile.png", color: Colors.white, width: 26,), label: 'microphone'),
        ],
      );
  }
}