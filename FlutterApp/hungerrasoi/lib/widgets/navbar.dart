import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hungerrasoi/db/category.dart';
import 'package:hungerrasoi/db/products.dart';
import 'package:hungerrasoi/home.dart';
import 'package:hungerrasoi/provider/cart_provider.dart';
import 'package:hungerrasoi/provider/user_provider.dart';
import 'package:hungerrasoi/search.dart';
import 'package:intl/date_time_patterns.dart';
import 'package:provider/provider.dart';

//User defined library.
import '../cart.dart';

class NavBar extends StatefulWidget implements PreferredSizeWidget {
  NavBar({
    Key key,
  })  : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int cartItems = 0;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final cart = Provider.of<CartProvider>(context);
    _getCartItems() async {
      List data = await cart.getCarItems(user.user.uid);
      setState(() {
        cartItems = data.length;
      });
    }

    _getCartItems();
    return new AppBar(
      elevation: 0.0,
      backgroundColor: Colors.green,
      title: InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "images/fav.png",
              height: 60,
            ),
            Text(
              widget.key.toString().substring(
                  widget.key.toString().indexOf("\'") + 1,
                  widget.key.toString().lastIndexOf("\'")),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        new IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Search()));
            }),
        SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Visibility(
                visible: user.status == Status.Authenticated,
                child: Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    transform: Matrix4.translationValues(0.0, 8.0, 0.0),
                    child: new Text(
                      cartItems.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    )),
              ),
              Container(
                transform: user.status == Status.Authenticated ? Matrix4.translationValues(-8.0, -10.0, 0.0)
                : Matrix4.translationValues(-8.0, 4.0, 0.0),
                child: new IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => new Cart())),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
