import 'package:algolia/algolia.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import "dart:convert";

class ProductService{
    Firestore _firestore = Firestore.instance;
    String ref = "products";
    Algolia _algoliaApp = Algolia.init(
        applicationId: 'S2QL0W253N', //ApplicationID,
        apiKey: 'e0822eec57b14c80124ae86ca36ae5fc', //search-only api key in flutter code
    );
    void uploadProduct(String productName, String description, String brand, String category, int quantity, List weights, List images, double price,){
        var id = Uuid();
        String productId = id.v1();
        _algoliaApp.instance.index("products").addObject(
            {
                "id": productId,
                "name": productName,
                "brand": brand,
                "category": category,
                "quantity": quantity,
                "weights": weights,
                "images": images,
                "price": price,
                "description": description,
            }
        );
        _algoliaApp.instance.index("products").search("he");
        _firestore.collection(ref).document(productId).setData({
            "id": productId,
            "name": productName,
            "brand": brand,
            "category": category,
            "quantity": quantity,
            "weights": weights,
            "images": images,
            "price": price,
            "description": description,
        });
    }

    Future<List<DocumentSnapshot>> getCategories(){
        return _firestore.collection(ref).getDocuments().then((snaps){
            return snaps.documents;
        });
    }
}