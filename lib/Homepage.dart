import 'package:ecommerce/Auth.dart';
import 'package:ecommerce/Pages/signIn.dart';
import 'package:ecommerce/Widgets/inputs/AuthTextField.dart';
import 'package:ecommerce/Pages/signUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () async {
            try {
              Auth().signOut();
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Signed out successfully!")));
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) =>  signIn()),
                  (Route<dynamic> route) => false);
            } on FirebaseAuthException catch (e) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(e.message!)));
            }
          },
          icon: const Icon(Icons.logout),
        ),
      ),
      body: SingleChildScrollView(
          child: Center(
            child: Container(
                    child: const Text("HomePage"),
                  ),
          )),
    );
  }
}
