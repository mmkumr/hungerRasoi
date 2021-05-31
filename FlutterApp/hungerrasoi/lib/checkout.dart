import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hungerrasoi/db/orders.dart';
import 'package:hungerrasoi/provider/cart_provider.dart';
import 'package:hungerrasoi/provider/user_provider.dart';
import 'package:hungerrasoi/widgets/checkout_products.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'home.dart';
import 'dart:convert';

class Checkout extends StatefulWidget {
    final checkoutItemIndex;

    Checkout({
        this.checkoutItemIndex,
    });

    @override
    _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
    var userDetails;
    final _formKey = GlobalKey<FormState>();
    TextEditingController _name = TextEditingController();
    TextEditingController _phone = TextEditingController();
    TextEditingController _address = TextEditingController();
    TextEditingController _pinCode = TextEditingController();
    TextEditingController _referral = TextEditingController();
    final Geolocator geoLocator = Geolocator()..forceAndroidLocationManager;
    OrderService _orderService = new OrderService();
    bool userReferred = false;
    Position _currentPosition;
    String _currentAddress;
    bool referral = false;
    bool cashOnDelivery = true;
    bool onlinePayment = false;
    int start = 1;
    @override
    Widget build(BuildContext context) {
        _userReferred();
        final user = Provider.of<UserProvider>(context);
        final cart = Provider.of<CartProvider>(context);
        _getOrderItems() async {
            List data = await _orderService.getOrderItems(user.user.uid);
        }

        List orderItems = [];
        _getOrderItems();
        int i = 0;
        for (; i < _orderService.productsForOrder.length; ++i) {
            setState(() {
                orderItems.insert(0, _orderService.productsForOrder[i]);
            });
        }
        for (int j = 0; j < cart.productsInCart.length; ++i, ++j) {
            setState(() {
                orderItems.insert(0, {
                    "id":cart.productsInCart[j]["id"],
                    "image": cart.productsInCart[j]["image"][0],
                    "name": cart.productsInCart[j]["name"],
                    "quantity": cart.productsInCart[j]["quantity"],
                    "weight": cart.productsInCart[j]["weight"],
                    "status": "Not delivered",
                    "address": _name.text + ", " + _address.text + ", " + _pinCode.text,
                    "phone": _phone.text,
                    "timeOfDelivery": cart.productsInCart[j]["timeOfDelivery"],
                    "price": cart.productsInCart[j]["price"],
                    "timeStamp": DateTime.now(),
                });
            });
        }

        _getUsersData() async {
            if (start == 1) {
                setState(() {
                    userDetails = user.userDetails;
                    _phone.text = userDetails["phone"];
                    _name.text = userDetails["name"];
                    _address.text = userDetails["address"];
                    _pinCode.text = userDetails["pinCode"];
                    start = 0;
                });
            }
        }

        _getUsersData();
        return Scaffold(
            appBar: new AppBar(
                elevation: 0.0,
                backgroundColor: Colors.green,
                leading: new IconButton(
                    icon: Icon(
                        Icons.close,
                        color: Colors.white,
                    ),
                    onPressed: () {
                        Navigator.pop(context);
                    }),
                title: InkWell(
                    onTap: () {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    child: Row(
                        children: <Widget>[
                            Image.asset(
                                "images/fav.png",
                                height: 60,
                            ),
                            Text("Checkout"),
                        ],
                    ),
                ),
            ),
            body: new SingleChildScrollView(
                child: Container(
                    height: MediaQuery.of(context).size.height * 1.9,
                    child: new Column(
                        children: <Widget>[
                            Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(50),
                                        bottomRight: Radius.circular(45)),
                                ),
                            ),
                            Container(
                                transform: Matrix4.translationValues(3.0, -25.0, 0.0),
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: MediaQuery.of(context).size.height * 0.6,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey,
                                            blurRadius:
                                            20.0, // has the effect of softening the shadow
                                        )
                                    ],
                                ),
                                child: Container(
                                    height: MediaQuery.of(context).size.height * 0.6,
                                    child: Column(
                                        children: <Widget>[
                                            Text(
                                                "Items",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                    color: Colors.deepOrange),
                                            ),
                                            CheckoutProducts(),
                                        ],
                                    ),
                                ),
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: 670,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey,
                                            blurRadius:
                                            20.0, // has the effect of softening the shadow
                                        )
                                    ],
                                ),
                                child: Container(
                                    child: Column(
                                        children: <Widget>[
                                            Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(
                                                    "Checkout Details",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 20,
                                                        color: Colors.deepOrange),
                                                ),
                                            ),
                                            Form(
                                                key: _formKey,
                                                child: Column(
                                                    children: <Widget>[
                                                        Padding(
                                                            padding: const EdgeInsets.fromLTRB(
                                                                14.0, 0.0, 14.0, 8.0),
                                                            child: Material(
                                                                borderRadius: BorderRadius.circular(10.0),
                                                                color: Colors.grey.withOpacity(0.2),
                                                                elevation: 0.0,
                                                                child: Padding(
                                                                    padding: const EdgeInsets.only(left: 12.0),
                                                                    child: TextFormField(
                                                                        controller: _name,
                                                                        decoration: InputDecoration(
                                                                            border: InputBorder.none,
                                                                            hintText: "Full name",
                                                                            icon: Icon(Icons.person),
                                                                        ),
                                                                        // ignore: missing_return
                                                                        validator: (value) {
                                                                            if (value.isEmpty) {
                                                                                return "Name cannot be empty";
                                                                            }
                                                                        },
                                                                    ),
                                                                ),
                                                            ),
                                                        ),
                                                        Padding(
                                                            padding: const EdgeInsets.fromLTRB(
                                                                14.0, 8.0, 14.0, 8.0),
                                                            child: Material(
                                                                borderRadius: BorderRadius.circular(10.0),
                                                                color: Colors.grey.withOpacity(0.2),
                                                                elevation: 0.0,
                                                                child: Padding(
                                                                    padding: const EdgeInsets.only(left: 12.0),
                                                                    child: TextFormField(
                                                                        keyboardType: TextInputType.number,
                                                                        controller: _phone,
                                                                        decoration: InputDecoration(
                                                                            border: InputBorder.none,
                                                                            hintText: "Phone no.",
                                                                            icon: Icon(Icons.phone),
                                                                        ),
                                                                        validator: (value) {
                                                                            if (value.isEmpty) {
                                                                                return "The phone no. field cannot be empty";
                                                                            }
                                                                            if (value.length != 10) {
                                                                                return "Please make sure your phone no. is correct!!";
                                                                            }
                                                                            return null;
                                                                        },
                                                                    ),
                                                                ),
                                                            ),
                                                        ),
                                                        Padding(
                                                            padding: const EdgeInsets.fromLTRB(
                                                                14.0, 8.0, 14.0, 8.0),
                                                            child: MaterialButton(
                                                                onPressed: () {
                                                                    _getCurrentLocation();
                                                                },
                                                                color: Colors.deepOrange,
                                                                elevation: 0.0,
                                                                child: Padding(
                                                                    padding: const EdgeInsets.only(left: 12.0),
                                                                    child: Text("Autodetect Location"),
                                                                ),
                                                            ),
                                                        ),
                                                        Padding(
                                                            padding: const EdgeInsets.fromLTRB(
                                                                14.0, 8.0, 14.0, 8.0),
                                                            child: Material(
                                                                borderRadius: BorderRadius.circular(10.0),
                                                                color: Colors.grey.withOpacity(0.2),
                                                                elevation: 0.0,
                                                                child: Padding(
                                                                    padding: const EdgeInsets.only(left: 12.0),
                                                                    child: TextFormField(
                                                                        maxLines: 2,
                                                                        controller: _address,
                                                                        decoration: InputDecoration(
                                                                            border: InputBorder.none,
                                                                            hintText: "Address",
                                                                            icon: Icon(Icons.map),
                                                                        ),
                                                                        validator: (value) {
                                                                            if (value.isEmpty) {
                                                                                return "The address field cannot be empty";
                                                                            }
                                                                            return null;
                                                                        },
                                                                    ),
                                                                ),
                                                            ),
                                                        ),
                                                        Padding(
                                                            padding: const EdgeInsets.fromLTRB(
                                                                14.0, 8.0, 14.0, 8.0),
                                                            child: Material(
                                                                borderRadius: BorderRadius.circular(10.0),
                                                                color: Colors.grey.withOpacity(0.2),
                                                                elevation: 0.0,
                                                                child: Padding(
                                                                    padding: const EdgeInsets.only(left: 12.0),
                                                                    child: TextFormField(
                                                                        keyboardType: TextInputType.number,
                                                                        controller: _pinCode,
                                                                        decoration: InputDecoration(
                                                                            border: InputBorder.none,
                                                                            hintText: "Pin Code.",
                                                                            icon: Icon(Icons.pin_drop),
                                                                        ),
                                                                        validator: (value) {
                                                                            if (value.isEmpty) {
                                                                                return "The pin code field cannot be empty";
                                                                            }
                                                                            if (value.length != 6) {
                                                                                return "Please enter the correct pin code!!";
                                                                            }
                                                                            return null;
                                                                        },
                                                                    ),
                                                                ),
                                                            ),
                                                        ),
                                                        Padding(
                                                            padding: const EdgeInsets.all(15.0),
                                                            child: Text(
                                                                "If a person has referred you/told about our app then enter the person referral id. "
                                                                    "The person who has referred you will get 50Rs. and you will get 20Rs. "
                                                                    "A person can be  referred once. But you can refer many persons. Refer and earn money. "
                                                                    " Money will add to your wallet but you can transfer that to your bank account by contacting us.",
                                                                textAlign: TextAlign.justify,
                                                                style: TextStyle(color: Colors.red),
                                                            ),
                                                        ),
                                                        Visibility(
                                                            visible: !referral && !userReferred,
                                                            child: Padding(
                                                                padding: const EdgeInsets.fromLTRB(
                                                                    14.0, 8.0, 14.0, 8.0),
                                                                child: Material(
                                                                    borderRadius: BorderRadius.circular(10.0),
                                                                    color: Colors.grey.withOpacity(0.2),
                                                                    elevation: 0.0,
                                                                    child: Padding(
                                                                        padding: const EdgeInsets.only(left: 12.0),
                                                                        child: TextFormField(
                                                                            controller: _referral,
                                                                            readOnly: referral,
                                                                            decoration: InputDecoration(
                                                                                border: InputBorder.none,
                                                                                hintText: "Referral code",
                                                                                icon: Icon(Icons.person_add),
                                                                            ),
                                                                        ),
                                                                    ),
                                                                ),
                                                            ),
                                                        ),
                                                        Row(
                                                            children: <Widget>[
                                                                Visibility(
                                                                    visible: !referral && !userReferred,
                                                                    child: Padding(
                                                                        padding: const EdgeInsets.fromLTRB(
                                                                            14.0, 8.0, 14.0, 8.0),
                                                                        child: MaterialButton(
                                                                            onPressed: () async {
                                                                                if (await user
                                                                                    .getReferral(_referral.text)
                                                                                    .then((value) {
                                                                                    return value.length;
                                                                                }) ==
                                                                                    0 ||
                                                                                    await user.userDetails["referId"] ==
                                                                                        _referral.text) {
                                                                                    _referral.text = "";
                                                                                    Fluttertoast.showToast(
                                                                                        msg: "Invalid Referral code.");
                                                                                } else {
                                                                                    Fluttertoast.showToast(
                                                                                        msg: "Referral code applied.");
                                                                                    setState(() {
                                                                                        referral = true;
                                                                                    });
                                                                                }
                                                                            },
                                                                            color: Colors.deepOrange,
                                                                            elevation: 0.0,
                                                                            child: Padding(
                                                                                padding:
                                                                                const EdgeInsets.only(left: 12.0),
                                                                                child: Text("Use this code."),
                                                                            ),
                                                                        ),
                                                                    ),
                                                                ),
                                                                Visibility(
                                                                    visible: referral,
                                                                    child: Padding(
                                                                        padding: const EdgeInsets.fromLTRB(
                                                                            14.0, 8.0, 14.0, 8.0),
                                                                        child: MaterialButton(
                                                                            onPressed: () {
                                                                                setState(() {
                                                                                    referral = false;
                                                                                });
                                                                            },
                                                                            color: Colors.deepOrange,
                                                                            elevation: 0.0,
                                                                            child: Padding(
                                                                                padding:
                                                                                const EdgeInsets.only(left: 12.0),
                                                                                child: Text("Remove code."),
                                                                            ),
                                                                        ),
                                                                    ),
                                                                ),
                                                                Padding(
                                                                    padding: const EdgeInsets.fromLTRB(
                                                                        8.0, 8.0, 2.0, 8.0),
                                                                    child: MaterialButton(
                                                                        onPressed: () async {
                                                                            Share.share("Kindly download TitanicMarket app from https://demolink.com. \n"
                                                                                "${user.userDetails["name"]} refer Id is: ${user.userDetails["referId"]}.\nJust use this refer id while "
                                                                                "checkout the person who has referred you will get 50 and you will get 20 to your wallet. "
                                                                                "You can also transfer money from wallet to your bank account by contacting us. \n"
                                                                                "  We hope that you will enjoy our services and offers. "
                                                                            );
                                                                        },
                                                                        color: Colors.deepOrange,
                                                                        elevation: 0.0,
                                                                        child: Padding(
                                                                            padding: const EdgeInsets.only(left: 0.0),
                                                                            child: Text("Refer someone."),
                                                                        ),
                                                                    ),
                                                                ),
                                                            ],
                                                        ),
                                                    ],
                                                ),
                                            ),
                                        ],
                                    ),
                                ),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Container(
                                    width: MediaQuery.of(context).size.width * 0.9,
                                    height: 150,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey,
                                                blurRadius:
                                                20.0, // has the effect of softening the shadow
                                            )
                                        ],
                                    ),
                                    child: Column(
                                        children: <Widget>[
                                            Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(
                                                    "Payment methods",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 20,
                                                        color: Colors.deepOrange),
                                                ),
                                            ),
                                            Row(
                                                children: <Widget>[
                                                    Checkbox(
                                                        activeColor: Colors.deepOrange,
                                                        checkColor: Colors.deepOrange,
                                                        value: cashOnDelivery,
                                                        onChanged: (value) {
                                                            setState(() {
                                                                cashOnDelivery = true;
                                                                onlinePayment = false;
                                                            });
                                                        }),
                                                    Text(
                                                        "Cash On Delivery",
                                                        textAlign: TextAlign.center,
                                                    ),
                                                ],
                                            ),
                                            Row(
                                                children: <Widget>[
                                                    Checkbox(
                                                        activeColor: Colors.deepOrange,
                                                        checkColor: Colors.deepOrange,
                                                        value: onlinePayment,
                                                        onChanged: (value) {
                                                            setState(() {
                                                                cashOnDelivery = false;
                                                                onlinePayment = true;
                                                            });
                                                        }),
                                                    Text(
                                                        "Online payment",
                                                        textAlign: TextAlign.center,
                                                    ),
                                                ],
                                            ),
                                        ],
                                    ),
                                ),
                            ),
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: MaterialButton(
                                    color: Colors.green,
                                    onPressed: () {
                                        if (_formKey.currentState.validate()) {
                                            if (cashOnDelivery == true) {
                                                _orderService.createOrderItem(
                                                    {"userId": user.user.uid, "order": orderItems});
                                                cart.createCartItem({
                                                    "userId": user.user.uid,
                                                    "cart": []
                                                });
                                                if(referral){
                                                    user.setReferral(_referral.text);
                                                }
                                                Navigator.pop(context);
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => HomePage()));
                                                Fluttertoast.showToast(msg: "Thanks for shopping.");
                                            }
                                        }
                                    },
                                    child: Text("Proceed to checkout"),
                                ),
                            )
                        ],
                    ),
                ),
            ),
        );
    }
    _userReferred() async{
        final user = Provider.of<UserProvider>(context);
        if(user.userDetails["referred"] == "true") {
            setState(() {
                userReferred = true;
            });
        }
    }
    _getCurrentLocation() {
        geoLocator
            .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
            .then((Position position) {
            setState(() {
                _currentPosition = position;
            });

            _getAddressFromLatLng();
        }).catchError((e) {
            print(e);
        });
    }

    _getAddressFromLatLng() async {
        try {
            List<Placemark> p = await geoLocator.placemarkFromCoordinates(
                _currentPosition.latitude, _currentPosition.longitude);

            Placemark place = p[0];

            setState(() {
                _currentAddress =
                "${place.locality}, ${place.postalCode}, ${place.country}";
                List<String> list = [
                    place.subLocality,
                    place.name,
                    place.locality,
                    place.subAdministrativeArea,
                    place.administrativeArea
                ];
                final address = list.reduce((value, element) => value + ', ' + element);
                _address.text = address;
                _pinCode.text = place.postalCode;
            });
        } catch (e) {
            print(e);
        }
    }
}
