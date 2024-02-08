import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:testapp/models/product.dart';
import 'package:testapp/pages/cart.dart';
import 'package:testapp/pages/detail_product.dart';
import 'package:testapp/pages/serch_result_page.dart';
import 'package:testapp/provider/cart_provider.dart';
import 'package:http/http.dart' as http;

class MainAppBar extends StatefulWidget {
  MainAppBar({super.key});

  @override
  State<MainAppBar> createState() => _MainAppBarState();
}

class _MainAppBarState extends State<MainAppBar> {
  Future<List<Product>> _searchProducts(String query) async {
    if (query.length >= 3) {
      final response = await http
          .get(Uri.parse('http://192.168.0.108:3000/search/products?q=$query'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        print(data);
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        print('Failed to load search results');
        throw Exception('Failed to load search results');
      }
    } else {
      return [];
    }
  }

  final TextEditingController _searchController = TextEditingController();

  late String _selectedProduct;

  @override
  Widget build(BuildContext context) {
    // print(_searchProducts("nike"));
    //TextEditingController searchController = TextEditingController();
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
            child: TypeAheadField(
              textFieldConfiguration: TextFieldConfiguration(
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                onSubmitted: (value) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchResultsPage(query: value),
                    ),
                  );
                },
                controller: _searchController,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                    hoverColor: Color(0xfff6f6f6),
                    prefixIcon: Icon(Icons.search),
                    hintText: "Search",
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8)),

                    // suffixIconConstraints: BoxConstraints(maxHeight: 18),
                    suffix: Transform.translate(
                      offset: Offset(-5, 5),
                      child: GestureDetector(
                        child: Icon(
                          Icons.close,
                          size: 20,
                        ),
                        onTap: () {
                          _searchController.clear();
                        },
                      ),
                    )),
              ),
              suggestionsCallback: (pattern) async {
                return _searchProducts(pattern);
              },
              itemBuilder: (context, Product suggestion) {
                print('Selected Product: $suggestion');

                return ListTile(
                  title: Row(
                    children: [
                      Image.network(
                        suggestion.image[0],
                        width: 40,
                        height: 40,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            suggestion.name,
                            style: TextStyle(overflow: TextOverflow.ellipsis),
                          ),
                          Text(
                            "\$${suggestion.price}",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              transitionBuilder: (context, suggestionsBox, controller) =>
                  suggestionsBox,
              onSuggestionSelected: (Product suggestion) {
                _selectedProduct = suggestion.name;
                // Do something with the selected product
                print('Selected Product: $_selectedProduct');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailProduct(product: suggestion),
                  ),
                );
              },
            ),
          )),
          const SizedBox(
            width: 12,
          ),
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xfff6f6f6)),
            child: Center(child: Icon(Icons.notifications_outlined)),
          ),
          const SizedBox(
            width: 12,
          ),
          Consumer(builder: (context, ref, child) {
            final itemNum = ref.watch(cartProvider).items.length;
            return GestureDetector(
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => CartPage())),
              child: Center(
                child: Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0xfff6f6f6)),
                  child: Center(
                      child: Badge(
                          backgroundColor:
                              itemNum > 0 ? Colors.red : Colors.transparent,
                          label: itemNum > 0 ? Text(itemNum.toString()) : null,
                          child: Icon(Icons.shopping_bag_outlined))),
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}
