import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hungerrasoi/login.dart';

//User Defined Libraries
import 'package:hungerrasoi/widgets/categories.dart';
import 'package:hungerrasoi/widgets/loading.dart';
import 'db/category.dart';
import 'db/products.dart';
import 'widgets/image_carousel.dart';
import 'widgets/drawer.dart';
import 'widgets/categories.dart';
import 'widgets/products.dart';
import 'widgets/navbar.dart';
import 'package:hungerrasoi/provider/category_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  // ignore: must_call_super
  void initState() {
    _getProducts();
  }
  ProductsService _productsService = ProductsService();
  CategoryService _categoryService = CategoryService();
  List<DocumentSnapshot> products = <DocumentSnapshot>[];
  String category;
  @override
  Widget  build(BuildContext context) {
    _getProducts();
    return Scaffold(
      appBar: NavBar(
        key: Key('HungerRasoi'),
      ),
      // Defined in widgets/navbar.dart
      drawer: SideBar(),
      // Defined in widgets/drawer.dart
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 1.2,
          child: new Column(
            children: <Widget>[
              imageCarousel, // Defined in widgets/image_carousel.dart
              new Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Text(
                  'Categories',
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
              ),
              Categories(), // Defined in widgets/categories.dart
              new Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Text(category == null ? " " : category,
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
              ),
              Flexible(child: Products() // Defined in widgets/products.dart
                  ),
            ],
          ),
        ),
      ),
    );
  }

  _getProducts() async {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    List<DocumentSnapshot> data = await _productsService.getProducts(categoryProvider.category);
    setState(() {
      products = data;
      category = categoryProvider.category;
    });
  }

}
