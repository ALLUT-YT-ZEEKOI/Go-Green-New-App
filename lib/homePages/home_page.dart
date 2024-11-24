import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gogreen_lite/Allproviders/api_provider.dart';
import 'package:gogreen_lite/Allproviders/main_provider.dart';
import 'package:provider/provider.dart';
import '../extrafunctions.dart';
import '../extrawidgets.dart';
import 'widgets/subscribe_banner.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isShaking = false;
  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 5), (timer) {
      if (mounted) {
        setState(() {
          _isShaking = !_isShaking;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ApiProvider apiProvider = Provider.of<ApiProvider>(context);
    final MainProvider mainProvider = Provider.of<MainProvider>(context);
    return Container(
      height: size.height,
      width: size.width,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: const Color(0xFFF5F5F5),
      child: apiProvider.intialPreload
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  if (!mainProvider.avilable)
                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      width: size.width,
                      decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                          shadows: const [BoxShadow(color: Color(0x14000000), blurRadius: 4, offset: Offset(0, 0), spreadRadius: 0)]),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Expanded(
                            child: Text("Oops! 🚫 We're not serving your area just yet, but we're on our way! 🏃‍♂️ Stay tuned for our grand entrance!",
                                textScaler: TextScaler.noScaling,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Color(0xFF00557F), fontSize: 13.5, fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
                          ),
                        ]),
                      ),
                    ),
                  const SizedBox(height: 15),
                  if (apiProvider.userDetails != null && (apiProvider.mysubscription.isNotEmpty || mainProvider.avilable))
                    apiProvider.mysubscription.isEmpty
                        ? Container(
                            width: size.width,
                            // height: 106,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(side: const BorderSide(width: 1, color: Color(0x42909090)), borderRadius: BorderRadius.circular(18)),
                              shadows: const [BoxShadow(color: Color(0x14000000), blurRadius: 4, offset: Offset(0, 0), spreadRadius: 0)],
                            ),
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
                              Image.asset('assets/icons/object 1.png', height: 70),
                              const SizedBox(width: 20),
                              Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [for (var i = 0; i < 4; i++) verticalDot]),
                              ),
                              Expanded(
                                child: Padding(padding: const EdgeInsets.all(4.0), child: Image.asset('assets/icons/My wellness Odyssey Begins!.png')),
                              )
                            ]),
                          )
                        : checkAnyactive(apiProvider.mysubscription)
                            ? calculateTotalWeeklyEstimation(apiProvider.mysubscription) < apiProvider.userDetails!.balance
                                ? InkWell(
                                    onTap: () {
                                      mainProvider.pageType = 0;
                                      mainProvider.homepageIndex = 1;
                                      mainProvider.notify();
                                    },
                                    child: Container(
                                      width: size.width,
                                      // height: 106,
                                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                      decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(side: const BorderSide(width: 1, color: Color(0x42909090)), borderRadius: BorderRadius.circular(18)),
                                        shadows: const [BoxShadow(color: Color(0x14000000), blurRadius: 4, offset: Offset(0, 0), spreadRadius: 0)],
                                      ),
                                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                        Image.asset('assets/icons/check.png', height: 50),
                                        const SizedBox(width: 20),
                                        Expanded(
                                            child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text("Next 7-day's subscription amount",
                                                textScaler: TextScaler.noScaling,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(color: Color(0xFF1D2730), fontSize: 12, fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
                                            Text('₹${calculateTotalWeeklyEstimation(apiProvider.mysubscription)}',
                                                textScaler: TextScaler.noScaling,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(color: Color(0xFF1D2730), fontSize: 29, fontFamily: 'Poppins', fontWeight: FontWeight.w600))
                                          ],
                                        ))
                                      ]),
                                    ),
                                  )
                                : apiProvider.userDetails!.balance < calculateTotalDailyEstimation(apiProvider.mysubscription)
                                    ? InkWell(
                                        onTap: () {
                                          mainProvider.pageType = 0;
                                          mainProvider.homepageIndex = 1;
                                          mainProvider.notify();
                                        },
                                        child: Container(
                                          width: size.width,
                                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                          decoration: ShapeDecoration(
                                            color: const Color(0xFFFFCFCC),
                                            shape: RoundedRectangleBorder(side: const BorderSide(width: 1, color: Color(0x42909090)), borderRadius: BorderRadius.circular(18)),
                                            shadows: const [BoxShadow(color: Color(0x14000000), blurRadius: 4, offset: Offset(0, 0), spreadRadius: 0)],
                                          ),
                                          child: Column(
                                            children: [
                                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                                Image.asset('assets/icons/warning.png', height: 50),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                    child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const Text('Your Wallet Balance is Too Low',
                                                        textScaler: TextScaler.noScaling,
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(color: Color(0xFF1D2730), fontSize: 15, fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
                                                    const SizedBox(height: 10),
                                                    Row(
                                                      children: [
                                                        Container(
                                                            width: 12,
                                                            height: 12,
                                                            margin: const EdgeInsets.only(right: 5),
                                                            decoration: const ShapeDecoration(color: Color(0xFFFFF0BF), shape: OvalBorder()),
                                                            child: Center(child: Container(width: 6, height: 6, decoration: const ShapeDecoration(color: Color(0xFFF5CF47), shape: OvalBorder())))),
                                                        const Text('Please recharge and resume  subscriptions',
                                                            textScaler: TextScaler.noScaling,
                                                            maxLines: 2,
                                                            style: TextStyle(color: Color(0xFF1D2730), fontSize: 8.5, fontFamily: 'Poppins', fontWeight: FontWeight.w500))
                                                      ],
                                                    )
                                                  ],
                                                ))
                                              ]),
                                              const SizedBox(height: 10),
                                              Container(
                                                width: size.width,
                                                height: 35,
                                                decoration: ShapeDecoration(color: const Color(0xFFC60D05), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                                                child: MaterialButton(
                                                    onPressed: () {
                                                      mainProvider.homepageIndex = 4;
                                                      mainProvider.notify();
                                                      apiProvider.updatewalletReload(true);
                                                      apiProvider.reloadWallet(0);
                                                    },
                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                    child: const Center(
                                                        child: Text('Recharge',
                                                            textScaler: TextScaler.noScaling,
                                                            style: TextStyle(color: Colors.white, fontSize: 12, fontFamily: 'Poppins', fontWeight: FontWeight.w500)))),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    : InkWell(
                                        onTap: () {
                                          mainProvider.pageType = 0;
                                          mainProvider.homepageIndex = 1;
                                          mainProvider.notify();
                                        },
                                        child: Container(
                                          width: size.width,
                                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                          decoration: ShapeDecoration(
                                            color: const Color(0xFFFFFCF1),
                                            shape: RoundedRectangleBorder(side: const BorderSide(width: 1, color: Color(0x42909090)), borderRadius: BorderRadius.circular(18)),
                                            shadows: const [BoxShadow(color: Color(0x14000000), blurRadius: 4, offset: Offset(0, 0), spreadRadius: 0)],
                                          ),
                                          child: Column(
                                            children: [
                                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                                Image.asset('assets/icons/group.png', height: 50),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                    child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const Text("Next 7-day's subscription amount",
                                                        textScaler: TextScaler.noScaling,
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(color: Color(0xFF1D2730), fontSize: 11, fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
                                                    Text('₹${calculateTotalWeeklyEstimation(apiProvider.mysubscription)}',
                                                        textScaler: TextScaler.noScaling,
                                                        textAlign: TextAlign.center,
                                                        style: const TextStyle(color: Color(0xFF1D2730), fontSize: 29, fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
                                                    Row(
                                                      children: [
                                                        Container(
                                                            width: 12,
                                                            height: 12,
                                                            margin: const EdgeInsets.only(right: 5),
                                                            decoration: const ShapeDecoration(color: Color(0xFFFFF0BF), shape: OvalBorder()),
                                                            child: Center(child: Container(width: 6, height: 6, decoration: const ShapeDecoration(color: Color(0xFFF5CF47), shape: OvalBorder())))),
                                                        const Expanded(
                                                          child: Text('Please recharge before your balance runs out',
                                                              textScaler: TextScaler.noScaling,
                                                              style: TextStyle(
                                                                  color: Color(0xFF1D2730), fontSize: 8.5, overflow: TextOverflow.visible, fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ))
                                              ]),
                                              const SizedBox(height: 10),
                                              Container(
                                                width: size.width,
                                                height: 35,
                                                decoration: ShapeDecoration(color: const Color(0xFFFFB400), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                                                child: MaterialButton(
                                                    onPressed: () {
                                                      mainProvider.homepageIndex = 4;
                                                      mainProvider.notify();
                                                      apiProvider.updatewalletReload(true);
                                                      apiProvider.reloadWallet(0);
                                                    },
                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                    child: const Center(
                                                        child: Text('Recharge',
                                                            textScaler: TextScaler.noScaling,
                                                            style: TextStyle(color: Colors.white, fontSize: 12, fontFamily: 'Poppins', fontWeight: FontWeight.w500)))),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                            : checkPauseBybalnce(apiProvider.mysubscription) > 0
                                ? InkWell(
                                    onTap: () {
                                      mainProvider.pageType = 0;
                                      mainProvider.homepageIndex = 1;
                                      mainProvider.notify();
                                    },
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 500),
                                      transform: _isShaking ? Matrix4.rotationZ(0.1) : Matrix4.rotationZ(0),
                                      child: Container(
                                        width: size.width,
                                        decoration: ShapeDecoration(
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                                            shadows: const [BoxShadow(color: Color(0x14000000), blurRadius: 4, offset: Offset(0, 0), spreadRadius: 0)]),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                            Image.asset('assets/icons/dollar.png', height: 50),
                                            const SizedBox(width: 10),
                                            const Expanded(
                                              child: Text("Some of your subscriptions has been automatically paused due to insufficient balance",
                                                  textScaler: TextScaler.noScaling,
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(color: Color(0xFF00557F), fontSize: 12.5, fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
                                            ),
                                          ]),
                                        ),
                                      ),
                                    ),
                                  )
                                : checkPauseByYou(apiProvider.mysubscription) > 0
                                    ? InkWell(
                                        onTap: () {
                                          mainProvider.pageType = 0;
                                          mainProvider.homepageIndex = 1;
                                          mainProvider.notify();
                                        },
                                        child: AnimatedContainer(
                                          duration: const Duration(milliseconds: 500),
                                          transform: _isShaking ? Matrix4.rotationZ(0.1) : Matrix4.rotationZ(0),
                                          child: Container(
                                            width: size.width,
                                            decoration: ShapeDecoration(
                                                color: Colors.white,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                                                shadows: const [BoxShadow(color: Color(0x14000000), blurRadius: 4, offset: Offset(0, 0), spreadRadius: 0)]),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                                Image.asset('assets/icons/pause.png', height: 50),
                                                const SizedBox(width: 10),
                                                const Expanded(
                                                  child: Text("Some of your subscriptions has been paused by you",
                                                      textScaler: TextScaler.noScaling,
                                                      textAlign: TextAlign.start,
                                                      style: TextStyle(color: Color(0xFF00557F), fontSize: 12.5, fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
                                                ),
                                              ]),
                                            ),
                                          ),
                                        ),
                                      )
                                    : InkWell(
                                        onTap: () {
                                          mainProvider.pageType = 0;
                                          mainProvider.homepageIndex = 1;
                                          mainProvider.notify();
                                        },
                                        child: AnimatedContainer(
                                          duration: const Duration(milliseconds: 500),
                                          transform: _isShaking ? Matrix4.rotationZ(0.1) : Matrix4.rotationZ(0),
                                          child: Container(
                                            width: size.width,
                                            decoration: ShapeDecoration(
                                                color: Colors.white,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                                                shadows: const [BoxShadow(color: Color(0x14000000), blurRadius: 4, offset: Offset(0, 0), spreadRadius: 0)]),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                                Image.asset('assets/icons/cancelled.png', height: 50),
                                                const SizedBox(width: 10),
                                                const Expanded(
                                                  child: Text("No Active subscriptions for now",
                                                      textScaler: TextScaler.noScaling,
                                                      textAlign: TextAlign.start,
                                                      style: TextStyle(color: Color(0xFF00557F), fontSize: 12.5, fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
                                                ),
                                              ]),
                                            ),
                                          ),
                                        ),
                                      ),
                  const SubscribeBanner(),
                  const SizedBox(height: 70)
                ],
              ),
            ),
    );
  }
}
