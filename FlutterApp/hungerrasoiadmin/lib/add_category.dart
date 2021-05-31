import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hungerrasoiadmin/admin.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'db/category.dart';

class AddCategory extends StatefulWidget {
  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  TextEditingController categoryController = TextEditingController();
  GlobalKey<FormState> _categoryFormKey = GlobalKey();
  CategoryService _categoryService = CategoryService();

  bool isLoading = false;
  File _image1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.close,
              color: Colors.black,
            )),
        title: Text(
          "Add Category",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: isLoading
          ? CircularProgressIndicator()
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 200,
                child: Form(
                  key: _categoryFormKey,
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        OutlineButton(
                          borderSide: BorderSide(
                              color: Colors.grey.withOpacity(0.8), width: 1.0),
                          onPressed: () {
                            _selectImage(ImagePicker.pickImage(
                                source: ImageSource.gallery));
                          },
                          child: _displayImage(),
                        ),
                        TextFormField(
                          controller: categoryController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'category cannot be empty';
                            }
                          },
                          decoration: InputDecoration(hintText: "Category"),
                        ),
                        FlatButton(
                            color: Colors.red,
                            onPressed: () {
                              if (categoryController.text != null) {
                                validateAndUpload();
                                //_categoryService.createCategory(categoryController.text);
                              }
                            },
                            child: Text('ADD')),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Widget _displayImage() {
    if (_image1 != null) {
      return Image.file(
        _image1,
        fit: BoxFit.fill,
        width: 70,
        height: 70,
      );
    } else {
      return Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 35.0, 8.0, 35.0),
        child: Icon(
          Icons.add,
          color: Colors.grey,
        ),
      );
    }
  }

  _selectImage(Future<File> pickImage) async {
    File temp = await pickImage;
    setState(() => _image1 = temp);
  }

  void validateAndUpload() async {
    if (categoryController.text != null) {
      if (_image1 != null) {
        setState(() => isLoading = true);
        final FirebaseStorage storage = FirebaseStorage.instance;
        String imageUrl;
        final String picture1 =
            "1${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
        StorageUploadTask task1 =
            storage.ref().child(picture1).putFile(_image1);
        task1.onComplete.then((snapshot1) async {
          imageUrl = await snapshot1.ref.getDownloadURL();
          String imageList = imageUrl;
          _categoryService.createCategory(categoryController.text, imageUrl);
          setState(() => isLoading = false);
          _categoryFormKey.currentState.reset();
          Navigator.push(context, MaterialPageRoute(builder: (context) => Admin()));
          Fluttertoast.showToast(msg: "Category added.");
        });
      } else {
        Fluttertoast.showToast(msg: "Provide any one image.");
      }
    }
  }
}
