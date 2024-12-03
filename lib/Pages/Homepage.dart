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
              CategoryItem(
                name: " Espresso",
                color: AppColors.enabledCateogryColor,
              ),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: AppColors.productContainerColor,
                    borderRadius: BorderRadius.circular(29)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/images/capp1.png",
                      scale: 3,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Text(
                      "5 Coffee beans for you\nMust try",
                      style: TextStyle(
                          fontFamily: "poppins",
                          color: Colors.white,
                          fontSize: 15),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.sizeOf(context).width;
    double deviceHeight = MediaQuery.sizeOf(context).height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
      child: Card(
        elevation: 2,
        color: Colors.white,
        child: SizedBox(
          height: deviceHeight * 0.36,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  product.image,
                  scale: 8,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(product.title),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      height: 25,
                      width: 55,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("${product.rating.rate}"),
                          const Icon(
                            Icons.star,
                            size: 17,
                          )
                        ],
                      ),
                    ),
                    Text(product.category.name)
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "${product.price} LE",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String name;
  final Color color;
  const CategoryItem({super.key, required this.name, required this.color});

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
                        color: color, fontFamily: "poppins", fontSize: 16),
                  )))),
    );
  }
}
