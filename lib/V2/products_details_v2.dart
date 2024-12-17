import 'package:flutter/material.dart';
import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart';
import 'package:gogreen_lite/V2/Home_v2_widgets/main_product_card_v2.dart';

import 'package:gogreen_lite/V2/Products_v2_widgets/ProductsDetailsAccordion.dart';

class ProductsDetailsV2 extends StatefulWidget {
  const ProductsDetailsV2({super.key});

  @override
  State<ProductsDetailsV2> createState() => _ProductsDetailsV2State();
}

class _ProductsDetailsV2State extends State<ProductsDetailsV2> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double rating = 0.0;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Country Sugar',
          style: TextStyle(
            color: Color(0xFF1D2730),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0, // To remove the shadow under the AppBar
        iconTheme: const IconThemeData(
            color: Color(0xFF1D2730)), // To change the back button color
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      // width: 370,
                      height: 306,
                      decoration: const BoxDecoration(
                        color: Color(0xFFD9D9D9),
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: const ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(7)),
                              ),
                            ),
                            child: Row(
                              children: [
                                PannableRatingBar(
                                  rate: rating,
                                  items: List.generate(
                                      5,
                                      (index) => const RatingWidget(
                                            selectedColor: Colors.yellow,
                                            unSelectedColor: Colors.grey,
                                            child: Icon(
                                              Icons.star,
                                              size: 20,
                                            ),
                                          )),
                                  onHover: (value) {
                                    // the rating value is updated every time the cursor moves over a new item.
                                    setState(() {
                                      rating = value;
                                    });
                                  },
                                ),
                                const Text(
                                  '(20k)',
                                  style: TextStyle(
                                    color: Color(0xFF1D2730),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                  ),
                                )
                              ],
                            )))
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Country Sugar',
                        style: TextStyle(
                          color: Color(0xFF202020),
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            // width: screenWidth * .4 + 25,
                            padding: const EdgeInsets.all(12),
                            decoration: ShapeDecoration(
                              color: const Color(0xFFE5FCE3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.73),
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 7.24,
                                  height: 7.31,
                                  decoration: const ShapeDecoration(
                                    color: Color(0xFF305C25),
                                    shape: OvalBorder(),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                const Text(
                                  'Enhances skin & Hair Health',
                                  style: TextStyle(
                                    color: Color(0xFF305C25),
                                    fontSize: 9,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 1, color: Color(0xFF2F9623)),
                                borderRadius: BorderRadius.circular(3.69),
                              ),
                            ),
                            child: const Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '-',
                                  style: TextStyle(
                                    color: Color(0xFF2F9623),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  '1',
                                  style: TextStyle(
                                    color: Color(0xFF2F9623),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  '+',
                                  style: TextStyle(
                                    color: Color(0xFF2F9623),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        '100 g',
                        style: TextStyle(
                          color: Color(0xFF302E2E),
                          fontSize: 17.15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Text(
                            '₹499',
                            style: TextStyle(
                              color: Color(0xFF202020),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            width: 9,
                          ),
                          const Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'M.R.P: ',
                                  style: TextStyle(
                                    color: Color(0xFF202020),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                TextSpan(
                                  text: '₹299 ',
                                  style: TextStyle(
                                    color: Color(0xFF202020),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300,
                                    decoration: TextDecoration
                                        .lineThrough, // Strikethrough effect
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 9,
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                            decoration: ShapeDecoration(
                              color: const Color(0xFFE2F0FF),
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 0.89, color: Color(0xFF308CEF)),
                                borderRadius: BorderRadius.circular(5.26),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                '60% off',
                                style: TextStyle(
                                  color: Color(0xFF308CEF),
                                  fontSize: 8.92,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        '(Inclusive of all taxes)',
                        style: TextStyle(
                          color: Color(0xFF302E2E),
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 2,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFF3F3F3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Image.asset(
                        'assets/v2 Images/Choose your farmer.png',
                        width: screenWidth * .4,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 47.89,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 1.04, color: Color(0xFFF3F3F3)),
                            borderRadius: BorderRadius.circular(12.49),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 40.31,
                                  height: 40.31,
                                  decoration: const ShapeDecoration(
                                    color: Color(0xFFD9D9D9),
                                    shape: OvalBorder(),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Bhuvaneswari',
                                      style: TextStyle(
                                        color: Color(0xFF2F9623),
                                        fontSize: 13.28,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        PannableRatingBar(
                                          rate: rating,
                                          items: List.generate(
                                              5,
                                              (index) => const RatingWidget(
                                                    selectedColor:
                                                        Colors.yellow,
                                                    unSelectedColor:
                                                        Colors.grey,
                                                    child: Icon(
                                                      Icons.star,
                                                      size: 20,
                                                    ),
                                                  )),
                                          onHover: (value) {
                                            // the rating value is updated every time the cursor moves over a new item.
                                            setState(() {
                                              rating = value;
                                            });
                                          },
                                        ),
                                        const Text(
                                          '(20k)',
                                          style: TextStyle(
                                            color: Color(0xFF1D2730),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                            const Text(
                              '₹300/Lt',
                              style: TextStyle(
                                color: Color(0xFF1D2730),
                                fontSize: 15.18,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const ShapeDecoration(
                          color: Color(0xAAC0EAFF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Choose another farmer',
                            style: TextStyle(
                              color: Color(0xFF037ABC),
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const AccordionDemo(),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Similar products',
                        style: TextStyle(
                          color: Color(0xFF202020),
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const MainProductCardV2(),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 1, color: Color(0xFF2383B8)),
                            borderRadius: BorderRadius.circular(16.96),
                          ),
                        ),
                        child: const Center(
                          child: SizedBox(
                            child: Text(
                              'See all products',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF2383B8),
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
          Positioned(
              bottom: 3,
              left: 8,
              right: 8,
              child: Container(
                // width: screenWidth * .8,
                padding: const EdgeInsets.all(10),
                decoration: ShapeDecoration(
                  color: const Color(0xFF2F9623),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(43),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '₹50638',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'TOTAL',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'Add To Cart',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Image.asset(
                          'assets/v2 Images/arrow_circle_right.png',
                          width: 20,
                        )
                      ],
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
