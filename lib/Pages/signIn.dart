import 'package:ecommerce/Auth.dart';
import 'package:ecommerce/Pages/Homepage.dart';
import 'package:ecommerce/Widgets/inputs/AuthTextField.dart';
import 'package:ecommerce/Pages/signUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class signIn extends StatefulWidget {
  String? useremail;
  String? userpassword;
  signIn({super.key, this.useremail, this.userpassword});

  @override
  State<signIn> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<signIn> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.useremail);
    _passwordController = TextEditingController(text: widget.userpassword);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 180,
                ),
                const Text(
                  "Ecommerce",
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.w900),
                ),
                const SizedBox(
                  height: 70,
                ),
                Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        authTextField(
                            "Enter email address",
                            TextInputType.emailAddress,
                            false,
                            _emailController),
                        const SizedBox(
                          height: 20,
                        ),
                        authTextField(
                            "Enter Password",
                            TextInputType.visiblePassword,
                            true,
                            _passwordController),
                        const SizedBox(
                          height: 70,
                        ),
                        SizedBox(
                          width: 200,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () async {
                              try {
                                final userCredential = await Auth().signIn(
                                  context: context,
                                    email: _emailController.text,
                                    password: _passwordController.text);
                                
                              } on FirebaseAuthException catch (e) {
                                String errorMessage = '';
                                if (e.code == 'invalid-credential') {
                                  errorMessage =
                                      'No user found for that email or password.';
                                } else {
                                  errorMessage =
                                      'An error occurred. Please try again later.';
                                }
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(errorMessage)));
                              }
                            },
                            style: ButtonStyle(
                                shape: WidgetStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                                backgroundColor:
                                    const WidgetStatePropertyAll(Colors.black)),
                            child: const Text(
                              "Sign in",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Create a new account?"),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const signUp()));
                        },
                        child: const Text(
                          "Sign up",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w800),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
