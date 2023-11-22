import 'package:flutter/material.dart';

class ModelListclass {
  final String title;
  final String image;

  ModelListclass({required this.title, required this.image});
}

class ListModels extends StatelessWidget {
  ListModels({super.key});
  final List <ModelListclass>listModel = [
    ModelListclass(title: "Nike", image: "assets/icons/nike.png"),
    ModelListclass(title: "Puma", image: "assets/icons/puma.png"),
    ModelListclass(title: "Adidas", image: "assets/icons/adidas.png"),
    ModelListclass(title: "NB", image: "assets/icons/nb.png"),
     ModelListclass(title: "Converse", image: "assets/icons/converse.png"),
  ]; 
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: listModel.length,
        padding: EdgeInsets.symmetric(horizontal: 18),
        separatorBuilder: (context, index) => const SizedBox(width: 12,),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context,index) => GestureDetector(
          onTap: () {
            print(index);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipOval(
                child: Container(
                  padding: EdgeInsets.all(8),
                  width: 60,
                  height: 60,
                  color: Color(0xfff6f6f6),
                  child: Image.asset(listModel[index].image)
                ),
              ),
              
              Text(listModel[index].title, style: TextStyle(fontWeight: FontWeight.bold),)
            ],
          ),
        ) 
      ),
    );
  }
}