import 'package:flutter/material.dart';

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
                  padding: const EdgeInsets.all(8),
                  height: 285,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
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
                                height: 50,
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        width: 0.70, color: Color(0xFF1D2730)),
                                    borderRadius: BorderRadius.circular(4.19),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Buffalo Milk',
                                    style: TextStyle(
                                      color: Color(0xFF1D2730),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
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
                                width: 47,
                                height: 18.89,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFF2F9623),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3.69),
                                  ),
                                ),
                                child: const Row(
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
                                      '-',
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
                                  fontSize: 8.59,
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
                        width: 287,
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
                )
              ],
            ),
          ),
        ));
  }
}
