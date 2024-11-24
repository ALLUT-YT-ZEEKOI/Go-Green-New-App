// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:gogreen_lite/Allproviders/api_provider.dart';
import 'package:gogreen_lite/Allproviders/main_provider.dart';
import 'package:gogreen_lite/confirm.dart';
import 'package:gogreen_lite/extraStyle.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../Allproviders/object.dart';
import '../customPackages/swipable_button.dart';
import '../extrafunctions.dart';
import '../extrawidgets.dart';
import '../wrong.dart';
import 'checkwallet.dart';

bool done = false;
bool respose = false;

class CheckWalletSummary extends StatefulWidget {
  const CheckWalletSummary({super.key, required this.due});
  final double due;
  @override
  State<CheckWalletSummary> createState() => _CheckWalletSummaryState();
}

class _CheckWalletSummaryState extends State<CheckWalletSummary> {
  @override
  void initState() {
    done = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final apiProvider = Provider.of<ApiProvider>(context);
    final mainProvider = Provider.of<MainProvider>(context);
    SubProduct? product = mainProvider.selectedSubProduct;
    UserAddress? selected = mainProvider.pickedSaved;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          toolbarHeight: 60,
          backgroundColor: const Color(0xFFF6F6F6),
          shadowColor: Colors.transparent,
          leading: const SizedBox(),
          title: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('Payment Summary', style: TextStyle(color: Color(0xFF1D2730), fontSize: 16, fontFamily: 'Poppins', fontWeight: FontWeight.w500))]),
          actions: const [SizedBox(width: 60)],
        ),
        body: Container(
          color: const Color(0xFFF6F6F6),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          width: size.width,
          height: size.height,
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: 99,
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 1, color: const Color(0xFF2F9623)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Wallet balance', textScaler: TextScaler.noScaling, style: walletLabel),
                          if (apiProvider.userDetails != null) Text('₹ ${apiProvider.userDetails!.balance}', textScaler: TextScaler.noScaling, style: walletValue)
                        ],
                      ),
                      apiProvider.walletReload
                          ? const CircularProgressIndicator()
                          : InkWell(
                              onTap: () {
                                apiProvider.updatewalletReload(true);
                                apiProvider.reloadWallet(0);
                              },
                              child: const Icon(Icons.sync_sharp, size: 40))
                    ]),
                  ),
                  const SizedBox(height: 25),
                  if (widget.due > 0)
                    Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 25),
                        child: RichText(
                          text: TextSpan(
                            style: walletLabel, // Default style for the text
                            children: [
                              const TextSpan(text: "There's a due amount of "),
                              TextSpan(text: "₹ ${widget.due.toStringAsFixed(2)}", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                              const TextSpan(
                                  text: " on your account, and we don't want you to miss your next order. Please clear the due and top up your wallet to continue enjoying uninterrupted service.")
                            ],
                          ),
                        )),
                  Container(
                    width: size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                    decoration:
                        ShapeDecoration(color: Colors.white, shape: RoundedRectangleBorder(side: const BorderSide(width: 1, color: Color(0x191D2730)), borderRadius: BorderRadius.circular(13))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Summary', style: walletLabel),
                        const SizedBox(height: 10),
                        userhorizontalLine2,
                        const SizedBox(height: 10),
                        const Text('Current Subscription ', textScaler: TextScaler.noScaling, style: profileFontBold),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Text('Per Day Cost', textScaler: TextScaler.noScaling, style: daycosthead),
                              Text('The daily cost of your current subscription.', textScaler: TextScaler.noScaling, style: daycosttext)
                            ]),
                            Row(
                              children: [
                                if (apiProvider.appliedCoupon != null && apiProvider.appliedCoupon!.type == 'subscription')
                                  Text('₹${(double.parse(product!.calculateDiscountedPrice()) * mainProvider.productqty)} ', textScaler: TextScaler.noScaling, style: orginalprice)
                                else
                                  Column(
                                    children: [
                                      if (apiProvider.appliedCoupon != null &&
                                          (apiProvider.appliedCoupon!.getFormattedDiscountvalu((double.parse(product!.calculateDiscountedPrice()) * mainProvider.productqty))) > 0)
                                        Text('₹${(double.parse(product.calculateDiscountedPrice()) * mainProvider.productqty)} ', textScaler: TextScaler.noScaling, style: discountorginalprice),
                                      Text(
                                          '₹${(double.parse(product!.calculateDiscountedPrice()) * mainProvider.productqty) - (apiProvider.appliedCoupon == null ? 0 : apiProvider.appliedCoupon!.getFormattedDiscountvalu((double.parse(product.calculateDiscountedPrice()) * mainProvider.productqty)))}',
                                          textScaler: TextScaler.noScaling,
                                          style: profileFontBold),
                                    ],
                                  )
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 15),
                        if (mainProvider.pattenIndex != 0)
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                    Text('First 7 Day Cost', textScaler: TextScaler.noScaling, style: daycosthead),
                                    Text('First 7 day cost of your current subscription.', textScaler: TextScaler.noScaling, style: daycosttext)
                                  ]),
                                  Row(
                                    children: [
                                      if (apiProvider.appliedCoupon != null && apiProvider.appliedCoupon!.type == 'subscription')
                                        Text('₹${first7daysCostnormal(mainProvider.singleDate, pattern[mainProvider.pattenIndex], product, mainProvider.productqty, mainProvider.customPattern)} ',
                                            textScaler: TextScaler.noScaling, style: orginalprice)
                                      else
                                        Column(
                                          children: [
                                            if (first7daysCostnormal(mainProvider.singleDate, pattern[mainProvider.pattenIndex], product, mainProvider.productqty, mainProvider.customPattern) >
                                                first7daysCost(mainProvider.singleDate, pattern[mainProvider.pattenIndex], product, mainProvider.productqty, mainProvider.customPattern,
                                                    apiProvider.appliedCoupon))
                                              Text(
                                                  '₹${first7daysCostnormal(mainProvider.singleDate, pattern[mainProvider.pattenIndex], product, mainProvider.productqty, mainProvider.customPattern)} ',
                                                  textScaler: TextScaler.noScaling,
                                                  style: discountorginalprice),
                                            Text(
                                                '₹${first7daysCost(mainProvider.singleDate, pattern[mainProvider.pattenIndex], product, mainProvider.productqty, mainProvider.customPattern, apiProvider.appliedCoupon)}',
                                                textScaler: TextScaler.noScaling,
                                                style: profileFontBold),
                                          ],
                                        )
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(height: 15),
                            ],
                          ),
                        if (apiProvider.appliedCoupon != null)
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            height: 50,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(color: const Color(0xFFF8FFF7), border: Border.all(width: 0.90, color: const Color(0xFF2F9623)), borderRadius: BorderRadius.circular(8)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('${apiProvider.appliedCoupon!.code} Coupon Applied', textScaler: TextScaler.noScaling, style: orderDateStyle2),
                                    if (apiProvider.appliedCoupon!.type != 'subscription')
                                      Text(
                                          mainProvider.pattenIndex == 3
                                              ? apiProvider.appliedCoupon!.getFormattedDiscount2()
                                              : apiProvider.appliedCoupon!.getFormattedDiscount1(mainProvider.productqty * double.parse(product.calculateDiscountedPrice())),
                                          textScaler: TextScaler.noScaling,
                                          style: const TextStyle(color: Color(0xFF2F9623), fontSize: 13, fontFamily: 'Poppins', fontWeight: FontWeight.w700))
                                  ],
                                ),
                                if (apiProvider.appliedCoupon!.type == 'subscription') Text(apiProvider.appliedCoupon!.getFormattedDiscount2(), style: buyfree)
                              ],
                            ),
                          ),
                        userhorizontalLine2,
                        const SizedBox(height: 15),
                        const Text('Previous Active Subscriptions ', textScaler: TextScaler.noScaling, style: profileFontBold),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Next 7 Day Cost', textScaler: TextScaler.noScaling, style: daycosthead),
                                Text('Next 7 day cost of your previous subscriptions.', textScaler: TextScaler.noScaling, style: daycosttext),
                              ],
                            ),
                            Row(children: [Text('₹${calculateTotalWeeklyEstimation(apiProvider.mysubscription)}', textScaler: TextScaler.noScaling, style: profileFontBold)])
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              !apiProvider.walletRecharge2Suceess
                  ? ((product.unitPrice * mainProvider.productqty) > (apiProvider.userDetails?.balance ?? 0))
                      ? Positioned(
                          bottom: 30,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 100),
                                width: size.width - 30,
                                height: 50,
                                decoration: BoxDecoration(color: const Color(0xFFFA660A), borderRadius: BorderRadius.circular(43)),
                                child: MaterialButton(
                                    onPressed: () {
                                      Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: const CheckWallet()));
                                    },
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(43)),
                                    child: const Text('Recharge',
                                        textScaler: TextScaler.noScaling, style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'Poppins', fontWeight: FontWeight.w500))),
                              ),
                            ],
                          ),
                        )
                      : Positioned(
                          bottom: 30,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 100),
                                width: size.width * 0.5 - 30,
                                height: 50,
                                decoration: BoxDecoration(color: const Color(0xFF2F9623), borderRadius: BorderRadius.circular(43)),
                                child: MaterialButton(
                                    onPressed: () {
                                      facebookAppEvents.logSubscribe(orderId: product.name + product.unit);
                                      showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) => WillPopScope(onWillPop: () async => false, child: const Center(child: CircularProgressIndicator())));
                                      apiProvider
                                          .storeSubscription(0,
                                              pid: product.id,
                                              addressid: selected!.id,
                                              qty: mainProvider.productqty,
                                              start: formatDate2(mainProvider.singleDate),
                                              type: pattern[mainProvider.pattenIndex],
                                              schedule: mainProvider.scheduleIndex == 0 ? 'morning' : 'evening',
                                              weekdays: mainProvider.pattenIndex == 3 ? mainProvider.customPattern : null,
                                              instruction: mainProvider.instructions)
                                          .then((val) {
                                        setState(() {
                                          Navigator.pop(context);
                                          Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: val ? const Conformed() : const Wrong()));
                                        });
                                      });
                                    },
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(43)),
                                    child: const Text('Place Order', style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'Poppins', fontWeight: FontWeight.w500))),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 100),
                                width: size.width * 0.5 - 30,
                                height: 50,
                                decoration: BoxDecoration(color: const Color(0xFFFA660A), borderRadius: BorderRadius.circular(43)),
                                child: MaterialButton(
                                    onPressed: () {
                                      Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: const CheckWallet()));
                                    },
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(43)),
                                    child: const Text('Recharge', style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'Poppins', fontWeight: FontWeight.w500))),
                              ),
                            ],
                          ),
                        )
                  : Positioned(
                      bottom: 30,
                      left: 0,
                      right: 0,
                      child: SizedBox(
                        width: size.width,
                        child: Center(
                          child: SwipeableButtonView(
                              buttonText: 'SLIDE TO CONFIRM',
                              buttonWidget: Image.asset('assets/icons/next.png', height: 30),
                              buttonWidgetend: Image.asset('assets/icons/muscle.png', height: 30),
                              activeColor: const Color(0xFF009C41),
                              animationColor: const Color(0xFFF9EEDB),
                              isFinished: done,
                              onWaitingProcess: () async {
                                await Future.delayed(const Duration(seconds: 2));
                                apiProvider
                                    .storeSubscription(0,
                                        pid: product.id,
                                        addressid: selected!.id,
                                        qty: mainProvider.productqty,
                                        start: formatDate2(mainProvider.singleDate),
                                        type: pattern[mainProvider.pattenIndex],
                                        schedule: mainProvider.scheduleIndex == 0 ? 'morning' : 'evening',
                                        weekdays: mainProvider.pattenIndex == 3 ? mainProvider.customPattern : null,
                                        instruction: mainProvider.instructions)
                                    .then((val) {
                                  setState(() {
                                    respose = val;
                                    done = true;
                                  });
                                });
                              },
                              onFinish: () async {
                                await Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: respose ? const Conformed() : const Wrong()));
                              }),
                        ),
                      ))
            ],
          ),
        ),
      ),
    );
  }
}
