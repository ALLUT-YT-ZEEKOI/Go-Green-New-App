// ignore_for_file: deprecated_member_use, unnecessary_import
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gogreen_lite/Allproviders/main_provider.dart';
import 'package:gogreen_lite/extraStyle.dart';
import 'package:gogreen_lite/extrafunctions.dart';
import 'package:gogreen_lite/main_home.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class Conformed extends StatelessWidget {
  const Conformed({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final mainProvider = Provider.of<MainProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Container(
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment(0.00, -1.00), end: Alignment(0, 1), colors: [Color(0xFFF9EEDB), Color(0xFFFEFEFC)])),
          height: double.infinity,
          width: size.width,
          child: Stack(
            children: [
              Positioned(bottom: 0, right: 0, child: Image.asset('assets/confirm-bottom.png', height: 75)),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 60, 25, 0),
                child: ListView(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/confirm_bg.png'),
                        const SizedBox(height: 20),
                        Container(
                          height: 46,
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(43)),
                          child: MaterialButton(
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                            onPressed: () {
                              shareImageFromAssets();
                            },
                            child: SizedBox(
                              width: size.width,
                              child: Row(
                                children: [
                                  Image.asset('assets/icons/share.png', width: 40),
                                  const Expanded(
                                      child: Center(
                                          child: Text('Share Wellness Stories',
                                              textScaler: TextScaler.noScaling,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'Roboto', fontWeight: FontWeight.w500)))),
                                  const SizedBox(width: 40)
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: 46,
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(43)),
                          child: MaterialButton(
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                            onPressed: () async {
                              mainProvider.pageType = 0;
                              mainProvider.homepageIndex = 0;
                              await Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: const MainHome()));
                            },
                            child: SizedBox(
                              width: size.width,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Image.asset('assets/icons/home-fill.png', width: 40),
                                  ),
                                  const Expanded(
                                      child: Center(
                                          child: Text('Back to home',
                                              textScaler: TextScaler.noScaling,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'Roboto', fontWeight: FontWeight.w500)))),
                                  const SizedBox(width: 40)
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text('Order Confirmed!', textScaler: TextScaler.noScaling, style: TextStyle(color: Color(0xFF232323), fontSize: 32, fontFamily: 'Poppins', fontWeight: FontWeight.w700)),
                        const Text('Thriving Towards Wellness!',
                            textScaler: TextScaler.noScaling, style: TextStyle(color: Color(0xFF232323), fontSize: 16, fontFamily: 'Poppins', fontWeight: FontWeight.w700)),
                        const SizedBox(height: 15),
                        const Text('Thank you for choosing wellness', textScaler: TextScaler.noScaling, style: confirmationLabel1),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [const Text('with', textScaler: TextScaler.noScaling, style: confirmationLabel1), Image.asset('assets/icons/gg-logo-1.png', height: 30)]),
                        const SizedBox(height: 10),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                  text: 'Your order for ${mainProvider.selectedSubProduct?.name} is confirmed \nand it starts to deliver on ',
                                  style: const TextStyle(color: Color(0xFF232323), fontSize: 10, fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
                              TextSpan(text: formatDate(mainProvider.singleDate), style: const TextStyle(color: Colors.blue, fontSize: 10, fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
