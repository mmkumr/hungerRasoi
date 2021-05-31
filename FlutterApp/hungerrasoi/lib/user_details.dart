import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungerrasoi/provider/user_provider.dart';
import 'package:hungerrasoi/user_details_edit.dart';
import 'package:hungerrasoi/widgets/common.dart';
import 'package:hungerrasoi/widgets/drawer.dart';
import 'package:hungerrasoi/widgets/navbar.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class UserDetails extends StatefulWidget {
  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  DocumentSnapshot userDetails;
  TextEditingController _referral = TextEditingController();
  ScrollController _refer = ScrollController();
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
    return Scaffold(
      appBar: NavBar(
        key: Key('Details'),
      ),
      // Defined in widgets/navbar.dart
      drawer: SideBar(),
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            color: Colors.greenAccent,
          ),
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                                border: new Border.all(
                                    color: Colors.redAccent.withOpacity(0.8), width: 8),
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image:
                                      new NetworkImage(userDetails["photoUrl"]),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: new Text(
                      "Name: ${userDetails["name"]}\n\n"
                      "Email: ${userDetails["email"]}\n\n"
                      "Phone no.: ${userDetails["phone"]}\n\n"
                      "Address: ${userDetails["address"]}\n\n"
                      "Postal Code:${userDetails["pinCode"]}\n\n"
                      "Referral Id.: ${userDetails["referId"]}\n\n"
                      "(${userDetails["referId"] == true ? "Referred by someone." : "Not referred by anyone."})\n\n"
                      "Cash in wallet: र${userDetails["wallet"]}",
                      style: TextStyle(color: Color(0xff114b5f), fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Scrollbar(
                      isAlwaysShown: true,
                    controller: _refer,
                    child: SingleChildScrollView(
                      child: Container(
                          height: 100,
                        width: 300,
                        color: white,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                          child: TextFormField(
                              style: TextStyle(color: Color(0xff114b5f)),
                              textAlign: TextAlign.justify,
                              maxLines: 5,
                            initialValue: "If a person has referred you/told about our app then enter the person's referral id, while checkout. "
                                "The person who has referred you will get 50Rs. and you will get 20Rs. "
                                "A person can be  referred once. But you can refer many persons. Refer and earn money. "
                                " Money will add to your wallet but you can transfer that to your bank account by contacting us.",
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText: "Referral code",
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 2.0, 8.0),
                        child: MaterialButton(
                          onPressed: () async {
                            Share.share(
                                "Kindly download TitanicMarket app from https://demolink.com. \n"
                                "${user.userDetails["name"]} refer Id is: ${user.userDetails["referId"]}.\nJust use this refer id while "
                                "checkout the person who has referred you will get 50 and you will get 20 to your wallet. "
                                "You can also transfer money from wallet to your bank account by contacting us. \n"
                                "  We hope that you will enjoy our services and offers. ");
                          },
                          color: Colors.deepOrange,
                          elevation: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 0.0),
                            child: Text("Refer someone."),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 2.0, 8.0),
                        child: MaterialButton(
                          onPressed: () async {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => UserDetailsEdit()));
                          },
                          color: Colors.deepOrange,
                          elevation: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 0.0),
                            child: Text("Edit user details"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
