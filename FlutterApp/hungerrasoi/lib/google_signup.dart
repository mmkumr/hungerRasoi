import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hungerrasoi/home.dart';
import 'package:hungerrasoi/widgets/drawer.dart';
import 'package:hungerrasoi/widgets/navbar.dart';
import 'package:geolocator/geolocator.dart';

import 'forgot_password.dart';
import 'login.dart';
import 'widgets/common.dart';
import 'widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/user_provider.dart';

class GoogleSignUp extends StatefulWidget {
  @override
  _GoogleSignUpState createState() => _GoogleSignUpState();
}

class _GoogleSignUpState extends State<GoogleSignUp> {
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();

  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _pinCode = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Firestore _firestore = Firestore.instance;

  Position _currentPosition;
  String _currentAddress;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      key: _key,
      appBar: NavBar(
        key: Key('User Details'),
      ),
      // Defined in widgets/navbar.dart
      drawer: SideBar(),
      // Defined in widgets/drawer.dart
      body: user.status == Status.Authenticating
          ? Loading()
          : Stack(
              children: <Widget>[
                Flexible(
                  child: Container(
                    child: Form(
                        key: _formKey,
                        child: ListView(
                          children: <Widget>[
                            Container(
                                alignment: Alignment.topCenter,
                                child: Image.asset(
                                  'images/login.png',
                                  width: 200.0,
                                )),
                            SingleChildScrollView(
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.45,
                                child: ListView(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          14.0, 8.0, 14.0, 8.0),
                                      child: Material(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color: Colors.grey.withOpacity(0.2),
                                        elevation: 0.0,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 12.0),
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
                                        color: deepOrange,
                                        elevation: 0.0,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 12.0),
                                          child: Text("Autodetect Location"),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          14.0, 8.0, 14.0, 8.0),
                                      child: Material(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color: Colors.grey.withOpacity(0.2),
                                        elevation: 0.0,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 12.0),
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
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color: Colors.grey.withOpacity(0.2),
                                        elevation: 0.0,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 12.0),
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
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  14.0, 8.0, 14.0, 8.0),
                              child: Material(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Colors.black,
                                  elevation: 0.0,
                                  child: MaterialButton(
                                    onPressed: () async {
                                      if (_formKey.currentState.validate()) {
                                        String email =
                                            user.user.email.toString();
                                        String name =
                                            user.user.displayName.toString();
                                        String uid = user.user.uid.toString();
                                        if (await user.updateData(
                                          user.user.photoUrl,
                                                name,
                                                email,
                                                _phone.text,
                                                _address.text,
                                                _pinCode.text,
                                                uid) ==
                                            true) {
                                          Timer(Duration(seconds: 4), () {
                                            Fluttertoast.showToast(
                                                msg: "Sign in successful.");
                                            Navigator.pop(context);
                                          });
                                        } else {
                                          Timer(Duration(seconds: 4), () {
                                            Fluttertoast.showToast(
                                                msg: "Sign up Failed.");
                                            user.user.delete();
                                          });
                                        }
                                      }
                                    },
                                    minWidth: MediaQuery.of(context).size.width,
                                    child: Text(
                                      "Create an account",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                  )),
                            ),
                          ],
                        )),
                  ),
                ),
              ],
            ),
    );
  }

  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
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
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
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
