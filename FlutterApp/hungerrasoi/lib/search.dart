import 'dart:async';
import 'package:algolia/algolia.dart';
import 'package:flutter/material.dart';
import 'package:hungerrasoi/product_details.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final Algolia _algoliaApp = Algolia.init(
    applicationId: 'S2QL0W253N', //ApplicationID
    apiKey:
        '226dcf955212b758d80b1ed68f4cf043', //search-only api key in flutter code
  );
  String _searchTerm;

  Future<List<AlgoliaObjectSnapshot>> _operation(String input) async {
    AlgoliaQuery query = _algoliaApp.instance.index("products").search(input);
    AlgoliaQuerySnapshot querySnap = await query.getObjects();
    List<AlgoliaObjectSnapshot> results = querySnap.hits;
    return results;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: new AppBar(
          backgroundColor: Colors.green,
          leading: new IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Material(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          elevation: 0.0,
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: TextField(
              onChanged: (val) {
                setState(() {
                  _searchTerm = val;
                });
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search",
                icon: Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
      body: StreamBuilder<List<AlgoliaObjectSnapshot>>(
        stream: Stream.fromFuture(_operation(_searchTerm)),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    "Start Typing",
                    style: TextStyle(color: Colors.black),
                ),
              );
          } else {
            List<AlgoliaObjectSnapshot> currSearchStuff = snapshot.data;

            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Container(
                    child:  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("searching.....", textAlign: TextAlign.center,),
                    )
                );
              default:
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                else
                  return CustomScrollView(
                    shrinkWrap: true,
                    slivers: <Widget>[
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return _searchTerm.length > 0
                                ? DisplaySearchResult(
                                    images:
                                        currSearchStuff[index].data["images"],
                                    name: currSearchStuff[index].data["name"],
                                    price: currSearchStuff[index].data["price"],
                                    quantity:
                                        currSearchStuff[index].data["quantity"],
                                    id: currSearchStuff[index].data["id"],
                                    category:
                                        currSearchStuff[index].data["category"],
                                    description: currSearchStuff[index]
                                        .data["description"],
                                    brand: currSearchStuff[index].data["brand"],
                                    weights:
                                        currSearchStuff[index].data["weights"],
                                  )
                                : Container();
                          },
                          childCount: currSearchStuff.length ?? 0,
                        ),
                      ),
                    ],
                  );
            }
          }
        },
      ),
    );
  }
}

class DisplaySearchResult extends StatelessWidget {
  final List images;
  final String name;
  final double price;
  final int quantity;
  final String id;
  final String description;
  final String category;
  final String brand;
  final List weights;

  DisplaySearchResult(
      {Key key,
      this.images,
      this.price,
      this.name,
      this.quantity,
      this.id,
      this.weights,
      this.category,
      this.description,
      this.brand})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetails(
                      productDetailsPrice: price,
                      productDetailsOldPrice:
                          (price * (20 / 100)).roundToDouble(),
                      productDetailsName: name,
                      productDetailsImageUrl: images,
                      productDetailsId: id,
                      productDetailsDescription: description,
                      productDetailsCategory: category,
                      productDetailsBrand: brand,
                      productDetailsWeights: weights,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 20),
        child: Column(children: <Widget>[
          Row(
            children: <Widget>[
              Image.network(
                images[0],
                cacheWidth: 50,
                cacheHeight: 50,
              ),
              Column(
                children: <Widget>[
                  Text(
                    "Name: $name" ?? "",
                    style: TextStyle(color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Price: Rs. $price  " ?? "",
                        style: TextStyle(color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Quantity: $quantity" ?? "",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
          Divider(
            color: Colors.black,
          ),
          SizedBox(height: 2)
        ]),
      ),
    );
  }
}
