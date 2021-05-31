import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hungerrasoi/provider/user_provider.dart';
import 'package:hungerrasoi/user_details.dart';
import 'package:hungerrasoi/widgets/common.dart';
import 'package:hungerrasoi/widgets/drawer.dart';
import 'package:hungerrasoi/widgets/navbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

import 'login.dart';

class UserDetailsEdit extends StatefulWidget {
  @override
  _UserDetailsEditState createState() => _UserDetailsEditState();
}

class _UserDetailsEditState extends State<UserDetailsEdit> {
  DocumentSnapshot userDetails;
  TextEditingController _referral = TextEditingController();
  ScrollController _refer = ScrollController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  File _image1;
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _pinCode = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  Position _currentPosition;
  String _currentAddress;
  String imageUrl;
  int start = 1;
  String photoUrl;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    _getUsersData() async {
      if (start == 1) {
        setState(() {
          userDetails = user.userDetails;
          _email.text = userDetails["email"];
          _phone.text = userDetails["phone"];
          _name.text = userDetails["name"];
          _address.text = userDetails["address"];
          _pinCode.text = userDetails["pinCode"];
          photoUrl = userDetails["photoUrl"];
          start = 0;
        });
      }
    }

    _getUsersData();
    return Scaffold(
      appBar: NavBar(
        key: Key('Edit Details'),
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
              height: MediaQuery.of(context).size.height * 0.9,
              child: Form(
                  key: _formKey,
                  child: ListView(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 500,
                          alignment: Alignment.topCenter,
                          child: OutlineButton(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                new BorderRadius.circular(100.0)),
                            borderSide: BorderSide(
                                color: Colors.greenAccent,
                                width: 1.0),
                            onPressed: () {
                              // ignore: deprecated_member_use
                              _selectImage(ImagePicker.pickImage(
                                  source: ImageSource.gallery));
                            },
                            child: _displayImage(),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Click on the image to change it.",
                            style: TextStyle(color: Colors.deepOrange),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Change the fields which you want to change",
                            style: TextStyle(color: Colors.deepOrange),
                          )
                        ],
                      ),
                      SingleChildScrollView(
                        child: Container(
                          height:
                          MediaQuery.of(context).size.height * 0.4,
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
                                      controller: _name,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Full Name",
                                        icon: Icon(Icons.person_outline),
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "The name field cannot be empty";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    14.0, 0.0, 14.0, 8.0),
                                child: Material(
                                  borderRadius:
                                  BorderRadius.circular(10.0),
                                  color: Colors.grey.withOpacity(0.2),
                                  elevation: 0.0,
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.only(left: 12.0),
                                    child: TextFormField(
                                      controller: _email,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Email",
                                        icon: Icon(Icons.alternate_email),
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          Pattern pattern =
                                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                          RegExp regex =
                                          new RegExp(pattern);
                                          if (!regex.hasMatch(value))
                                            return 'Please make sure your email address is valid';
                                          else
                                            return null;
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
                                      obscureText: true,
                                      controller: _password,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Password",
                                        icon: Icon(Icons.lock_outline),
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "The password field cannot be empty";
                                        } else if (value.length < 6) {
                                          return "the password has to be at least 6 characters long";
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
                                      obscureText: true,
                                      controller: _confirmPassword,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Confirm Password",
                                        icon: Icon(Icons.lock_outline),
                                      ),
                                      validator: (value) {
                                        if (value != _password.text) {
                                          return "Confirm password and password field mismatch.";
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
                      Center(child: Text("Scroll down for more details", style: TextStyle(color: Colors.deepOrange),)),
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
                                  if (_image1 != null) {
                                    try {
                                      setState(() => isLoading = true);
                                      final FirebaseStorage storage =
                                          FirebaseStorage.instance;
                                      final String picture1 =
                                          "1${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
                                      StorageUploadTask task1 = storage
                                          .ref()
                                          .child(picture1)
                                          .putFile(_image1);
                                      task1.onComplete
                                          .then((snapshot1) async {
                                        setState(() => isLoading = false);
                                        imageUrl = await snapshot1.ref
                                            .getDownloadURL();
                                        user
                                            .signUp(
                                            imageUrl,
                                            _name.text,
                                            _email.text,
                                            _phone.text,
                                            _address.text,
                                            _pinCode.text,
                                            _password.text)
                                            .whenComplete(() {
                                          Fluttertoast.showToast(
                                              msg: "Sign in successful.");
                                          Timer(Duration(seconds: 4), () {
                                            Navigator.pop(context);
                                          });
                                        });
                                      });
                                    } catch (e) {
                                      Fluttertoast.showToast(
                                          msg:
                                          "Unable to save details.");
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  UserDetails()));
                                    }
                                  } else if (!await user.signUp(
                                      imageUrl,
                                      _name.text,
                                      _email.text,
                                      _phone.text,
                                      _address.text,
                                      _pinCode.text,
                                      _password.text)) {
                                    Timer(Duration(seconds: 4), () {
                                      Fluttertoast.showToast(
                                          msg:
                                          "Unable to create account. Try to log in.");
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Login()));
                                    });
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "Sign in successful.");
                                    Timer(Duration(seconds: 4), () {
                                      Navigator.pop(context);
                                    });
                                  }
                                }
                              },
                              minWidth: MediaQuery.of(context).size.width,
                              child: Text(
                                "Save details",
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

  Widget _displayImage() {
    if (_image1 == null) {
      return Container(
        height: 200.0,
        width: 200.0,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100.0),
          child: new Image.network(
            photoUrl,
            fit: BoxFit.fill,
          ),
        ),
      );
    } else {
      return Container(
        height: 200.0,
        width: 200.0,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100.0),
          child: new Image.file(
            _image1,
            fit: BoxFit.fill,
          ),
        ),
      );
    }
  }

  _selectImage(Future<File> pickImage) async {
    File temp = await pickImage;
    setState(() => _image1 = temp);
  }
}
