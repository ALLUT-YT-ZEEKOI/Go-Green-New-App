import 'package:flutter/material.dart';
import 'package:flutter_ellipsis_text/flutter_ellipsis_text.dart';
import 'package:gogreen_lite/V2/Home_v2_widgets/home_page_Featured)v2..dart';
import 'package:gogreen_lite/V2/Home_v2_widgets/home_page_first_courcel_v2.dart';
import 'package:gogreen_lite/V2/Home_v2_widgets/home_page_image_second_courcel.dart';
import 'package:gogreen_lite/V2/Home_v2_widgets/main_product_card_v2.dart';
import 'package:gogreen_lite/V2/cart_screen_v2.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreenV2 extends StatelessWidget {
  const HomeScreenV2({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int famCategoryCount = 5;
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 245, 247, 253),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 245, 247, 253),
        toolbarHeight: 150.0,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/v2 Images/Group10.png',
                            width: 40,
                            height: 25,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            width: screenWidth * 0.02,
                          ),
                          const Text(
                            'Abad Sait',
                            style: TextStyle(
                              color: Color(0xFF1D2730),
                              fontSize: 19,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 35.0,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      const Row(
                        children: [
                          Expanded(
                            child: EllipsisText(
                              text: "Abad Plaza, Bengaluru, Karnataka",
                              ellipsis: "..show more",
                              maxLines: 1,
                              style: TextStyle(
                                color: Color(0xFF909090),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  "assets/v2 Images/user 10.png",
                  width: 60.0,
                  height: 60.0,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: screenWidth * .9,
              decoration: BoxDecoration(
                color: const Color(0xFFF8F8F8),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Row(
                children: [
                  // Search Icon
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(
                      Icons.search,
                      color: Color.fromARGB(255, 0, 0, 0),
                      size: 25,
                    ),
                  ),
                  // Search Text Field
                  Expanded(
                    child: TextField(
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF959595),
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search “condom”',
                        hintStyle: TextStyle(
                          color: Color(0xFF959595),
                          fontSize: 15,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  const HomePageFirstCourcelV2(),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: screenWidth * 0.3,
                        height: 3,
                        decoration: ShapeDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment(-1, 0),
                            end: Alignment(1.00, 0.00),
                            colors: [
                              Color(0xFFF3F3F3),
                              Colors.white,
                            ],
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ),
                      const Text(
                        'Direct From Farm',
                        style: TextStyle(
                          color: Color(0xFF202020),
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                        ),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                      Expanded(
                        child: Container(
                          // width: screenWidth * 0.3,
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
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    height: 125,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: famCategoryCount,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CartScreenV2()),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.all(3),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/v2 Images/Mask grou0.p.png',
                                  width: 100,
                                  height: 100,
                                ),
                                const Text(
                                  'Gingely Oil',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Background Image
                  Image.asset(
                    'assets/v2 Images/Group 1744.png',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  // Icon at the start-middle
                  const Positioned(
                    left: 8,
                    top: 0,
                    bottom: 0,
                    child: Icon(
                      Icons.cloudy_snowing,
                      size: 30,
                      color: Color.fromRGBO(13, 130, 207, 1),
                    ),
                  ),
                  // Dynamic Ellipsis Text
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 45), // Add horizontal padding
                    alignment: Alignment.center,
                    child: const EllipsisText(
                      text:
                          'Riders may slow down to be safe during rains. Don’t worry, your products will be delivered with care!',
                      ellipsis: '...',
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const HomePageImageSecondCourcel(),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  Stack(
                    children: [
                      Image.asset(
                        'assets/v2 Images/Group 109.png',
                        // width: screenWidth * .9,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        top: 20,
                        left: 0,
                        right: 0,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/v2 Images/Layer 1.png',
                              width: 40,
                            ),
                            SizedBox(
                              width: screenWidth * .6,
                              child: Text(
                                'Subscribe Organic Milk directly from farmers.',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle
                                      .italic, // This sets the text to italic
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
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
                      Expanded(
                        child: Container(
                          width: screenWidth * 0.6,
                          height: 3,
                          decoration: ShapeDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment(-1, 0),
                              end: Alignment(1.00, 0.00),
                              colors: [Color(0xFFF3F3F3), Colors.white],
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            width: screenWidth * .4 + 15,
                            decoration: ShapeDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment(0.00, -1.00),
                                end: Alignment(0, 1),
                                colors: [Color(0xFFFDFCF7), Color(0xFFF9EEDC)],
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                Image.asset('assets/v2 Images/EGG 1.png'),
                                const Text(
                                  'Egg',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Text(
                                  'FREE',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10.62,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '60',
                                      style: TextStyle(
                                        color: Color(0xFF9B9999),
                                        fontSize: 7.98,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      '100 g',
                                      style: TextStyle(
                                        color: Color(0xFF302E2E),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          Positioned(
                            top:
                                -20, // Adjust this value to move the image further out
                            left:
                                -20, // Adjust this value to move the image further left
                            child: Image.asset(
                              'assets/v2 Images/get.png',
                              width: 100,
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            width: screenWidth * .4 + 15,
                            decoration: ShapeDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment(0.00, -1.00),
                                end: Alignment(0, 1),
                                colors: [Color(0xFFF3F8FF), Color(0xFFB8D5FF)],
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                Center(
                                  child: Image.asset(
                                      'assets/v2 Images/Group.png',
                                      height: 100),
                                ),
                                const Text(
                                  'Egg',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Text(
                                  'FREE',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10.62,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '60',
                                      style: TextStyle(
                                        color: Color(0xFF9B9999),
                                        fontSize: 7.98,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      '100 g',
                                      style: TextStyle(
                                        color: Color(0xFF302E2E),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          Positioned(
                            top:
                                -20, // Adjust this value to move the image further out
                            left:
                                -20, // Adjust this value to move the image further left
                            child: Image.asset(
                              'assets/v2 Images/get.png',
                              width: 100,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    decoration: const BoxDecoration(
                      color: Color(0xFFE4FFE1),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Get up to 60% off &\nExtra cashback!',
                              style: TextStyle(
                                color: Color(0xFF2F9623),
                                fontSize: 22.50,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Image.asset(
                              'assets/v2 Images/Frame 10.png',
                              width: screenWidth * .2 + 10,
                            ),
                          ],
                        ),
                        GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 12,
                              childAspectRatio: 0.75,
                            ),
                            shrinkWrap: true,
                            physics:
                                const NeverScrollableScrollPhysics(), // Avoids internal scrolling
                            itemCount: 3, // Replace with your actual item count
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                          width: 0.62,
                                          strokeAlign:
                                              BorderSide.strokeAlignOutside,
                                          color: Color(0xFFD9D9D9),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.68),
                                      ),
                                    ),
                                    child: Image.asset(
                                      'assets/v2 Images/lays 10.png',
                                      width: 100, // Adjust width as necessary
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Extra Cheesy Lays Classic',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              );
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: screenWidth * .9,
                          height: 60,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  WidgetStateProperty.all(Colors.green),
                            ),
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(
                                  width: 112,
                                  child: Text(
                                    'Try GGO Offer',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                    width:
                                        8), // Add spacing between text and image
                                Image.asset(
                                  "assets/v2 Images/Vector.png",
                                  width: 20,
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                        'Farm Fresh Picks',
                        style: TextStyle(
                          color: Color(0xFF202020),
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                        ),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                      Expanded(
                        child: Container(
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
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const HomePageFeaturedv2(),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'India’',
                          style: TextStyle(
                            color: Color(0xFF959595),
                            fontSize: 13.55,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: ' 1st',
                          style: TextStyle(
                            color: Color(0xFF2F9623),
                            fontSize: 29.01,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        TextSpan(
                          text: '  Platform',
                          style: TextStyle(
                            color: Color(0xFF959595),
                            fontSize: 13.55,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    'to Choose \nYour Farmer',
                    style: TextStyle(
                      color: Color(0xFF8B8B8B),
                      fontSize: 42.37,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const Text('Harvested with ❤️, Delivered to Your Doorstep',
                      style: TextStyle(
                        color: Color(0xFF959595),
                        fontSize: 12.50,
                        fontWeight: FontWeight.w300,
                      )),
                ],
              ),
            ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
