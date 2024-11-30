import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gogreen_lite/Allproviders/v2_provider.dart';
import 'package:provider/provider.dart';

class HomePageFeaturedv2 extends StatelessWidget {
  const HomePageFeaturedv2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    final mainProvider = Provider.of<CourcelProvider_1>(context);
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
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFEDEDED),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child:  Column(
                    children: [
                      const Text(
                        'Easiest way to',
                        style: TextStyle(
                          color: Color(0xFF2383B8),
                          fontSize: 12,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w300,
                          height: 0.16,
                        ),
                      ),
                      Row(
                        children: [
                          const Column(
                            children: [
                              Text(
                                'Refer And Earn!',
                                style: TextStyle(
                                  color: Color(0xFF1A232E),
                                  fontSize: 22.50,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w700,
                                  height: 0.05,
                                ),
                              ),
                              Text(
                                "Earn for each referral,
  and enjoy \nup to 2500
  GGO Money.",
                                style: TextStyle(
                                  color: Color(0xFF1A232E),
                                  fontSize: 12,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w300,
                                  height: 0.12,
                                ),
                              )
                            ],
                          ),
                          Image.asset('assets/v2 Images/budget 1.png')
                        ],
                      ),
                    ],
                  ),
                );
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
