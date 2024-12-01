import 'package:ecommerce/Auth.dart';
import 'package:ecommerce/Widgets/inputs/AuthTextField.dart';
import 'package:ecommerce/extensions/string_extensions.dart';
import 'package:ecommerce/Pages/signIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class signUp extends StatefulWidget {
  const signUp({super.key});

  @override
  State<signUp> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<signUp> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();

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
                    key: formkey,
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
                        TextFormField(
                          controller: _passwordController,
                          validator: (input) {
                            if (input == null || input.isEmpty) {
                              return "Password can't be null";
                            }

                            if (!input.isValidPassword()) {
                              return "Check you Password";
                            }

                            return null;
                          },
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[200],
                              hintText: "Enter Password",
                              hintStyle: TextStyle(color: Colors.grey[800]),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _confirmpasswordController,
                          validator: (input) {
                            if (input == null || input.isEmpty) {
                              return "Please Confirm your Password";
                            }

                            if (input != _passwordController.text) {
                              return "Passwords don't match";
                            }

                            return null;
                          },
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[200],
                              hintText: "Confirm Password",
                              hintStyle: TextStyle(color: Colors.grey[800]),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                        const SizedBox(
                          height: 70,
                        ),
                        SizedBox(
                          width: 200,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (formkey.currentState?.validate() ?? false) {
                                try {
                                  await Auth().signUp(
                                      email: _emailController.text,
                                      password: _passwordController.text);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "Account created successfully")));
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => signIn(
                                                useremail:
                                                    _emailController.text,
                                                userpassword:
                                                    _passwordController.text,
                                              )),
                                      (Route<dynamic> route) => false);
                                  Auth().signOut();
                                } on FirebaseAuthException catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("${e.message}")));
                                }
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
                              "Sign Up",
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
                    const Text("already have an account?"),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => signIn()));
                        },
                        child: const Text(
                          "Sign in",
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
