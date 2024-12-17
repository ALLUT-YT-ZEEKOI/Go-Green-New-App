// ignore_for_file: deprecated_member_use, unnecessary_import
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gogreen_lite/Allproviders/main_provider.dart';
import 'package:gogreen_lite/customPackages/swipable_button.dart';
import 'package:gogreen_lite/main_home.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

bool done = false;

class Wrong extends StatefulWidget {
  const Wrong({super.key});

  @override
  State<Wrong> createState() => _WrongState();
}

class _WrongState extends State<Wrong> {
  @override
  void initState() {
    done = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final mainProvider = Provider.of<MainProvider>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(color: Color(0xFFF6F6F6)),
          height: double.infinity,
          width: size.width,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 35, 25, 0),
                child: Column(
                  children: [
                    const SizedBox(height: 60),
                    const SizedBox(height: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/sad 1.png', height: 250),
                        const SizedBox(height: 40),
                        const SizedBox(height: 30),
                        const Text('Oops!', style: TextStyle(color: Color(0xFF232323), fontSize: 45, fontFamily: 'Poppins', fontWeight: FontWeight.w700)),
                        const Text('Something went wrong', style: TextStyle(color: Color(0xFF232323), fontSize: 20, fontFamily: 'Poppins', fontWeight: FontWeight.w700)),
                        const SizedBox(height: 25),
                        SwipeableButtonView(
                            buttonText: 'SLIDE TO GO BACK HOME',
                            buttontextstyle: const TextStyle(color: Color(0xFF2F9623), fontSize: 13, fontWeight: FontWeight.w500),
                            buttonWidget: RippleAnimation(
                              color: const Color.fromARGB(255, 188, 236, 182),
                              delay: const Duration(milliseconds: 300),
                              minRadius: 15,
                              ripplesCount: 5,
                              child: SizedBox(width: 40, height: 40, child: Center(child: Image.asset('assets/icons/school 1.png', height: 30, color: Colors.green))),
                            ),
                            activeColor: const Color(0xFFF6F6F6),
                            buttonColor: Colors.transparent,
                            elevation: 0,
                            isbutton: false,
                            animationColor: const Color(0xFFF6F6F6),
                            isFinished: done,
                            onWaitingProcess: () async {
                              setState(() => done = true);
                            },
                            onFinish: () async {
                              mainProvider.homepageIndex = 0;
                              mainProvider.pageType = 0;
                              mainProvider.notify();
                              await Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: const MainHome()));
                            }),
                        if (!done) Container(color: const Color(0xFF2F9623), height: 1.5, margin: const EdgeInsets.symmetric(horizontal: 10))
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(bottom: 0, right: 0, child: Image.asset('assets/confirm-bottom.png', height: 75))
            ],
          ),
        ),
      ),
    );
  }
}
