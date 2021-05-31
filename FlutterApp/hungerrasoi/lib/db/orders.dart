import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class OrderService{
    Firestore _firestore = Firestore.instance;
    String collection = "users";
    List _productsForOrder = [];
    List get productsForOrder => _productsForOrder;

    void createOrderItem(Map data) {
        _firestore.collection(collection).document(data["userId"]).updateData({'order': data["order"]});
    }

    Future<List> getOrderItems(String userId){
        return _firestore.collection(collection).where('userId', isEqualTo: userId).getDocuments().then((snap) {
            _productsForOrder = snap.documents[0].data['order'];
            return snap.documents[0].data['order'];
        });
    }
}