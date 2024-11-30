import 'package:flutter/material.dart';
import 'package:gogreen_lite/V2/Home_v2_widgets/main_product_card_v2.dart';
import 'package:gogreen_lite/V2/custom_height_v2.dart';

class CartScreenV2 extends StatelessWidget {
  const CartScreenV2({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: const Color(0xFFF6F6F6),
        appBar: AppBar(
          title: const Text(
            'Your Cart',
            style: TextStyle(
              color: Color(0xFF1D2730),
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0, // To remove the shadow under the AppBar
          iconTheme: const IconThemeData(
              color: Color(0xFF1D2730)), // To change the back button color
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/v2 Images/clock_loader_40.png',
                          width: 40,
                        ),
                        const Text(
                          'Delivery in 13 minutes',
                          style: TextStyle(
                            color: Color(0xFF1D2730),
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      textAlign: TextAlign.end,
                      'Shipment of 5 items',
                      style: TextStyle(
                        color: Color(0xFF999999),
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
                Container(
                  width: screenWidth * .9,
                  padding: const EdgeInsets.all(10),
                  height: 320,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 45,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                              width: 0.70,
                                              color: Color(0xFF1D2730)),
                                          borderRadius:
                                              BorderRadius.circular(4.19),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Buffalo Milk',
                                          style: TextStyle(
                                            color: Color(0xFF1D2730),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              '500 ML',
                                              style: TextStyle(
                                                color: Color(0xFF1D2730),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Image.asset(
                                              'assets/v2 Images/fluent-emoji-high-contrast_farmer.png',
                                              width: 20,
                                            ),
                                            const Text(
                                              'Bhuvaneswari',
                                              style: TextStyle(
                                                color: Color(0xFF2F9623),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      width: screenWidth * .1 + 20,
                                      height: 33,
                                      decoration: ShapeDecoration(
                                        color: const Color(0xFF2F9623),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(3.69),
                                        ),
                                      ),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            '-',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 8.75,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                              height: 0,
                                            ),
                                          ),
                                          Text(
                                            '0',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 8.75,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                              height: 0,
                                            ),
                                          ),
                                          Text(
                                            '+',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 8.75,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                              height: 0,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const Text(
                                      '₹600/Lt',
                                      style: TextStyle(
                                        color: Color(0xFF1D2730),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: screenWidth * .9,
                              decoration: const ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 1,
                                    strokeAlign: BorderSide.strokeAlignCenter,
                                    color: Color(0x111D2730),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Farm Fresh Picks',
                      style: TextStyle(
                        color: Color(0xFF202020),
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      width: screenWidth * 0.3,
                      height: 3,
                      decoration: ShapeDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment(1.00, 0.00),
                          end: Alignment(-1, 0),
                          colors: [Color(0xFFF3F3F3), Colors.white],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                    const Text(
                      'See All',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color(0xFF00B761),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 18,
                ),
                const MainProductCardV2(),
                const SizedBox(
                  height: 18,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Farm Fresh Picks',
                      style: TextStyle(
                        color: Color(0xFF202020),
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                    CustomElevatedButton(screenWidth: screenWidth)
                  ],
                ),
                const CustomHeightV2(),
                Container(
                  // width: 311,
                  height: 100,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                    child: TextField(
                      maxLines:
                          null, // Allows the text field to expand vertically if needed
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter text here...',
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 100, 97, 97),
                              fontSize: 12)),
                    ),
                  ),
                ),
                const CustomHeightV2(),
                const Text(
                  'Coupons & discount',
                  style: TextStyle(
                    color: Color(0xFF202020),
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                  ),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
                const CustomHeightV2(),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/v2 Images/bxs_offer.png',
                                width: 40,
                              ),
                              const Text(
                                'Delivery in 13 minutes',
                                style: TextStyle(
                                  color: Color(0xFF1D2730),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const Text(
                            textAlign: TextAlign.end,
                            'Shipment of 5 items',
                            style: TextStyle(
                              color: Color(0xFF999999),
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.black,
                                width: 1.0,
                              ),
                            )),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: TextField(
                                  focusNode: FocusNode(),
                                  decoration: InputDecoration(
                                    hintText: 'Enter text here...',
                                    hintStyle: const TextStyle(
                                      color: Color(0xFF909090),
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade300),
                                    ),
                                    // Remove text input underline
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: GestureDetector(
                                onTap: () {
                                  // Your button click logic
                                  print("Apply button clicked");
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        style: BorderStyle.none), // No border
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    'Apply',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 14, 13, 13),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const CustomHeightV2(),
                const Text(
                  'Bill details',
                  style: TextStyle(
                    color: Color(0xFF202020),
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                  ),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
                const CustomHeightV2(),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/v2 Images/bxs_offer.png',
                                width: 28,
                              ),
                              const Text(
                                'Items total',
                                style: TextStyle(
                                  color: Color(0xFF1D2730),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFF0F9FF),
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        width: 0.51, color: Color(0xFF037ABC)),
                                    borderRadius: BorderRadius.circular(2.98),
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Saved ₹500',
                                    style: TextStyle(
                                      color: Color(0xFF037ABC),
                                      fontSize: 8,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const Row(
                            children: [
                              Text(
                                '₹50739',
                                style: TextStyle(
                                  color: Color(0xFF909090),
                                  fontSize: 10,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                '₹50739',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/v2 Images/bxs_offer.png',
                                width: 28,
                              ),
                              const Text(
                                'Delivery charge',
                                style: TextStyle(
                                  color: Color(0xFF1D2730),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const Row(
                            children: [
                              Text(
                                '₹50739',
                                style: TextStyle(
                                  color: Color(0xFF909090),
                                  fontSize: 10,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                'FREE',
                                style: TextStyle(
                                  color: Color(0xFF037ABC),
                                  fontSize: 10,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/v2 Images/bxs_offer.png',
                                width: 28,
                              ),
                              const Text(
                                'Delivery charge',
                                style: TextStyle(
                                  color: Color(0xFF1D2730),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const Row(
                            children: [
                              Text(
                                '₹50739',
                                style: TextStyle(
                                  color: Color(0xFF909090),
                                  fontSize: 10,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                'FREE',
                                style: TextStyle(
                                  color: Color(0xFF037ABC),
                                  fontSize: 10,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      Container(
                        decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1,
                              strokeAlign: BorderSide.strokeAlignCenter,
                              color: Color(0x071D2730),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/v2 Images/bxs_offer.png',
                                width: 28,
                              ),
                              const Text(
                                'Grand Total',
                                style: TextStyle(
                                  color: Color(0xFF1D2730),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                          const Row(
                            children: [
                              Text(
                                '₹48564',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const ShapeDecoration(
                    color: Color(0xAAC0EAFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Your total savings',
                            style: TextStyle(
                              color: Color(0xFF037ABC),
                              fontSize: 10,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                          Text(
                            '₹50739',
                            style: TextStyle(
                              color: Color(0xFF037ABC),
                              fontSize: 10,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          )
                        ],
                      ),
                      Text(
                        'Includes ₹25 savings through free delivery',
                        style: TextStyle(
                          color: Color(0xFF037ABC),
                          fontSize: 6,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      )
                    ],
                  ),
                ),
                const CustomHeightV2(),
                const Text(
                  'Bill details',
                  style: TextStyle(
                    color: Color(0xFF202020),
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                  ),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
                const CustomHeightV2(),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: screenWidth * .4 + 10,
                            padding: const EdgeInsets.all(7),
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 1, color: Color(0xFFDFDFDF)),
                                borderRadius: BorderRadius.circular(7),
                              ),
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/v2 Images/Vector123.png',
                                  width: 16,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                const Text(
                                  'Avoid ringing bell',
                                  style: TextStyle(
                                    color: Color(0xFF1D2730),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Container(
                            width: screenWidth * .4 + 10,
                            padding: const EdgeInsets.all(7),
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 1, color: Color(0xFFDFDFDF)),
                                borderRadius: BorderRadius.circular(7),
                              ),
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/v2 Images/Vector123.png',
                                  width: 16,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                const Text(
                                  'Avoid ringing bell',
                                  style: TextStyle(
                                    color: Color(0xFF1D2730),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class CustomElevatedButton extends StatelessWidget {
  final double screenWidth;

  const CustomElevatedButton({super.key, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 30,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          foregroundColor: const Color(0xFFFFF6F1),
          // backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 0.93,
              color: Color(0xFFF28B51),
            ),
            borderRadius: BorderRadius.circular(8.97),
          ),
        ),
        child: const Text(
          'Change',
          style: TextStyle(
            color: Color(0xFFF28B51),
            fontSize: 10,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            height: 0,
          ),
        ),
      ),
    );
  }
}
