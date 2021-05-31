import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hungerrasoi/checkout.dart';
import 'package:hungerrasoi/provider/cart_provider.dart';

//User Defined library
import 'package:hungerrasoi/widgets/drawer.dart';
import 'package:hungerrasoi/widgets/navbar.dart';
import 'package:hungerrasoi/widgets/order_products.dart';
import 'package:provider/provider.dart';

import 'login.dart';

class Order extends StatefulWidget {
    @override
    _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
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
        return Scaffold(
            appBar: new NavBar(key: Key('Orders')),
            // Defined in widgets/navbar.dart
            drawer: SideBar(),
            // Defined in widgets/drawer.dart
            body: SingleChildScrollView(
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.87,
                    child: OrderProducts(),
                ),
            ),
        );
    }
}
