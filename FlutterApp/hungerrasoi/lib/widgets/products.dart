import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hungerrasoi/db/category.dart';
import 'package:hungerrasoi/db/products.dart';
import 'package:hungerrasoi/models/products.dart';
import 'package:hungerrasoi/provider/category_provider.dart';
import 'package:provider/provider.dart';

//User Defined library
import 'package:hungerrasoi/product_details.dart';
import 'package:hungerrasoi/widgets/loading.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
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
  Widget build(BuildContext context) {
    _getProducts();
    return GridView.builder(
      scrollDirection: Axis.vertical,
      itemCount: products.length,
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return Product(
          id: products[index].data["id"],
          name: products[index].data["name"],
          price: products[index].data['price'],
          oldPrice: products[index].data['price'] + (products[index].data['price'] * (20 / 100)).roundToDouble(),
          brand: products[index].data['brand'],
          weights: products[index].data['weights'],
          category: products[index].data['category'],
          description: products[index].data['description'],
          imageUrl: products[index].data['images'],
        );
      },
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

class Product extends StatelessWidget {
  String id;
  String name;
  double price;
  double oldPrice;
  String brand;
  List weights;
  String category;
  List imageUrl;
  String description;

  Product({
    this.id,
    this.name,
    this.price,
    this.oldPrice,
    this.brand,
    this.weights,
    this.category,
    this.imageUrl,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
          tag: id,
          child: Material(
            child: InkWell(
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (context) => new ProductDetails(
                        productDetailsBrand: brand,
                        productDetailsCategory: category,
                        productDetailsDescription: description,
                        productDetailsId: id,
                        productDetailsImageUrl: imageUrl,
                        productDetailsName: name,
                        productDetailsOldPrice: oldPrice,
                        productDetailsPrice: price,
                        productDetailsWeights: weights,
                      ))),
              child: GridTile(
                footer: Container(
                  color: Colors.white70,
                  height: 70.0,
                  child: ListTile(
                    leading: Text(
                      name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    title: Text(
                      "\₹$price",
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.w800),
                    ),
                    subtitle: Text(
                      "\₹$oldPrice",
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w800,
                          decoration: TextDecoration.lineThrough),
                    ),
                  ),
                ),
                child: Image.network(imageUrl[0])
              ),
            ),
          )),
    );
  }
}
