import 'package:ecommerce/Pages/AdminHomePage.dart';
import 'package:ecommerce/Pages/BottomNavigationBar.dart';
import 'package:ecommerce/Pages/Homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Pages/signUp.dart';
import 'package:flutter/material.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
  Future<UserCredential> signIn(
      {required context,
      required String email,
      required String password}) async {
    UserCredential userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            "Sign in Done successfully with ${userCredential.user!.email}!")));

    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();
      String role = userDoc['role'];
      if (role == 'admin') {
        // Navigate to admin page
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const Adminhomepage()),
            (Route<dynamic> route) => false);
      } else {
        // Navigate to user page
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const MyBottomNavigationBar()),
            (Route<dynamic> route) => false);
      }
    } catch (e) {
      print("$e");
    }

    return userCredential;
  }

  Future<UserCredential> signUp(
      {required bool isAdmin,
      required String email,
      required String password}) async {
    UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'email': email,
        'role': isAdmin ? 'admin' : 'user',
      });
    } catch (e) {
      print("$e");
    }
    return userCredential;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
