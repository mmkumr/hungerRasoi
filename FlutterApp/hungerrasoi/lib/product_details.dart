import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hungerrasoi/login.dart';
import 'package:hungerrasoi/provider/cart_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'provider/user_provider.dart';

//User Defined Libraries
import 'widgets/navbar.dart';
import 'widgets/drawer.dart';

class ProductDetails extends StatefulWidget {
  String productDetailsId;
  String productDetailsName;
  double productDetailsPrice;
  double productDetailsOldPrice;
  String productDetailsBrand;
  List productDetailsWeights;
  String productDetailsCategory;
  List productDetailsImageUrl;
  String productDetailsDescription;

  ProductDetails({
    this.productDetailsId,
    this.productDetailsName,
    this.productDetailsPrice,
    this.productDetailsOldPrice,
    this.productDetailsBrand,
    this.productDetailsWeights,
    this.productDetailsCategory,
    this.productDetailsImageUrl,
    this.productDetailsDescription,
  });

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  List<DropdownMenuItem<String>> quantityDropDown =
      <DropdownMenuItem<String>>[];
  String currentQuantity;
  List<DropdownMenuItem<String>> weightDropDown = <DropdownMenuItem<String>>[];
  List weights = [];
  String currentWeight;
  DateTime _date = new DateTime.now();
  TimeOfDay _time = new TimeOfDay.now();
  String dateTime;
  TimeOfDay timePicked;

  @override
  // ignore: must_call_super
  void initState() {
    _getQuantity();
    _getWeight();
  }

  Future _selectDateTime(BuildContext context) async {
    final DateTime datePicked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: new DateTime.now(),
        lastDate: new DateTime(DateTime.now().year + 1));

