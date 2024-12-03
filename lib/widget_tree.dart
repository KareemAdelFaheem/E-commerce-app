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

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Auth().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomePage();
          }
          return signIn();
        });
  }
}
