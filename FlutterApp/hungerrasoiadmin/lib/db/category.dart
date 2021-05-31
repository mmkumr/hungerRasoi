import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import "dart:convert";

class CategoryService{
  Firestore _firestore = Firestore.instance;
  String ref = "categories";

  void createCategory(String name, String imageUrl){
    var id = Uuid();
    String categoryId = id.v1();

    _firestore.collection('categories').document(categoryId).setData({'category': name, "image": imageUrl});
  }
  Future<List<DocumentSnapshot>> getCategories(){
    return _firestore.collection(ref).getDocuments().then((snaps){
      return snaps.documents;
    });
  }
}