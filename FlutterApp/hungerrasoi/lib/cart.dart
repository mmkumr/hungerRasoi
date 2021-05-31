import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hungerrasoi/checkout.dart';
import 'package:hungerrasoi/provider/cart_provider.dart';

//User Defined library
import 'package:hungerrasoi/widgets/drawer.dart';
import 'package:hungerrasoi/widgets/navbar.dart';
import 'package:hungerrasoi/widgets/cart_products.dart';
import 'package:provider/provider.dart';

import 'login.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  void initState() {
    super.initState();
    isLogin();
  }

  void isLogin() async {
    FirebaseAuth.instance.currentUser().then((value) {
      if (value == null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartItems = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: new NavBar(key: Key('Cart')),
      // Defined in widgets/navbar.dart
      drawer: SideBar(),
      // Defined in widgets/drawer.dart
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          child: CartProducts(),
        ),
      ),
      bottomNavigationBar: new Container(
        color: Colors.white,
        child: Visibility(
          visible: cartItems.productsInCart.length != 0,
          child: Row(
            children: <Widget>[
              new Expanded(
                  child: ListTile(
                title: new Text("Total:"),
                subtitle: new Text("₹450"),
              )),
              new Expanded(
                  child: new MaterialButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Checkout()));
                },
                child: new Text(
                  "Check Out",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.green,
                height: 60,
              ))
            ],
          ),
        ),
      ),
    );
  }
}
