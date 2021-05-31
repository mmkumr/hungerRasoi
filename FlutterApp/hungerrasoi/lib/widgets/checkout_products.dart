import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hungerrasoi/login.dart';
import 'package:hungerrasoi/provider/cart_provider.dart';
import 'package:hungerrasoi/widgets/loading.dart';
import 'package:provider/provider.dart';
import '../provider/user_provider.dart';

class CheckoutProducts extends StatefulWidget {
    @override
    _CheckoutProductsState createState() => _CheckoutProductsState();
}

class _CheckoutProductsState extends State<CheckoutProducts> {
    List items;

    @override
    Widget build(BuildContext context) {
        final user = Provider.of<UserProvider>(context);
        final cartItems = Provider.of<CartProvider>(context);
        items = cartItems.productsInCart;
        return items == null ? Loading() : Container(
            height: MediaQuery.of(context).size.height * 0.5,
          child: new ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: items.length,
              itemBuilder: (context, index) {
                  return CheckoutProduct(
                      cartIndex: index,
                  );
              }),
        );
    }

}

class CheckoutProduct extends StatefulWidget {
    final cartIndex;

    CheckoutProduct({
        this.cartIndex,
    });

    @override
    _CheckoutProductState createState() => _CheckoutProductState();
}

class _CheckoutProductState extends State<CheckoutProduct> {
    int quantity;
    @override
    Widget build(BuildContext context) {
        final cart = Provider.of<CartProvider>(context);
        List cartItems = cart.productsInCart;

        return new Card(
            child: Column(
                children: <Widget>[
                    ListTile(
                        leading: new Image.network(
                            cartItems[widget.cartIndex]["image"][0],
                            cacheWidth: 50,
                            cacheHeight: 50,
                        ),
                        trailing: new Column(
                            children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: new Text(
                                      "\₹${cartItems[widget.cartIndex]["price"]}",
                                      style: TextStyle(
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                      ),
                                  ),
                                ),
                            ],
                        ),
                        title: new Text("${cartItems[widget.cartIndex]["name"]} X ${cartItems[widget.cartIndex]["quantity"]}"),
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
                            ],
                        ),
                    ),
                ],
            ),
        );
    }
}