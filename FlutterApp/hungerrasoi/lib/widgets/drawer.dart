import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hungerrasoi/home.dart';
import 'package:hungerrasoi/login.dart';
import 'package:hungerrasoi/orders.dart';
import 'package:hungerrasoi/user_details.dart';
import 'package:provider/provider.dart';
import 'package:hungerrasoi/provider/user_provider.dart';

import '../contact.dart';

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  DocumentSnapshot userDetails;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    _getUsersData() async {
      final user = Provider.of<UserProvider>(context);
        setState(() {
          userDetails = user.userDetails;
        });
    }
    _getUsersData();
    return new Container(
      child: new Drawer(
        child: ListView(
          children: <Widget>[
            //header section
            new UserAccountsDrawerHeader(
              accountName: Text(user.status == Status.Unauthenticated? "" : userDetails["name"]),
              accountEmail: Text(user.status == Status.Unauthenticated? "" : userDetails["email"]),
              currentAccountPicture: GestureDetector(
                child: new CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: user.status == Status.Unauthenticated || userDetails["photoUrl"] == null ? Icon(
                    Icons.person,
                    color: Colors.white,
                  ) : Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: new NetworkImage(userDetails["photoUrl"]),
                        )),
                  ),
                ),
              ),
              decoration: new BoxDecoration(color: Colors.green),
            ),
            //body
            InkWell(
              onTap: () => Navigator.of(context).push(
                  new MaterialPageRoute(builder: (context) => new HomePage())),
              child: ListTile(
                leading: Icon(
                  Icons.home,
                  color: Colors.red,
                ),
                title: Text('Home'),
              ),
            ),
            Visibility(
              visible: user.status == Status.Unauthenticated,
              child: InkWell(
                onTap: () => Navigator.of(context).push(
                    new MaterialPageRoute(builder: (context) => new Login())),
                child: ListTile(
                  leading: Icon(
                    Icons.person,
                    color: Colors.red,
                  ),
                  title: Text("Log In/Sign In"),
                ),
              ),
            ),

            Visibility(
              visible: user.status == Status.Authenticated,
              child: InkWell(
                onTap: () async {
                  user.signOut();
                },
                child: ListTile(
                  leading: Icon(
                    Icons.lock_open,
                    color: Colors.red,
                  ),
                  title: Text("Log Out"),
                ),
              ),
            ),

            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Order()));
              },
              child: ListTile(
                leading: Icon(
                  Icons.shopping_basket,
                  color: Colors.red,
                ),
                title: Text('My Orders'),
              ),
            ),

            Divider(),

            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => UserDetails()));
              },
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text('User Details'),
              ),
            ),

            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Contact()));
              },
              child: ListTile(
                leading: Icon(
                  Icons.headset_mic,
                  color: Colors.blue,
                ),
                title: Text('Contact us'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
