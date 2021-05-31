import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hungerrasoi/login.dart';
import 'package:hungerrasoi/provider/cart_provider.dart';
import 'package:hungerrasoi/widgets/loading.dart';
import 'package:provider/provider.dart';
import '../provider/user_provider.dart';

class CartProducts extends StatefulWidget {
    @override
    _CartProductsState createState() => _CartProductsState();
}

class _CartProductsState extends State<CartProducts> {
    List items;
    @override
    Widget build(BuildContext context) {
        final user = Provider.of<UserProvider>(context);
        final cartItems = Provider.of<CartProvider>(context);
        _getCartItems() async {
            List data = await cartItems.getCarItems(user.user.uid);
            setState(() {
                items = data;
            });
        }
        _getCartItems();
        return items == null ? Loading() : new ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
                return CartProduct(
                    cartIndex: index,
                );
            });
    }

}

class CartProduct extends StatefulWidget {
    final cartIndex;

    CartProduct({
        this.cartIndex,
    });

    @override
    _CartProductState createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
    int quantity;
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
        setState(() {
            quantity = int.parse(cartItems[widget.cartIndex]["quantity"]);
        });
        return new Card(
            child: Column(
                children: <Widget>[
                    ListTile(
                        leading: new Image.network(
                            cartItems[widget.cartIndex]["image"][0],
                            cacheWidth: 50,
                            cacheHeight: 50,
                        ),
                        trailing: SingleChildScrollView(
                            child: new Column(
                                children: <Widget>[
                                    new Container(
                                        transform: Matrix4.translationValues(
                                            0.0, -20.0, 0.0),
                                        child: new IconButton(
                                            icon: Icon(Icons.arrow_drop_up),
                                            onPressed: () {
                                                if (quantity > 1) {
                                                    setState(() {
                                                        quantity = quantity - 1;
                                                        cartItems[widget.cartIndex]["quantity"] = quantity.toString();
                                                    });
                                                    cart.createCartItem(
                                                        {"userId": user.user.uid, "cart": cartItems});
                                                }
                                            }),
                                    ),
                                    new Container(
                                        transform: Matrix4.translationValues(
                                            0.0, -35.0, 0.0),
                                        child: new Text(cartItems[widget.cartIndex]["quantity"].toString()),
                                    ),
                                    new Container(
                                        transform: Matrix4.translationValues(
                                            0.0, -45.0, 0.0),
                                        child: new IconButton(
                                            icon: Icon(Icons.arrow_drop_down),
                                            onPressed: () {
                                              if (quantity < 9) {
                                                  setState(() {
                                                      quantity = quantity + 1;
                                                      cartItems[widget.cartIndex]["quantity"] = quantity.toString();
                                                  });
                                                  cart.createCartItem(
                                                      {"userId": user.user.uid, "cart": cartItems});
                                              }
                                            }),
                                    ),
                                ],
                            ),
                        ),
                        title: new Text(cartItems[widget.cartIndex]["name"]),
                        subtitle: new Column(
                            children: <Widget>[
                                new Row(
                                    children: <Widget>[
                                        new Padding(
                                            padding: EdgeInsets.all(0.0),
                                            child: new Text("Weight:"),
                                        ),
                                        new Padding(
                                            padding: EdgeInsets.all(2.0),
                                            child: new Text(
                                                cartItems[widget.cartIndex]["weight"],
                                                style: TextStyle(
                                                    color: Colors.red),
                                            ),
                                        ),
                                    ],
                                ),
                                Wrap(
                                    direction: Axis.vertical,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text("Delivery timing: ", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),),
                                          Text("${cartItems[widget.cartIndex]["timeOfDelivery"]}",
                                              style: TextStyle(color: Colors.red, fontSize: 12),)
                                      ],
                                    ),
                                  ],
                                ),
                                new Container(
                                    alignment: Alignment.topLeft,
                                    child: new Text(
                                        "\₹${cartItems[widget.cartIndex]["price"]}",
                                        style: TextStyle(
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red,
                                        ),
                                    ),
                                )
                            ],
                        ),
                    ),
                    MaterialButton(
                        onPressed: () {
                            setState(() {
                                cartItems.removeAt(widget.cartIndex);
                            });
                            cart.createCartItem(
                                {"userId": user.user.uid, "cart": cartItems});
                        },
                        color: Colors.white,
                        child: Center(
                            child: Icon(Icons.delete),
                        ),
                    )
                ],
            ),
        );
    }
}

