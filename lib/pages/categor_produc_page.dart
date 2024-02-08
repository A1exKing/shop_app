import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testapp/pages/detail_product.dart';
import 'package:testapp/provider/get_product.dart';

class CategoryProductsPage extends StatelessWidget {
  const CategoryProductsPage(this.title, {super.key});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            //  Navigator.of(context).pop();
          },
        ),
        title: Text(title),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final _products = ref.watch(productsOfCategoryProvider(title));
          return _products.when(
              data: (data) {
                return RefreshIndicator(
                  onRefresh: () async {
                    ref.refresh(productsOfCategoryProvider(title));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: data.length,
                        cacheExtent: 12,
                        semanticChildCount: 22,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisExtent: 222,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 12),
                        itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        DetailProduct(product: data[index])));
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    data[index].description,
                                    maxLines: 2,
                                    style: TextStyle(
                                        color: Colors.grey,
                                        overflow: TextOverflow.ellipsis),
                                  )
                                ],
                              ),
                            )),
                  ),
                );
              },
              error: (error, stackTrace) => Center(
                    child: Text(error.toString()),
                  ),
              loading: () => CircularProgressIndicator());
        },
      ),
    );
  }
}
