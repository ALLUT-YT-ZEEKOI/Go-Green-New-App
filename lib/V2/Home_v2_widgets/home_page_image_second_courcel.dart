import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gogreen_lite/Allproviders/v2_provider.dart';
import 'package:provider/provider.dart';

class HomePageImageSecondCourcel extends StatelessWidget {
  const HomePageImageSecondCourcel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    final mainProvider = Provider.of<Functions_v2>(context);
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
              height: 419.0,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                mainProvider.updateCaroselindex(index);
              }),
          items: [1, 2, 3].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    padding: const EdgeInsets.all(8),

                    // margin: const EdgeInsets.symmetric(horizontal: 25),
                    // decoration: ShapeDecoration(
                    //   color: const Color(0xFFE6F8FF),
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(15),
                    //   ),
                    // ),
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/v2 Images/fresh-healthy-fruits-straw-basket-generative-ai.jpg",
                          // width: screenWidth * .9,
                          // height: 500,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ));
              },
            );
          }).toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var i = 0; i < 3; i++)
              mainProvider.caroselindex == i
                  ? Container(
                      width: 15,
                      height: 5,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF00B761),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    )
                  : Container(
                      margin: const EdgeInsets.symmetric(horizontal: 1),
                      width: 5,
                      height: 5,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFDDD9D9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    )
          ],
        ),
      ],
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        foregroundColor: const Color(0xFF037ABC),
        backgroundColor: const Color(0xFFD2EEFF),
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 0.93,
            color: Color(0xFF037ABC),
            strokeAlign: BorderSide.strokeAlignOutside,
          ),
          borderRadius: BorderRadius.circular(12.97),
        ),
        // fixedSize: const Size(87.10, 30),
      ),
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Subscribe',
          style: TextStyle(
            color: Color(0xFF037ABC),
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
