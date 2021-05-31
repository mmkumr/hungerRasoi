import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier{
    Firestore _firestore = Firestore.instance;
    String collection = "users";
    List _productsInCart = [];
    List get productsInCart => _productsInCart;

    void createCartItem(Map data) {
        _firestore.collection(collection).document(data["userId"]).updateData({'cart': data["cart"]});
    }

    Future<List> getCarItems(String userId){
        return _firestore.collection(collection).where('userId', isEqualTo: userId).getDocuments().then((snap) {
            _productsInCart = snap.documents[0].data['cart'];
            notifyListeners();
            return snap.documents[0].data['cart'];
        });
    }
}