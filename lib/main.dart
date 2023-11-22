import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testapp/pages/favorite_page.dart';
import 'package:testapp/pages/home_page.dart';
import 'package:testapp/widgets/bottom_nav_bar.dart';

void main() {
  runApp( ProviderScope(child: MyApp()));
}
final PageController pageNavController = PageController(initialPage: 0);
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Test App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: Scaffold(
        bottomNavigationBar: NavBar(),
        body: PageView(
          controller: pageNavController,
         // onPageChanged: _onPageChanged,
          children: <Widget>[
            HomePage(),
            Scaffold(body: Center(child: Text("2"))),
            FavoritePage(),
            Scaffold(body: Center(child: Text("4"))),
          ],
        ),
      )
    );
  }
}
