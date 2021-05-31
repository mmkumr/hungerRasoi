import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import "dart:convert";

class CategoryService{
    Firestore _firestore = Firestore.instance;
    String ref = "categories";

    Future<List<DocumentSnapshot>> getCategories(){
        return _firestore.collection(ref).getDocuments().then((snaps){
            return snaps.documents;
        });
    }
}