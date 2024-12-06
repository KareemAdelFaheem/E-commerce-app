import 'package:ecommerce/Auth.dart';
import 'package:ecommerce/Model/Products_model.dart';
import 'package:ecommerce/Pages/signIn.dart';
import 'package:ecommerce/Services.dart';
import 'package:ecommerce/Widgets/inputs/AuthTextField.dart';
import 'package:ecommerce/Pages/signUp.dart';
import 'package:ecommerce/Widgets/inputs/Colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  late Future<List<Product>?> productsFuture;
  late Future<List<String>?> categoriesFuture;
  @override
  void initState() {
    super.initState();
    productsFuture = RemoteServices.fetchProducts();
    categoriesFuture = RemoteServices.fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          toolbarHeight: 100,
          elevation: 1,
          leading: IconButton(
            onPressed: () async {
              try {
                Auth().signOut();
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Signed out successfully!")));
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => signIn()),
                    (Route<dynamic> route) => false);
              } on FirebaseAuthException catch (e) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(e.message!)));
              }
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
          actions: const [
            Icon(
              Icons.account_circle,
              size: 40,
              color: Colors.white,
            ),
            SizedBox(
              width: 15,
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Find the best\ncoffee for you",
                style: TextStyle(
                    fontSize: 32,
                    fontFamily: "poppins",
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 54,
                width: 351,
                child: TextField(
                  decoration: InputDecoration(
                      prefixIcon: Image.asset(
                        "assets/images/search.png",
                        scale: 2,
                      ),
                      filled: true,
                      fillColor: AppColors.textFieldFillColor,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15)),
                      hintText: "Find your coffee...",
                      hintStyle: TextStyle(
                          fontFamily: "poppins",
                          color: AppColors.textFieldHintColor)),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 100,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return const Row(
                        children: [
                          CategoryItem(name: "Espresso"),
                        ],
                      );
                    }),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 300,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return const Row(
                        children: [
                          ProductItem(
                              image: "assets/images/capp1.png",
                              title: "Cappuccino",
                              subtitle: "With Oat Milk",
                              price: "4.20"),
                          SizedBox(
                            width: 20,
                          ),
                          ProductItem(
                              image: "assets/images/capp2.png",
                              title: "Cappuccino",
                              subtitle: "With Chocolate",
                              price: "3.14"),
                          SizedBox(
                            width: 20,
                          )
                        ],
                      );
                    }),
              ),

              // const Text(
              //   "Special For you",
              //   style: TextStyle(
              //       color: Colors.white,
              //       fontFamily: "poppins",
              //       fontSize: 16,
              //       fontWeight: FontWeight.w700),
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // Container(
              //   padding: const EdgeInsets.all(15),
              //   decoration: BoxDecoration(
              //       color: AppColors.productContainerColor,
              //       borderRadius: BorderRadius.circular(29)),
              //   child: Row(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Image.asset(
              //         "assets/images/capp1.png",
              //         scale: 3,
              //       ),
              //       const SizedBox(
              //         width: 20,
              //       ),
              //       const Text(
              //         "5 Coffee beans for you\nMust try",
              //         style: TextStyle(
              //             fontFamily: "poppins",
              //             color: Colors.white,
              //             fontSize: 15),
              //       )
              //     ],
              //   ),
              // ),
            ],
          ),
        ));
  }
}



class CategoryItem extends StatelessWidget {
  final String name;

  const CategoryItem({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Center(
          child: SizedBox(
              width: 150,
              child: TextButton(
                  onPressed: () {},
                  child: Text(
                    name,
                    style: TextStyle(
                        color: AppColors.disabledCategoryColor, fontFamily: "poppins", fontSize: 16),
                  )))),
    );
  }
}

class ProductItem extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final String price;

  const ProductItem(
      {super.key,
      required this.image,
      required this.title,
      required this.subtitle,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 200,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: AppColors.productContainerColor,
            borderRadius: BorderRadius.circular(29)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              image,
              scale: 1,
            ),
            const SizedBox(
              width: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6.0),
              child: Text(
                title,
                style: const TextStyle(
                    fontFamily: "poppins",
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6.0),
              child: Text(
                subtitle,
                style: const TextStyle(
                    fontFamily: "poppins",
                    color: Color.fromRGBO(255, 255, 255, 0.51),
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 6.0),
                  child: Row(
                    children: [
                      Text("\$",
                          style: TextStyle(
                              fontFamily: "poppins",
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 16)),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        price,
                        style: const TextStyle(
                            fontFamily: "poppins",
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 34,
                  width: 36,
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
