import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hungerrasoiadmin/db/brand.dart';
import 'package:hungerrasoiadmin/db/product.dart';
import 'package:image_picker/image_picker.dart';
import 'db/category.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  Color white = Colors.white;
  Color black = Colors.black;
  Color grey = Colors.grey;
  Color red = Colors.red;
  CategoryService _categoryService = CategoryService();
  ProductService _productService = ProductService();
  BrandService _brandService = BrandService();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController price = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController quantity = TextEditingController();
  List<DocumentSnapshot> categories = <DocumentSnapshot>[];
  List<DocumentSnapshot> brands = <DocumentSnapshot>[];
  List<DropdownMenuItem<String>> categoriesDropDown =
      <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> brandsDropDown = <DropdownMenuItem<String>>[];
  String currentCategory;
  String currentBrand;
  List<String> selectedWeights = <String>[];
  File _image1;
  File _image2;
  File _image3;
  bool isLoading = false;

  @override
  // ignore: must_call_super
  void initState() {
    _getCategories();
    _getBrands();
  }
  

  List<DropdownMenuItem<String>> getCategoriesDropDown() {
    List<DropdownMenuItem<String>> items = new List();
    for (int i = 0; i < categories.length; i++) {
      setState(() {
        items.insert(
            0,
            DropdownMenuItem(
              child: Text(categories[i].data['category']),
              value: categories[i].data['category'],
            ));
      });
    }
    return items;
  }

  List<DropdownMenuItem<String>> getBrandsDropDown() {
    List<DropdownMenuItem<String>> items = new List();
    for (int i = 0; i < brands.length; i++) {
      setState(() {
        items.insert(
            0,
            DropdownMenuItem(
              child: Text(brands[i].data['brand']),
              value: brands[i].data['brand'],
            ));
      });
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        backgroundColor: white,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.close,
              color: black,
            )),
        title: Text(
          "Add Product",
          style: TextStyle(color: black),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: isLoading ? Center(child: CircularProgressIndicator()) : Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: OutlineButton(
                          borderSide: BorderSide(
                              color: grey.withOpacity(0.8), width: 1.0),
                          onPressed: () {
                            _selectImage(
                                ImagePicker.pickImage(
                                    source: ImageSource.gallery),
                                3);
                          },
                          child: _displayChild1()
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Enter the Product name\(max 10 characters\).",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: red, fontSize: 16.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: name,
                  decoration: InputDecoration(hintText: "Product Name"),
                  // ignore: missing_return
                  validator: (value) {
                    if (value.isEmpty) {
                      return "You must enter the product name.";
                    } else if (value.length > 10) {
                      return "Product name can't have more than 10 letters.";
                    }
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Description.",
                  textAlign: TextAlign.left,
                  style: TextStyle(color: red, fontSize: 16.0),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 5,
                  controller: description,
                  decoration: InputDecoration(hintText: "Description"),
                  // ignore: missing_return
                  validator: (value) {
                    if (value.isEmpty) {
                      return "You must enter the description for the product.";
                    }
                  },
                ),
              ),
              
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "Category",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: red, fontSize: 16.0),
                        ),
                      ),
                      Expanded(
                        child: DropdownButton(
                          items: categoriesDropDown,
                          onChanged: changeSelectCategory,
                          value: currentCategory,
                        ),
                      ),
                    ],
                  )),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "Brand",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: red, fontSize: 16.0),
                        ),
                      ),
                      Expanded(
                        child: DropdownButton(
                          items: brandsDropDown,
                          onChanged: changeSelectBrand,
                          value: currentBrand,
                        ),
                      ),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: quantity,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: "Quantity"),
                  // ignore: missing_return
                  validator: (value) {
                    if (value.isEmpty) {
                      return "You must enter the quantity.";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: price,
                  keyboardType: TextInputType.number,
                  decoration:
                      InputDecoration(hintText: "Price"),
                  // ignore: missing_return
                  validator: (value) {
                    if (value.isEmpty) {
                      return "You must enter the price value.";
                    }
                  },
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    Checkbox(
                        value: selectedWeights.contains("0.5 Kg"),
                        onChanged: (value) => changeSelectWeight("0.5 Kg")),
                    Text("0.5 Kg"),
                    Checkbox(
                        value: selectedWeights.contains("1 Kg"),
                        onChanged: (value) => changeSelectWeight("1 Kg")),
                    Text("1 Kg"),
                    Checkbox(
                        value: selectedWeights.contains("1.5 Kg"),
                        onChanged: (value) => changeSelectWeight("1.5 Kg")),
                    Text("1.5 Kg"),
                    Checkbox(
                        value: selectedWeights.contains("2 Kg"),
                        onChanged: (value) => changeSelectWeight("2 Kg")),
                    Text("2 Kg"),
                    Checkbox(
                        value: selectedWeights.contains("2.5 Kg"),
                        onChanged: (value) => changeSelectWeight("2.5 Kg")),
                    Text("2.5 Kg"),
                    Checkbox(
                        value: selectedWeights.contains("3 Kg"),
                        onChanged: (value) => changeSelectWeight("3 Kg")),
                    Text("3 Kg"),
                    Checkbox(
                        value: selectedWeights.contains("3.5 Kg"),
                        onChanged: (value) => changeSelectWeight("3.5 Kg")),
                    Text("3.5 Kg"),
                    Checkbox(
                        value: selectedWeights.contains("4 Kg"),
                        onChanged: (value) => changeSelectWeight("4 Kg")),
                    Text("4 Kg"),
                    Checkbox(
                        value: selectedWeights.contains("4.5 Kg"),
                        onChanged: (value) => changeSelectWeight("4.5 Kg")),
                    Text("4.5 Kg"),
                    Checkbox(
                        value: selectedWeights.contains("5 Kg"),
                        onChanged: (value) => changeSelectWeight("5 Kg")),
                    Text("5 Kg"),
                  ],
                ),
              ),
              FlatButton(
                color: Colors.red,
                textColor: Colors.white,
                onPressed: () {
                  validateAndUpload();
                },
                child: Text("Add Product"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _getCategories() async {
    List<DocumentSnapshot> data = await _categoryService.getCategories();
    setState(() {
      categories = data;
      categoriesDropDown = getCategoriesDropDown();
      currentCategory = categories[0].data['category'];
    });
  }

  changeSelectCategory(String selectedCategory) {
    setState(() => currentCategory = selectedCategory);
  }

  _getBrands() async {
    List<DocumentSnapshot> data = await _brandService.getBrands();
    setState(() {
      brands = data;
      brandsDropDown = getBrandsDropDown();
      currentBrand = brands[0].data['brand'];
    });
  }

  changeSelectBrand(String selectedBrand) {
    setState(() => currentBrand = selectedBrand);
  }

  changeSelectWeight(String weight) {
    if (selectedWeights.contains(weight)) {
      setState(() {
        selectedWeights.remove(weight);
      });
    } else {
      setState(() {
        selectedWeights.insert(0, weight);
      });
    }
  }

  _selectImage(Future<File> pickImage, int imageNumber) async {
    File temp = await pickImage;
    switch (imageNumber) {
      case 1:
        setState(() => _image1 = temp);
        break;
      case 2:
        setState(() => _image2 = temp);
        break;
      case 3:
        setState(() => _image3 = temp);
        break;
    }
  }

  Widget _displayChild1() {
    if (_image1 == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 35.0, 8.0, 35.0),
        child: Icon(
          Icons.add,
          color: grey,
        ),
      );
    } else {
      return Image.file(
        _image1,
        fit: BoxFit.fill,
        width: 70,
        height: 70,
      );
    }
  }

  void validateAndUpload() async {
    if (_formKey.currentState.validate()) {
      setState(() => isLoading = true);
      if (_image1 != null) {
        final FirebaseStorage storage = FirebaseStorage.instance;
        String imageUrl1;
        final String picture1 =
            "1${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
        StorageUploadTask task1 =
            storage.ref().child(picture1).putFile(_image1);

        task1.onComplete.then((snapshot1) async {
          imageUrl1 = await snapshot1.ref.getDownloadURL();
          List<String>imageList = [imageUrl1];
          _productService.uploadProduct(
              name.text,
              description.text,
              currentBrand,
              currentCategory,
              int.parse(quantity.text),
              selectedWeights,
              imageList,
              double.parse(price.text));
          setState(() => isLoading = false);
          _formKey.currentState.reset();
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "Product added.");
        });
      } else {
        Fluttertoast.showToast(msg: "Provide any one image.");
      }
    }
  }
}
