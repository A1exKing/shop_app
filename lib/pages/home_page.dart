import 'package:flutter/material.dart';
import 'package:testapp/widgets/banner.dart';
import 'package:testapp/widgets/main_app_bar.dart';
import 'package:testapp/widgets/model_list.dart';
import 'package:testapp/widgets/popular_list.dart';
import 'package:testapp/widgets/today_sale.dart';



class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
         
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 48,),
                MainAppBar(),
                const SizedBox(height: 18,),
                BannerWidget(),
                const SizedBox(height: 18,),
                ListModels(),
                 const SizedBox(height: 12,),
                TodaySale(),
                const SizedBox(height: 12,),
                PopularList()
              ],
            ),
          ),
           Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 1,
              width: double.infinity,
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: Colors.white, blurRadius: 12, spreadRadius: 20, )]
              ),
            ),
          ),
        ],
      ),
    );
  }
}
