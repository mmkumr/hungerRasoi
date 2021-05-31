import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hungerrasoi/db/category.dart';
import 'package:hungerrasoi/home.dart';
import 'package:hungerrasoi/provider/category_provider.dart';
import 'package:provider/provider.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  // ignore: must_call_super
  void initState() {
    _getCategoriess();
  }

  CategoryService _categoryService = CategoryService();
  List<DocumentSnapshot> categories = <DocumentSnapshot>[];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160.0,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (BuildContext context, int index) {
            return Category(
              imageCaption: categories[index].data["category"],
              imageLocation: categories[index].data["image"],
            );
          }),
    );
  }

  _getCategoriess() async {
    List<DocumentSnapshot> data = await _categoryService.getCategories();
    final category = Provider.of<CategoryProvider>(context);
    setState(() {
      categories = data;
    });
    category.setCategory(categories[0].data["category"]);
  }
}

class Category extends StatelessWidget {
  final String imageLocation;
  final String imageCaption;

  Category({this.imageLocation, this.imageCaption});

  @override
  Widget build(BuildContext context) {
    final category = Provider.of<CategoryProvider>(context);
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(0.0),
          child: InkWell(
            onTap: () {
              category.setCategory(imageCaption);
            },
            child: Container(
              width: 150.0,
              height: 150,
              child: ListTile(
                contentPadding: const EdgeInsets.all(2.0),
                title: Container(
                  height: 120,
                  width: 100,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: new NetworkImage(imageLocation),
                      )),
                ),
                /*Image.asset(
                  imageLocation,
                  height: 100.0,
                  width: 100.0,
                ),*/
                subtitle: Container(
                  alignment: Alignment.topCenter,
                  child: Text(
                    imageCaption,
                    style: new TextStyle(fontSize: 12.0),
                  ),
                ),
              ),
            ),
          ),
        ),

      ],
    );
  }
}
