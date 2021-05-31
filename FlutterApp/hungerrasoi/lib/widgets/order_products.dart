import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hungerrasoi/provider/cart_provider.dart';
import 'package:hungerrasoi/widgets/loading.dart';
import 'package:provider/provider.dart';
import '../provider/user_provider.dart';
import 'package:hungerrasoi/db/orders.dart';

class OrderProducts extends StatefulWidget {
  @override
  _OrderProductsState createState() => _OrderProductsState();
}

class _OrderProductsState extends State<OrderProducts> {
  List items;
  OrderService _orderService = OrderService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    _getOrderItems() async {
      List data = await _orderService.getOrderItems(user.user.uid);
      setState(() {
        items = data;
      });
    }

    _getOrderItems();
    return items == null
        ? Loading()
        : Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: new ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return OrderProduct(
                    orderIndex: items[index],
                  );
                }),
          );
  }
}

class OrderProduct extends StatefulWidget {
  final orderIndex;

  OrderProduct({
    this.orderIndex,
  });

  @override
  _OrderProductState createState() => _OrderProductState();
}

class _OrderProductState extends State<OrderProduct> {
  @override
  Widget build(BuildContext context) {
    return new Card(
        child: Column(
      children: <Widget>[
        ListTile(
          leading: Image.network(
            widget.orderIndex["image"],
            cacheHeight: 50,
            cacheWidth: 50,
          ),
          title: Column(
            children: <Widget>[
              Text(widget.orderIndex["name"]),
              Text("weight: ${widget.orderIndex["weight"]}"),
              Text(
                "\₹${widget.orderIndex["price"]}",
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
          trailing: Text("X ${widget.orderIndex["quantity"]}"),
        ),
        MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {},
          child: Column(
            children: <Widget>[
              Divider(),
              Text(
                "Delivery Address",
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "${widget.orderIndex["address"]}",
                style: TextStyle(
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                "Phone no.: ${widget.orderIndex["phone"]}",
                style: TextStyle(
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              Divider(),
              Text(
                "Delivery Timing",
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold),
              ),
              Text("${widget.orderIndex["timeOfDelivery"]}"),
              Divider(),
            ],
          ),
        ),
        MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          color: Colors.white70,
          onPressed: () {},
          child: Column(
            children: <Widget>[
              Text(
                  "Ordered on: ${widget.orderIndex["timeStamp"].toDate().toString().substring(0, widget.orderIndex["timeStamp"].toDate().toString().lastIndexOf(":"))}"),
              Text(
                widget.orderIndex["status"],
                style: TextStyle(color: Colors.deepOrange),
              ),
            ],
          ),
        )
      ],
    ));
  }
}