    if (datePicked != null) {
      if (datePicked.day == DateTime.now().day &&
          datePicked.month == DateTime.now().month &&
          datePicked.year == DateTime.now().year) {
        timePicked = await showTimePicker(
            context: context,
            initialTime: TimeOfDay(
                hour: TimeOfDay.now().hour + 1, minute: TimeOfDay.now().minute));
        if (timePicked != null && timePicked != _time) {
          setState(() {
            _time = timePicked;
          });
        }
      } else{
        timePicked = await showTimePicker(
            context: context,
            initialTime: _time);
        if (timePicked != null && timePicked != _time) {
          setState(() {
            _time = timePicked;
          });
        }
      }
      setState(() {
        _date = datePicked;
        dateTime =
            _date.toString().substring(0, _date.toString().indexOf(" ")) +
                " " +
                _time.toString().substring(_time.toString().indexOf("(") + 1,
                    _time.toString().indexOf(")"));
      });
    }
  }

  List<DropdownMenuItem<String>> getQuantiyDropDown() {
    List<DropdownMenuItem<String>> items = new List();
    for (int i = 1; i < 9; i++) {
      setState(() {
        items.insert(
            i - 1,
            DropdownMenuItem(
              child: Text(i.toString()),
              value: i.toString(),
            ));
      });
    }
    return items;
  }

  List<DropdownMenuItem<String>> getWeightDropDown() {
    List<DropdownMenuItem<String>> items = new List();
    for (int i = 0; i < weights.length; i++) {
      setState(() {
        items.insert(
            0,
            DropdownMenuItem(
              child: Text(weights[i]),
              value: weights[i],
            ));
      });
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final cart = Provider.of<CartProvider>(context);
    _getCartItems() async {
      List data = await cart.getCarItems(user.user.uid);
    }

    List cartItems = [];
    _getCartItems();
    for (int i = 0; i < cart.productsInCart.length; ++i) {
      setState(() {
        cartItems.insert(i, cart.productsInCart[i]);
      });
    }
    return Scaffold(
      appBar: NavBar(
        key: Key(widget.productDetailsName),
      ),
      // Defined in widgets/navbar.dart
      drawer: SideBar(),
      // Defined in widgets/drawer.dart
      body: new ListView(
        children: <Widget>[
          Container(
            height: 300,
            child: GridTile(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.productDetailsImageUrl.length,
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1),
                    itemBuilder: (BuildContext context, int index) {
                      return Image.network(
                          widget.productDetailsImageUrl[index]);
                    }),
              ),
              footer: Container(
                color: Colors.black38,
                height: 70.0,
                child: ListTile(
                  leading: Column(
                    children: <Widget>[
                      Text(
                        widget.productDetailsName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          "Category: ${widget.productDetailsCategory}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  title: Text(
                    "\₹${widget.productDetailsPrice}",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.w800),
                  ),
                  subtitle: Text(
                    "\₹${widget.productDetailsOldPrice}",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w800,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ),
              ),
            ),
          ),
          //Dropdown menus.
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  //Dropdown menu for weight.
                  Expanded(
                      child: MaterialButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return new AlertDialog(
                            title: new Text(
                              'Weight',
                              textAlign: TextAlign.center,
                            ),
                            content: Column(
                              children: <Widget>[
                                new Text('Choose the Weight.'),
                                DropdownButton(
                                  items: weightDropDown,
                                  onChanged: changeSelectWeight,
                                  value: currentWeight,
                                ),
                              ],
                            ),
                            actions: <Widget>[
                              new MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).pop(context);
                                },
                                child: new Text('Close'),
                              )
                            ],
                          );
                        },
                      );
                    },
                    color: Colors.white,
                    textColor: Colors.black,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: currentWeight != null
                                ? new Text(
                                    "${currentWeight}",
                                    textAlign: TextAlign.center,
                                  )
                                : new Text('Weight')),
                        Expanded(child: new Icon(Icons.arrow_drop_down)),
                      ],
                    ),
                  )),
                  //Dropdown menu for quantity.
                  Expanded(
                      child: MaterialButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return new AlertDialog(
                            title: new Text(
                              'Quantity',
                              textAlign: TextAlign.center,
                            ),
                            content: Column(
                              children: <Widget>[
                                new Text('Choose the Quantity.'),
                                DropdownButton(
                                  items: quantityDropDown,
                                  onChanged: changeSelectQuantiy,
                                  value: currentQuantity,
                                ),
                              ],
                            ),
                            actions: <Widget>[
                              new MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).pop(context);
                                },
                                child: new Text('Close'),
                              )
                            ],
                          );
                        },
                      );
                    },
                    color: Colors.white,
                    textColor: Colors.black,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: currentQuantity != null
                                ? new Text(
                                    "${currentQuantity}",
                                    textAlign: TextAlign.center,
                                  )
                                : new Text('Quantity')),
                        Expanded(child: new Icon(Icons.arrow_drop_down)),
                      ],
                    ),
                  )),
                ],
              ),
              Text(
                "*Delivery time must be after 1 hour or more than 1 hour.",
                style: TextStyle(color: Colors.red),
              ),
              MaterialButton(
                onPressed: () {
                  _selectDateTime(context);
                },
                color: Colors.white,
                textColor: Colors.black,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: dateTime == null
                          ? new Text(
                              "Select Time and Date",
                              textAlign: TextAlign.center,
                            )
                          : new Text(dateTime),
                    ),
                    Expanded(child: new Icon(Icons.arrow_drop_down)),
                  ],
                ),
              )
            ],
          ),
          Visibility(
            visible: currentQuantity != null &&
                currentWeight != null &&
                dateTime != null,
            child: Row(
              children: <Widget>[
                Expanded(
                    child: MaterialButton(
                  onPressed: () {},
                  color: Colors.red,
                  textColor: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: new Text(
                          'Buy',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                )),
                new IconButton(
                    icon: Icon(Icons.add_shopping_cart),
                    color: Colors.red,
                    onPressed: () {
                      if (user.status == Status.Authenticated) {
                        bool same = false;
                        for (int i = 0; i < cartItems.length; ++i) {
                          if (cartItems[i]["id"] == widget.productDetailsId) {
                            Fluttertoast.showToast(
                                msg: "Item already exist in cart.");
                            same = true;
                          }
                        }
                        if (same == false) {
                          cartItems.insert(0, {
                            "id": widget.productDetailsId,
                            "image": widget.productDetailsImageUrl,
                            "name": widget.productDetailsName,
                            "price": widget.productDetailsPrice,
                            "quantity": currentQuantity,
                            "weight": currentWeight,
                            "timeOfDelivery": dateTime,
                          });
                          cart.createCartItem(
                              {"userId": user.user.uid, "cart": cartItems});
                          Fluttertoast.showToast(msg: "Item added to cart.");
                        }
                      } else {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      }
                    }),
              ],
            ),
          ),
          Divider(),
          new ListTile(
            title: new Text(
              'Product Description',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: new Text(
              "${widget.productDetailsDescription}",
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }

  _getQuantity() {
    setState(() {
      quantityDropDown = getQuantiyDropDown();
      currentQuantity = "1";
    });
  }

  changeSelectQuantiy(String selectedQuantity) {
    setState(() => currentQuantity = selectedQuantity);
    Navigator.pop(context);
  }

  _getWeight() {
    setState(() {
      weights = widget.productDetailsWeights;
      weightDropDown = getWeightDropDown();
      currentWeight = weights[0];
    });
  }

  changeSelectWeight(String selectedWeight) {
    setState(() => currentWeight = selectedWeight);
    Navigator.pop(context);
  }
}
