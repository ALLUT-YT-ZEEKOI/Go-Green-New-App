import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gogreen_lite/Allproviders/api_provider.dart';
import 'package:gogreen_lite/Allproviders/main_provider.dart';
import 'package:gogreen_lite/Allproviders/object.dart';
import 'package:gogreen_lite/extrafunctions.dart';
import 'package:provider/provider.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

import '../extrawidgets.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final mainProvider = Provider.of<MainProvider>(context);
    final apiProvider = Provider.of<ApiProvider>(context);
    List<SubProduct> products = apiProvider.milkProducts;

    Future<String?> subscribeAlert() {
      return showDialog<String>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
          child: AlertDialog(
            backgroundColor: const Color(0xFFF9FFE7),
            surfaceTintColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: Color(0xFF88AD09)),
              borderRadius: BorderRadius.circular(12),
            ),
            // title: Image.asset('assets/icons/Artboard 26 1.png', height: 120),
            content: const Padding(
              padding: EdgeInsets.only(bottom: 10, top: 15),
              child: Text(
                "You already have an active subscription for this product. Would you like to create an additional subscription for the same product?",
                textScaler: TextScaler.noScaling,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 16, fontFamily: 'Poppins', fontWeight: FontWeight.w500),
              ),
            ),
            actions: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  width: 100,
                  height: 28.09,
                  decoration: BoxDecoration(color: const Color(0xFFD1FFCC), border: Border.all(width: 1.22, color: const Color(0xFF2F9623)), borderRadius: BorderRadius.circular(7.21)),
                  child: MaterialButton(
                    onPressed: () {
                      apiProvider.isSampleCheckout = false;
                      facebookAppEvents.logViewContent(content: {'name': products[mainProvider.scrollSnapListIndex].name + products[mainProvider.scrollSnapListIndex].unit});
                      mainProvider.selectedSubProduct = products[mainProvider.scrollSnapListIndex];
                      mainProvider.checkpagesIndex = 0;
                      mainProvider.singleDate = DateTime.now().hour < 11 ? DateTime.now().add(const Duration(days: 1)) : DateTime.now().add(const Duration(days: 2));
                      mainProvider.pageType = 2;
                      mainProvider.pattenIndex = 1;
                      mainProvider.customPattern.clear();
                      mainProvider.scheduleIndex = 0;
                      mainProvider.instructions.clear();
                      mainProvider.productqty = 1;
                      mainProvider.onlyOne = false;
                      mainProvider.notify();
                      apiProvider.intalizeCouponVar();
                      Navigator.pop(context);
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                    child: const Text('Continue', textScaler: TextScaler.noScaling, style: TextStyle(color: Color(0xFF2F9623), fontSize: 12.21, fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
                  ),
                ),
                const SizedBox(width: 20),
                Container(
                  width: 100,
                  height: 28.09,
                  decoration: BoxDecoration(color: const Color(0xFFFFE8EA), border: Border.all(width: 1.22, color: const Color(0xFFDC3647)), borderRadius: BorderRadius.circular(7.21)),
                  child: MaterialButton(
                    onPressed: () => Navigator.pop(context),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                    child: const Text('Cancel', textScaler: TextScaler.noScaling, style: TextStyle(color: Color(0xFFDC3647), fontSize: 12.21, fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
                  ),
                ),
              ])
            ],
          ),
        ),
      );
    }

    Future<String?> subscribeAlertPaused() {
      return showDialog<String>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
          child: AlertDialog(
            backgroundColor: const Color(0xFFF9FFE7),
            surfaceTintColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: Color(0xFF88AD09)),
              borderRadius: BorderRadius.circular(12),
            ),
            // title: Image.asset('assets/icons/Artboard 26 1.png', height: 120),
            content: const Padding(
              padding: EdgeInsets.only(bottom: 10, top: 15),
              child: Text(
                "You already have a paused subscription for this product. Would you like to resume it or create a new subscription for this product?",
                textScaler: TextScaler.noScaling,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 16, fontFamily: 'Poppins', fontWeight: FontWeight.w500),
              ),
            ),
            actions: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  width: 105,
                  height: 28.09,
                  decoration: BoxDecoration(color: const Color(0xFFD1FFCC), border: Border.all(width: 1.22, color: const Color(0xFF2F9623)), borderRadius: BorderRadius.circular(7.21)),
                  child: MaterialButton(
                    onPressed: () {
                      mainProvider.homepageIndex = 1;
                      mainProvider.pageType = 0;
                      mainProvider.notify();
                      Navigator.pop(context);
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                    child: const Text('Resume', textScaler: TextScaler.noScaling, style: TextStyle(color: Color(0xFF2F9623), fontSize: 12.21, fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
                  ),
                ),
                const SizedBox(width: 20),
                Container(
                  width: 107,
                  height: 28.09,
                  decoration: BoxDecoration(color: const Color(0xFFFFE8EA), border: Border.all(width: 1.22, color: const Color(0xFFDC3647)), borderRadius: BorderRadius.circular(7.21)),
                  child: MaterialButton(
                    onPressed: () {
                      apiProvider.isSampleCheckout = false;
                      facebookAppEvents.logViewContent(content: {'name': products[mainProvider.scrollSnapListIndex].name + products[mainProvider.scrollSnapListIndex].unit});
                      mainProvider.selectedSubProduct = products[mainProvider.scrollSnapListIndex];
                      mainProvider.checkpagesIndex = 0;
                      mainProvider.singleDate = DateTime.now().hour < 11 ? DateTime.now().add(const Duration(days: 1)) : DateTime.now().add(const Duration(days: 2));
                      mainProvider.pageType = 2;
                      mainProvider.pattenIndex = 1;
                      mainProvider.customPattern.clear();
                      mainProvider.scheduleIndex = 0;
                      mainProvider.instructions.clear();
                      mainProvider.productqty = 1;
                      mainProvider.onlyOne = false;
                      mainProvider.notify();
                      apiProvider.intalizeCouponVar();
                      Navigator.pop(context);
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                    child: const Text('Create New', textScaler: TextScaler.noScaling, style: TextStyle(color: Color(0xFFDC3647), fontSize: 12.21, fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
                  ),
                ),
              ])
            ],
          ),
        ),
      );
    }

    return Container(
        height: size.height,
        width: size.width,
        color: const Color(0xFF308CEF),
        padding: const EdgeInsets.only(bottom: 50),
        child: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(
              height: 60,
              child: Row(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: InkWell(
                      onTap: () {
                        mainProvider.pageType = 0;
                        mainProvider.notify();
                      },
                      child: Image.asset('assets/icons/left-broken.png', height: 40)),
                )
              ]),
            ),
            const Text('Milk', textScaler: TextScaler.noScaling, style: TextStyle(color: Colors.white, fontSize: 28, fontFamily: 'Poppins', fontWeight: FontWeight.w700, height: 0.5)),
            SizedBox(width: double.maxFinite, child: Image.asset('assets/milk-bg.png')),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Cow Milk', textScaler: TextScaler.noScaling, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500)),
                      Text('₹40-₹75', textScaler: TextScaler.noScaling, style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w700))
                    ],
                  ),
                  Text('Savor the raw, unadulterated taste of our farm-fresh cow milk. Straight from our dairy to your table, each sip embodies the essence of pure, untouched goodness',
                      textScaler: TextScaler.noScaling, style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400))
                ],
              ),
            ),
            Container(color: Colors.white, height: 0.2, margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20)),
            SizedBox(
              height: (size.width / 2.5) + 10,
              child: Center(
                child: ScrollSnapList(
                  curve: Curves.easeInOutSine,
                  dynamicItemOpacity: 1,
                  dynamicItemSize: false,
                  allowAnotherDirection: true,
                  itemBuilder: (context, index) {
                    return productFarmerBox(size, mainProvider, index, products[index]);
                  },
                  itemCount: products.length,
                  itemSize: (size.width / 2.5) + 30,
                  onItemFocus: (i) {
                    mainProvider.updateScrollSnapListIndex(i);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (apiProvider.userDetails!.enablesample == 1)
                    Container(
                        width: 150,
                        height: 47,
                        decoration: ShapeDecoration(color: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(64))),
                        child: TextButton(
                            style: TextButton.styleFrom(padding: EdgeInsets.zero, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
                            onPressed: () {
                              apiProvider.isSampleCheckout = true;
                              facebookAppEvents.logViewContent(content: {'name': 'sample milk'});
                              mainProvider.selectedSubProduct = products.last;
                              mainProvider.checkpagesIndex = 6;
                              mainProvider.pageType = 2;
                              mainProvider.pattenIndex = 0;
                              mainProvider.singleDate = DateTime.now().hour < 11 ? DateTime.now().add(const Duration(days: 1)) : DateTime.now().add(const Duration(days: 2));
                              mainProvider.customPattern.clear();
                              mainProvider.scheduleIndex = 0;
                              mainProvider.instructions.clear();
                              mainProvider.productqty = 1;
                              mainProvider.onlyOne = true;
                              mainProvider.notify();
                              apiProvider.intalizeCouponVar();
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                const Expanded(
                                    child: Text('Get Sample',
                                        textScaler: TextScaler.noScaling,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Color(0xFF00557F), fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w500))),
                                Image.asset('assets/icons/mdi_drop_fill.png', height: 30)
                              ]),
                            )))
                  else
                    Container(
                        width: 150,
                        height: 47,
                        decoration: ShapeDecoration(color: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(64))),
                        child: TextButton(
                            style: TextButton.styleFrom(padding: EdgeInsets.zero, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
                            onPressed: () {
                              apiProvider.isSampleCheckout = false;
                              mainProvider.selectedSubProduct = products[mainProvider.scrollSnapListIndex];
                              mainProvider.checkpagesIndex = 0;
                              mainProvider.pageType = 2;
                              mainProvider.pattenIndex = 0;
                              mainProvider.singleDate = DateTime.now().hour < 11 ? DateTime.now().add(const Duration(days: 1)) : DateTime.now().add(const Duration(days: 2));
                              mainProvider.customPattern.clear();
                              mainProvider.scheduleIndex = 0;
                              mainProvider.instructions.clear();
                              mainProvider.productqty = 1;
                              mainProvider.onlyOne = true;
                              mainProvider.notify();
                              apiProvider.intalizeCouponVar();
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                const Expanded(
                                    child: Text('Buy Once',
                                        textScaler: TextScaler.noScaling,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Color(0xFF00557F), fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w500))),
                                Image.asset('assets/icons/mdi_drop_fill.png', height: 30)
                              ]),
                            ))),
                  Container(
                      width: 150,
                      height: 47,
                      decoration: ShapeDecoration(color: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(64))),
                      child: TextButton(
                          style: TextButton.styleFrom(padding: EdgeInsets.zero, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
                          onPressed: () {
                            if (isActiveSubscriptionExists(products[mainProvider.scrollSnapListIndex].id, apiProvider.mysubscription)) {
                              subscribeAlert();
                            } else if (isPausedSubscriptionExists(products[mainProvider.scrollSnapListIndex].id, apiProvider.mysubscription)) {
                              subscribeAlertPaused();
                            } else {
                              apiProvider.isSampleCheckout = false;
                              facebookAppEvents.logViewContent(content: {'name': products[mainProvider.scrollSnapListIndex].name + products[mainProvider.scrollSnapListIndex].unit});
                              mainProvider.selectedSubProduct = products[mainProvider.scrollSnapListIndex];
                              mainProvider.checkpagesIndex = 0;
                              mainProvider.singleDate = DateTime.now().hour < 11 ? DateTime.now().add(const Duration(days: 1)) : DateTime.now().add(const Duration(days: 2));
                              mainProvider.pageType = 2;
                              mainProvider.pattenIndex = 1;
                              mainProvider.customPattern.clear();
                              mainProvider.scheduleIndex = 0;
                              mainProvider.instructions.clear();
                              mainProvider.productqty = 1;
                              mainProvider.onlyOne = false;
                              mainProvider.notify();
                              apiProvider.intalizeCouponVar();
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                              const Expanded(
                                  child: Text('Subscribe',
                                      textScaler: TextScaler.noScaling,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Color(0xFF00557F), fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w500))),
                              Image.asset('assets/icons/mdi_drop.png', height: 30)
                            ]),
                          ))),
                ],
              ),
            )
          ],
        )));
  }
}
