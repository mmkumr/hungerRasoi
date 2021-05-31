import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
    static const ID = "id";
    static const NAME = "name";
    static const PRICE = "price";
    static const BRAND = "brand";
    static const SIZES = "sizes";
    static const CATEGORY = "category";
    static const IMAGE_URL = "imageUrl";

    String _id;
    String _name;
    double _price;
    String _brand;
    List _sizes;
    String _category;
    List _imageUrl;
    String description;

    String get id => _id;
    String get name => _name;
    double get price => _price;
    String get brand => _brand;
    List get sizes => _sizes;
    String get category => _category;
    List get imageUrl => _imageUrl;

    Product.fromSnapshot(DocumentSnapshot snapshot){
        Map data = snapshot.data;
        _id = data[ID];
        _name = data[NAME];
        _category = data[CATEGORY];
        _brand = data[BRAND];
        _sizes = data[SIZES];
        _price = data[PRICE];
        _imageUrl = data[IMAGE_URL];
    }
}