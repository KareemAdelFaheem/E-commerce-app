import 'package:ecommerce/Auth.dart';
import 'package:ecommerce/Pages/BottomNavigationBar.dart';
import 'package:ecommerce/Widgets/inputs/Colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<Map<String, dynamic>> cartItem = List.empty();
  bool isLoading = true;

  @override
  void initState() {
    getCartItems();
    super.initState();
  }

  Future<void> getCartItems() async {
    try {
      var fetchedCartItems =
          await Auth().getCart(context, FirebaseAuth.instance.currentUser!);

      setState(() {
        cartItem = fetchedCartItems;
        isLoading = false;
      });

      print("cart length: ${cartItem.length}");
      print("cart is empty : ${cartItem.isEmpty}");
    } catch (e) {
      print("cart is empty");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 100),
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : (cartItem.isEmpty)
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "MyCart",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontFamily: "poppins",
                          ),
                        ),
                        Image.asset("assets/images/illustration.png"),
                        Container(
                          child: const Column(
                            children: [
                              Text(
                                "Ouch! Thirsty",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "inter",
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 50.0),
                                child: Text(
                                  textAlign: TextAlign.center,
                                  "Seems like you have not ordered any coffee yet",
                                  style: TextStyle(
                                    color: Color.fromRGBO(135, 135, 135, 1),
                                    fontFamily: "interlight",
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 52,
                          width: 327,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MyBottomNavigationBar()),
                                  (Route<dynamic> route) => false);
                            },
                            style: ButtonStyle(
                                shape: WidgetStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100))),
                                backgroundColor: WidgetStatePropertyAll(
                                    AppColors.primaryColor)),
                            child: const Text(
                              "Find Coffee",
                              style: TextStyle(
                                  fontFamily: "poppins",
                                  fontSize: 16,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        const Text(
                          "MyCart",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontFamily: "poppins",
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                              itemCount: cartItem.length,
                              itemBuilder: (context, index) {
                                return SizedBox(
                                    width: MediaQuery.sizeOf(context).width,
                                    height: 100,
                                    child: Card(
                                      color:
                                          const Color.fromRGBO(56, 55, 55, 1),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          // mainAxisAlignment:
                                          //     MainAxisAlignment.spaceAround,
                                          children: [
                                            Image.asset(
                                                "assets/images/cartcoffee.png"),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            SizedBox(
                                              // color: Colors.red,
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.6,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8),
                                                    child: Text(
                                                      maxLines: 1,
                                                      "${cartItem[index]['category']} ${cartItem[index]['name']} ",
                                                      style: TextStyle(
                                                          fontFamily: "poppins",
                                                          fontSize: 14,
                                                          color: Colors.white
                                                              .withOpacity(
                                                                  0.34)),
                                                    ),
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: const Color
                                                            .fromRGBO(
                                                            9, 3, 3, 0.3),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)),
                                                    width: 120,
                                                    height: 40,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        IconButton(
                                                            onPressed: () {},
                                                            icon: Container(
                                                              decoration: BoxDecoration(
                                                                  color: AppColors
                                                                      .primaryColor,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50)),
                                                              child: const Icon(
                                                                  color: Colors
                                                                      .white,
                                                                  Icons.remove),
                                                            )),
                                                        const Text(
                                                          "1",
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontFamily:
                                                                  "poppins",
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        IconButton(
                                                            onPressed: () {},
                                                            icon: Container(
                                                              decoration: BoxDecoration(
                                                                  color: AppColors
                                                                      .primaryColor,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50)),
                                                              child: const Icon(
                                                                  color: Colors
                                                                      .white,
                                                                  Icons.add),
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 2,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "\$",
                                                    style: TextStyle(
                                                        fontFamily: "poppins",
                                                        fontSize: 20,
                                                        color: AppColors
                                                            .primaryColor),
                                                  ),
                                                  Text(
                                                    cartItem[index]['price'],
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        fontFamily:
                                                            "poppinslight",
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ));

                                // ListTile(
                                //   contentPadding: EdgeInsets.zero,
                                //   leading: Image.asset("assets/images/cartcoffee.png"),
                                //   title: Text(
                                //       "${cartItem[index]['category']} ${cartItem[index]['name']}"),
                                // );
                              }),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}
