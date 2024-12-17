import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gogreen_lite/Allproviders/api_provider.dart';
import 'package:gogreen_lite/Allproviders/main_provider.dart';
import 'package:gogreen_lite/Allproviders/object.dart';
import 'package:gogreen_lite/extrafunctions.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../checkPages/editsub.dart';
import '../../checkPages/opensub.dart';
import '../../extraStyle.dart';
import '../../extrawidgets.dart';

class SubscriptionBox extends StatelessWidget {
  const SubscriptionBox({super.key, required this.subscription});
  final Subscription subscription;
  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);
    final apiProvider = Provider.of<ApiProvider>(context);
    Future<String?> pause() {
      return showDialog<String>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
          child: AlertDialog(
            backgroundColor: const Color(0xFFF9FFE7),
            surfaceTintColor: Colors.transparent,
            shape: RoundedRectangleBorder(side: const BorderSide(width: 1, color: Color(0xFF88AD09)), borderRadius: BorderRadius.circular(12)),
            title: Image.asset('assets/icons/Artboard 26 1.png', height: 120),
            content: Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Text("Do you want to ${subscription.status == 0 ? 'resume' : 'pause'}?",
                  textAlign: TextAlign.center, style: const TextStyle(color: Colors.black, fontSize: 15, fontFamily: 'Poppins', fontWeight: FontWeight.w400)),
            ),
            actions: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  width: 83.04,
                  height: 28.09,
                  decoration: BoxDecoration(color: const Color(0xFFD1FFCC), border: Border.all(width: 1.22, color: const Color(0xFF2F9623)), borderRadius: BorderRadius.circular(7.21)),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                      apiProvider.updateSubscriptionStatus(subscription.status == 1 ? 0 : 1, subscription);
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                    child: const Text('Yes', style: TextStyle(color: Color(0xFF2F9623), fontSize: 12.21, fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
                  ),
                ),
                const SizedBox(width: 20),
                Container(
                  width: 83.04,
                  height: 28.09,
                  decoration: BoxDecoration(color: const Color(0xFFFFE8EA), border: Border.all(width: 1.22, color: const Color(0xFFDC3647)), borderRadius: BorderRadius.circular(7.21)),
                  child: MaterialButton(
                    onPressed: () => Navigator.pop(context),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                    child: const Text('N0', style: TextStyle(color: Color(0xFFDC3647), fontSize: 12.21, fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
                  ),
                ),
              ])
            ],
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: subscription.approval == 0
            ? const Color.fromARGB(255, 250, 208, 208)
            : subscription.status == 1
                ? Colors.white
                : const Color(0xFFFFFCF1),
        border: Border.all(
            width: 1,
            color: subscription.approval == 0
                ? const Color(0xFFC60D05)
                : subscription.status == 1
                    ? const Color(0x42909090)
                    : const Color(0xFFF5CF47)),
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [BoxShadow(color: Color(0x14000000), blurRadius: 4, offset: Offset(0, 0), spreadRadius: 0)],
      ),
      child: MaterialButton(
        onPressed: () {
          if (subscription.approval == 1) {
            Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: const OpenSub()));
            apiProvider.openSubscription = subscription;
            mainProvider.notify();
          }
        },
        padding: const EdgeInsets.all(15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              SizedBox(
                height: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 47,
                          height: 50,
                          decoration: BoxDecoration(border: Border.all(width: 1, color: const Color(0xFF1D2730)), borderRadius: BorderRadius.circular(6)),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: subscription.product != null && subscription.product!.imageurl.isNotEmpty ? Image.network(subscription.product!.imageurl) : const SizedBox()),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          height: 50,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(subscription.product?.name ?? '', textScaler: TextScaler.noScaling, style: productNameStyle),
                              Row(
                                children: [
                                  Container(
                                    height: 22,
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    decoration: BoxDecoration(
                                        color: subscription.approval == 1 ? const Color(0xFFEFFFED) : Colors.white,
                                        border: Border.all(width: 0.88, color: subscription.approval == 1 ? const Color(0xFF2F9623) : const Color(0xFFC60D05)),
                                        borderRadius: BorderRadius.circular(5.19)),
                                    child: Center(
                                      child: Text(subscription.type,
                                          textScaler: TextScaler.noScaling,
                                          style: TextStyle(
                                              color: subscription.approval == 1 ? const Color(0xFF2F9623) : const Color(0xFFC60D05), fontSize: 10, fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Container(
                                    height: 22,
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                      color: subscription.approval == 1 ? const Color(0xFFEFFFED) : Colors.white,
                                      border: Border.all(width: 0.88, color: subscription.approval == 1 ? const Color(0xFF2F9623) : const Color(0xFFC60D05)),
                                      borderRadius: BorderRadius.circular(5.19),
                                    ),
                                    child: Center(
                                      child: Text(getschedule(subscription.schedule),
                                          textScaler: TextScaler.noScaling,
                                          style: TextStyle(
                                              color: subscription.approval == 1 ? const Color(0xFF2F9623) : const Color(0xFFC60D05), fontSize: 10, fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Image.asset('assets/icons/farmer-icon.png', height: 18, color: subscription.approval == 1 ? const Color(0xFF2F9623) : const Color(0xFFC60D05)),
                        const SizedBox(width: 5),
                        Text(subscription.product?.sellername ?? '',
                            textScaler: TextScaler.noScaling,
                            style: TextStyle(color: subscription.approval == 1 ? const Color(0xFF2F9623) : const Color(0xFFC60D05), fontSize: 12, fontFamily: 'Poppins', fontWeight: FontWeight.w500))
                      ],
                    ),
                  ],
                ),
              ),
              if (subscription.approval == 1)
                SizedBox(
                  height: 80,
                  child: Row(
                    children: [
                      Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, mainAxisSize: MainAxisSize.max, children: [verticalDot, verticalDot, verticalDot, verticalDot, verticalDot]),
                      const SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 85,
                            height: 30,
                            decoration: BoxDecoration(
                                color: subscription.status == 1 ? const Color(0xFFFFFCF1) : const Color(0xFFEEFDED),
                                border: Border.all(width: 1.22, color: subscription.status == 1 ? const Color(0xFFF5CF47) : const Color(0xFF2F9623)),
                                borderRadius: BorderRadius.circular(7.21)),
                            child: MaterialButton(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                              onPressed: () {
                                pause();
                              },
                              child: Text(subscription.status == 1 ? 'Pause' : 'resume',
                                  textScaler: TextScaler.noScaling,
                                  style:
                                      TextStyle(color: subscription.status == 1 ? const Color(0xFFF5CF47) : const Color(0xFF2F9623), fontSize: 13, fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
                            ),
                          ),
                          Container(
                            width: 85,
                            height: 30,
                            decoration: BoxDecoration(color: const Color(0xFFE2F0FF), border: Border.all(width: 1.22, color: const Color(0xFF308CEF)), borderRadius: BorderRadius.circular(7.21)),
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              onPressed: () {
                                Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: const EditSub()));
                                apiProvider.skipped = subscription.skipped;
                                apiProvider.openSubscription = subscription;
                                mainProvider.notify();
                              },
                              child: const Text('Edit', textScaler: TextScaler.noScaling, style: TextStyle(color: Color(0xFF308CEF), fontSize: 13, fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
            ]),
            const SizedBox(height: 20),
            subscription.approval == 1
                ? Row(
                    children: [
                      Container(
                        width: 15,
                        height: 15,
                        margin: const EdgeInsets.only(right: 5),
                        decoration: const ShapeDecoration(color: Color(0xFFFFDBC6), shape: OvalBorder()),
                        child: Center(child: Container(width: 8, height: 8, decoration: const ShapeDecoration(color: Color(0xFFF28B51), shape: OvalBorder()))),
                      ),
                      Flexible(
                        child: Column(
                          children: [
                            Text(subscription.showText(),
                                textScaler: TextScaler.noScaling, style: const TextStyle(color: Color(0xFF1D2730), fontSize: 10, fontFamily: 'Poppins', fontWeight: FontWeight.w400)),
                          ],
                        ),
                      )
                    ],
                  )
                : Row(
                    children: [
                      const Icon(Icons.disabled_visible, color: Colors.red),
                      const SizedBox(width: 5),
                      Flexible(
                          child: Text(subscription.showText(),
                              textScaler: TextScaler.noScaling, style: const TextStyle(color: Color(0xFF1D2730), fontSize: 10, fontFamily: 'Poppins', fontWeight: FontWeight.w400)))
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
