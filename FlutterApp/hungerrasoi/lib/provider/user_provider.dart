import 'package:fluttertoast/fluttertoast.dart';
import 'package:hungerrasoi/google_signup.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserProvider with ChangeNotifier {
    FirebaseAuth _auth;
    FirebaseUser _user;
    DocumentSnapshot _userDetails;
    Status _status = Status.Uninitialized;
    DocumentSnapshot get userDetails => _userDetails;
    Status get status => _status;
    FirebaseUser get user => _user;
    Firestore _firestore = Firestore.instance;
    GoogleSignIn googleSignIn = new GoogleSignIn();

    UserProvider.initialize() : _auth = FirebaseAuth.instance {
        _auth.onAuthStateChanged.listen(_onStateChanged);
    }


    Future<List<DocumentSnapshot>> getReferral(referralId) async {
        try {
            return _firestore
                .collection("users")
                .where('referId', isEqualTo: referralId)
                .getDocuments()
                .then((value) {
                print(value.documents.length);
                return value.documents;
            });
        } catch (e) {
            return null;
        }
    }

    Future<bool> setReferral(referralId) async {
        try {
            _firestore
                .collection("users")
                .document(await _firestore
                .collection("users")
                .where('referId', isEqualTo: referralId)
                .getDocuments()
                .then((value) {
                return value.documents[0].data["userId"];
            }))
                .updateData({'wallet': FieldValue.increment(50)});
            _firestore
                .collection("users")
                .document(user.uid)
                .updateData({'referred': "true", 'wallet': FieldValue.increment(20)});
            return true;
        } catch (e) {
            return false;
        }
    }

    Future<bool> signIn(String email, String password) async {
        try {
            _status = Status.Authenticating;
            notifyListeners();
            await _auth.signInWithEmailAndPassword(email: email, password: password);
            _userDetails = await _firestore
                .collection("users")
                .where('userId', isEqualTo: user.uid)
                .getDocuments()
                .then((value) {
                return value.documents[0];
            });
            _status = Status.Authenticated;
            notifyListeners();
            return true;
        } catch (e) {
            _status = Status.Unauthenticated;
            notifyListeners();
            print(e.toString());
            return false;
        }
    }

    Future<bool> updateData(String photoUrl, String name, String email, String phone,
        String address, String pinCode, String uid) async {
        try {
            _status = Status.Authenticating;
            notifyListeners();
            await _firestore.collection('users').document(uid).setData({
                "photoUrl": photoUrl,
                "email": email,
                'name': name,
                'phone': phone,
                'address': address,
                'pinCode': pinCode,
                'userId': uid,
                'cart': <List>[],
                'order': <List>[],
                'referred': "false",
                'referId': "TM-" +
                    (await _firestore.collection("users").getDocuments().then((value) {
                        return value.documents.length;
                    }))
                        .toString() +
                    uid.substring(0, 3),
                "wallet": 0
            });
            _userDetails = await _firestore
                .collection("users")
                .where('userId', isEqualTo: user.uid)
                .getDocuments()
                .then((value) {
                return value.documents[0];
            });
            _status = Status.Authenticated;
            notifyListeners();
            return true;
        } catch (e) {
            _status = Status.Unauthenticated;
            notifyListeners();
            print(e.toString());
            return false;
        }
    }

    Future<bool> signUp(String photoUrl, String name, String email, String phone, String address,
        String pinCode, String password) async {
        try {
            _status = Status.Authenticating;
            notifyListeners();
            await _auth
                .createUserWithEmailAndPassword(email: email, password: password)
                .then((user) async {
                _firestore.collection('users').document(user.user.uid).setData({
                    "photoUrl": photoUrl,
                    'name': name,
                    'email': email,
                    'phone': phone,
                    'address': address,
                    'pinCode': pinCode,
                    'userId': user.user.uid,
                    'cart': <List>[],
                    'order': <List>[],
                    'referred': "false",
                    'referId': "TM-" +
                        (await _firestore
                            .collection("users")
                            .getDocuments()
                            .then((value) {
                            return value.documents.length;
                        }))
                            .toString() +
                        user.user.uid.substring(0, 3),
                    "wallet": 0
                });
            });
            _userDetails = await _firestore
                .collection("users")
                .where('userId', isEqualTo: user.uid)
                .getDocuments()
                .then((value) {
                return value.documents[0];
            });
            _status = Status.Authenticated;
            notifyListeners();
            return true;
        } catch (e) {
            _status = Status.Unauthenticated;
            notifyListeners();
            print(e.toString());
            return false;
        }
    }

    Future<bool> resetPassword(String email) async {
        try {
            await _auth.sendPasswordResetEmail(email: email);
            return true;
        } catch (e) {
            print(e.toString());
            return false;
        }
    }

    Future signOut() async {
        _auth.signOut();
        _status = Status.Unauthenticated;
        notifyListeners();
        return Future.delayed(Duration.zero);
    }

    Future<String> signInWithGoogle() async {
        try {
            _status = Status.Authenticating;
            notifyListeners();
            final GoogleSignInAccount googleSignInAccount =
            await googleSignIn.signIn();
            final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
            final AuthCredential credential = GoogleAuthProvider.getCredential(
                accessToken: googleSignInAuthentication.accessToken,
                idToken: googleSignInAuthentication.idToken,
            );
            AuthResult authResult = await _auth.signInWithCredential(credential);
            int userExist = await _firestore
                .collection("users")
                .where('userId', isEqualTo: user.uid)
                .getDocuments()
                .then((value) {
                return value.documents.length;
            });
            if (userExist == 0) {
                _status = Status.Authenticated;
                notifyListeners();
                return "new";
            }
            _status = Status.Authenticated;
            notifyListeners();
            return "old";
        } catch (e) {
            _status = Status.Unauthenticated;
            notifyListeners();
            print(e.toString());
            return "fail";
        }
    }

    Future<void> _onStateChanged(FirebaseUser user) async {
        if (user == null) {
            _status = Status.Unauthenticated;
        } else {
            _user = user;
            _userDetails = await _firestore
                .collection("users")
                .where('userId', isEqualTo: user.uid)
                .getDocuments()
                .then((value) {
                return value.documents[0];
            });
            _status = Status.Authenticated;
        }
        notifyListeners();
    }
}
