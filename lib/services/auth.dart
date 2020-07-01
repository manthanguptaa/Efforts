import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:effors/models/user.dart';
import 'package:effors/services/user_records.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_country_picker/country.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';
import 'dart:math' show Random;

final GoogleSignIn googleSignIn = GoogleSignIn();
final usersRef = Firestore.instance.collection("user");

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final databaseReference = Firestore.instance;

  //create User object based on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
        .map((FirebaseUser user) => _userFromFirebaseUser(user));
  }

  //sign in anonymously

  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email and password

  Future registerWithEmailAndPassword(
      String name, String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      //create a new document for the user with uid
      await UserDatabase(uid: user.uid).updateUserData(name, email);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign up with google
  Future<User> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.idToken != null && googleAuth.accessToken != null) {
        final authResult = await _auth.signInWithCredential(
            GoogleAuthProvider.getCredential(
                idToken: googleAuth.idToken,
                accessToken: googleAuth.accessToken));
        await signInGoogle();
        return _userFromFirebaseUser(authResult.user);
      } else {
        throw PlatformException(
            code: "ERROR_MISSING_GOOGLE_AUTH_TOKEN",
            message: "Missing google auth token");
      }
    } else {
      throw PlatformException(
          code: "ERROR_ABORTED_BY_USER",
          message: "Sign in aborted by the user");
    }
  }

  Future signInGoogle() async {
    // Detects when user signed in
    googleSignIn.onCurrentUserChanged.listen((account) {
      handleSignIn(account);
    }, onError: (err) {
      print('Error signing in: $err');
    });
    // Reauthenticate user when app is opened
    googleSignIn.signInSilently(suppressErrors: false).then((account) {
      handleSignIn(account);
    }).catchError((err) {
      print('Error signing in: $err');
    });
  }

  handleSignIn(GoogleSignInAccount account) {
    if (account != null) {
      createUserInFirestore();
      print('User signed in!: $account');
    }
  }

  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  createUserInFirestore() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: gSA.accessToken,
      idToken: gSA.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    FirebaseUser user = authResult.user;

    final DocumentSnapshot doc = await usersRef.document(user.uid).get();
     var dt = DateTime.now();
    var newFormat = DateFormat("d MMMM y");
    String updateDt = newFormat.format(dt);
    if (!doc.exists) {
      await usersRef.document(user.uid).setData({
        "id": user.uid,
        "email": user.email,
        "name": user.displayName,
        "country": "",
        'wakeTime': ""
      });

      await databaseReference
          .collection('user')
          .document(user.uid)
          .collection('record')
          .document(randomAlpha(5))
          .setData({'hold': 0, 'date':updateDt.toString()});
    }
  }

  void updateDetails(String uid, String country, String time) {
    try {
      databaseReference.collection('user').document(uid).updateData({
        'country': country,
        'wakeTime': time,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  storeRecord(String uid, int hold) async {
    var dt = DateTime.now();
    var newFormat = DateFormat("d MMMM y");
    String updateDt = newFormat.format(dt);
    await databaseReference
        .collection('user')
        .document(uid)
        .collection('record')
        .document(randomAlpha(5))
        .setData({'hold': hold, 'date': updateDt.toString()});
  }
}
