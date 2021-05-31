import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hungerrasoi/models/products.dart';
import 'package:uuid/uuid.dart';
import "dart:convert";

class ProductsService {
  Firestore _firestore = Firestore.instance;
  String ref = "products";

  Future<List<DocumentSnapshot>> getProducts(String category) {
    return _firestore
        .collection(ref)
        .where('category', isEqualTo: category)
        .getDocuments()
        .then((snap) {
      return snap.documents;
    });
  }
}
