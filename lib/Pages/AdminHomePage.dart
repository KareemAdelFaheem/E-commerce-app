import 'package:ecommerce/Auth.dart';
import 'package:ecommerce/Model/Products_model.dart';
import 'package:ecommerce/Pages/signIn.dart';
import 'package:ecommerce/Services.dart';
import 'package:ecommerce/Widgets/inputs/AuthTextField.dart';
import 'package:ecommerce/Pages/signUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Adminhomepage extends StatefulWidget {
  const Adminhomepage({super.key});

  @override
  State<Adminhomepage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Adminhomepage> {
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: TextField(
            decoration: InputDecoration(
                hintText: "Search for products...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
          toolbarHeight: 90,
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
            icon: const Icon(Icons.logout),
          ),
          actions: const [
            Icon(Icons.shopping_cart),
            SizedBox(
              width: 15,
            )
          ],
        ),
        body: const Center(
          child: Text("Admin Home Page"),
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
  const CategoryItem({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(5),
          color: Colors.white70),
      child: Center(
          child: SizedBox(
              width: 150,
              child: TextButton(
                  onPressed: () {},
                  child: Text(
                    name,
                    style: const TextStyle(color: Colors.black),
                  )))),
    );
  }
}
