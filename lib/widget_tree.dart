import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/Pages/AdminHomePage.dart';
import 'package:ecommerce/Pages/BottomNavigationBar.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Auth.dart';
import 'Pages/Homepage.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/Pages/signIn.dart';
import 'package:ecommerce/Pages/signUp.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree>  {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        // If the user is logged in
        if (snapshot.hasData) {
          User? user = snapshot.data as User?; // Get the logged-in user

          // Fetch user role from Firestore
          return FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('users')
                .doc(user?.uid)
                .get(), // Get the user data
            builder: (context, roleSnapshot) {
              if (roleSnapshot.connectionState == ConnectionState.waiting) {
                // Show loading indicator while fetching user role
                return Center(child: CircularProgressIndicator());
              }

              if (roleSnapshot.hasData) {
                var userRole = roleSnapshot.data?.get('role'); // Get the role from Firestore

                // Check the user role and return the appropriate homepage
                if (userRole == 'admin') {
                  return Adminhomepage(); // Navigate to Admin homepage
                } else {
                  return MyBottomNavigationBar(); // Navigate to User homepage
                }
              } else {
                // If no role is found, return the user homepage by default
                return MyBottomNavigationBar();
              }
            },
          );
        }

        // If not logged in, return sign-in page
        return signIn();
      },
    );
  }
}
