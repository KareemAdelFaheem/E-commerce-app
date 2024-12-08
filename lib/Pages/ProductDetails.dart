import 'dart:ffi';

import 'package:ecommerce/Widgets/inputs/Colors.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  final String category;
  final String name;
  final int stock;
  final String price;
  final String Description;
  // final String rates;
  const ProductDetails(
      {super.key,
      required this.name,
      required this.stock,
      required this.price,
      required this.Description,
      required this.category});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool _isExpanded = false;
  bool _isSSelected = false;
  bool _isMSelected = false;
  bool _isLSelected = false;
  Color SFillColor = AppColors.defaultSizeButtonColor;
  Color MFillColor = AppColors.defaultSizeButtonColor;
  Color LFillColor = AppColors.defaultSizeButtonColor;
  Color SborderColor = Colors.transparent;
  Color MborderColor = Colors.transparent;
  Color LborderColor = Colors.transparent;
  Color SColor = Colors.white.withOpacity(0.52);
  Color MColor = Colors.white.withOpacity(0.52);
  Color LColor = Colors.white.withOpacity(0.52);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                    // color: Colors.red,
                    height: 500,
                    width: MediaQuery.sizeOf(context).width,
                    child: Image.asset(
                      fit: BoxFit.contain,
                      "assets/images/cappuccino.png",
                      height: 500,
                    )),
                SizedBox(
                  height: 500,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15),
                        height: 137,
                        width: MediaQuery.sizeOf(context).width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color.fromRGBO(30, 14, 0, 0.67),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.category,
                                      style: const TextStyle(
                                        fontFamily: "poppins",
                                        fontSize: 28,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      widget.name,
                                      style: TextStyle(
                                        fontFamily: "poppinslight",
                                        fontSize: 18,
                                        color: Colors.white.withOpacity(0.51),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.star,
                                          size: 25,
                                          color: AppColors.primaryColor,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        const Text(
                                          "4.5",
                                          style: TextStyle(
                                              fontFamily: "poppins",
                                              fontSize: 20,
                                              color: Colors.white),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 100,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: 43,
                                              width: 46,
                                              decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    "assets/images/beans.png",
                                                    scale: 2,
                                                  ),
                                                  Text(
                                                    "Coffee",
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.white
                                                            .withOpacity(0.51),
                                                        fontFamily:
                                                            "poppinslight"),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 43,
                                              width: 46,
                                              decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    "assets/images/drop.png",
                                                    scale: 2,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                          height: 33,
                                          width: 117,
                                          decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Center(
                                            child: Text(
                                              "Made With Love",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: "poppinslight",
                                                  color: Colors.white
                                                      .withOpacity(0.51)),
                                            ),
                                          )),
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              // color: Colors.green,
              padding: const EdgeInsets.only(right: 20),
              height: 120,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Description",
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.83),
                        fontSize: 16,
                        fontFamily: "poppins"),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(widget.Description,
                            maxLines: _isExpanded ? 5 : 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.83),
                                fontSize: 14,
                                fontFamily: "poppinslight")),
                      ),
                      if (!_isExpanded)
                        TextButton(
                          child: Text(
                            "read more",
                            style: TextStyle(
                                fontSize: 14, color: AppColors.primaryColor),
                          ),
                          onPressed: () {
                            setState(() {
                              _isExpanded = true;
                            });
                          },
                        ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 20),
              height: 120,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Size",
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.51),
                        fontSize: 13,
                        fontFamily: "poppinlight"),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 110,
                        height: 37,
                        decoration: BoxDecoration(
                            color: SFillColor,
                            border: Border.all(width: 1, color: SborderColor),
                            borderRadius: BorderRadius.circular(8)),
                        child: TextButton(
                            onPressed: () {
                              setState(() {
                                _isSSelected = true;
                                SFillColor = Colors.black;
                                MFillColor = AppColors.defaultSizeButtonColor;
                                LFillColor = AppColors.defaultSizeButtonColor;
                                SborderColor = AppColors.primaryColor;
                                MborderColor = Colors.transparent;
                                LborderColor = Colors.transparent;
                                SColor = AppColors.primaryColor;
                                MColor = Colors.white.withOpacity(0.52);
                                LColor = Colors.white.withOpacity(0.52);
                              });
                            },
                            style: const ButtonStyle(
                              padding: WidgetStatePropertyAll(EdgeInsets.zero),
                            ),
                            child: Text(
                              "S",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: SColor,
                                  fontFamily: "poppins"),
                            )),
                      ),
                      Container(
                        width: 110,
                        height: 37,
                        decoration: BoxDecoration(
                            color: MFillColor,
                            border: Border.all(width: 1, color: MborderColor),
                            borderRadius: BorderRadius.circular(8)),
                        child: TextButton(
                            onPressed: () {
                              setState(() {
                                _isMSelected = true;
                                MFillColor = Colors.black;
                                SFillColor = AppColors.defaultSizeButtonColor;
                                LFillColor = AppColors.defaultSizeButtonColor;
                                MborderColor = AppColors.primaryColor;
                                SborderColor = Colors.transparent;
                                LborderColor = Colors.transparent;
                                MColor = AppColors.primaryColor;
                                SColor = Colors.white.withOpacity(0.52);
                                LColor = Colors.white.withOpacity(0.52);
                              });
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            child: Text(
                              "M",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: MColor,
                                  fontFamily: "poppins"),
                            )),
                      ),
                      Container(
                        width: 110,
                        height: 37,
                        decoration: BoxDecoration(
                            color: LFillColor,
                            border: Border.all(width: 1, color: LborderColor),
                            borderRadius: BorderRadius.circular(8)),
                        child: TextButton(
                            onPressed: () {
                              setState(() {
                                _isLSelected = true;
                                LFillColor = Colors.black;
                                SFillColor = AppColors.defaultSizeButtonColor;
                                MFillColor = AppColors.defaultSizeButtonColor;
                                LborderColor = AppColors.primaryColor;
                                MborderColor = Colors.transparent;
                                SborderColor = Colors.transparent;
                                LColor = AppColors.primaryColor;
                                MColor = Colors.white.withOpacity(0.52);
                                SColor = Colors.white.withOpacity(0.52);
                              });
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            child: Text(
                              "L",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: LColor,
                                  fontFamily: "poppins"),
                            )),
                      )
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Price",
                          style: TextStyle(
                              fontFamily: "poppinslight",
                              fontSize: 13,
                              color: Colors.white.withOpacity(0.51)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "\$",
                              style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 24,
                                  fontFamily: "poppins"),
                            ),
                            Text(
                              widget.price,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontFamily: "poppinslight",
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 74,
                    width: 262,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(AppColors.primaryColor),
                            shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)))),
                        onPressed: () {},
                        child: const Text(
                          "Buy Now",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "poppins",
                              color: Colors.white),
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
