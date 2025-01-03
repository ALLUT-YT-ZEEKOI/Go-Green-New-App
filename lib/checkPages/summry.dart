import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:gogreen_lite/Allproviders/api_provider.dart';
import 'package:gogreen_lite/Allproviders/main_provider.dart';
import 'package:gogreen_lite/Allproviders/object.dart';
import 'package:gogreen_lite/checkPages/checkwalletsummary.dart';
import 'package:gogreen_lite/extraFunctions.dart';
import 'package:gogreen_lite/extrawidgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../extraStyle.dart';
import 'sub_checkout.dart';
import 'widgets/instruction_box.dart';
import 'widgets/sub_pattern_box.dart';

class Summry extends StatelessWidget {
  const Summry({super.key});
  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);
    final apiProvider = Provider.of<ApiProvider>(context);
    Provider.of<ApiProvider>(context);
    UserAddress? selected = mainProvider.pickedSaved;
    final Size size = MediaQuery.of(context).size;
    SubProduct? product = mainProvider.selectedSubProduct;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        toolbarHeight: 60,
        backgroundColor: const Color(0xFFF6F6F6),
        shadowColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 25),
          child: InkWell(
              onTap: () {
                mainProvider.checkpagesIndex = 0;
                mainProvider.notify();
              },
              child: Image.asset('assets/icons/left-broken.png', width: 40, color: const Color(0xFF1D2730))),
        ),
        title: const Row(mainAxisAlignment: MainAxisAlignment.start, children: [Text('Subscription Summary', textScaler: TextScaler.noScaling, style: checkoutheadtitle)]),
        actions: const [SizedBox(width: 60)],
      ),
      body: Container(
        height: size.height,
        width: size.width,
        color: const Color(0xFFF6F6F6),
        child: product == null
            ? const SizedBox()
            : Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                    child: ListView(
                      children: [
                        Container(
                          width: size.width,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 47,
                                      height: 47,
                                      decoration: BoxDecoration(border: Border.all(width: 1, color: const Color(0xFF1D2730)), borderRadius: BorderRadius.circular(6)),
                                      child: ClipRRect(borderRadius: BorderRadius.circular(6), child: product.imageurl.isNotEmpty ? Image.network(product.imageurl) : const SizedBox()),
                                    ),
                                    const SizedBox(width: 5),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(product.name, textScaler: TextScaler.noScaling, style: productNameStyle),
                                        Text(product.unit, style: const TextStyle(color: Color(0xFF1D2730), fontSize: 11.25, fontFamily: 'Poppins', fontWeight: FontWeight.w500))
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Text('Qty : ',
                                        textScaler: TextScaler.noScaling, style: TextStyle(color: Color(0xFF909090), fontSize: 16, fontFamily: 'Poppins', fontWeight: FontWeight.w400)),
                                    Text('${mainProvider.productqty}',
                                        textScaler: TextScaler.noScaling,
                                        style: const TextStyle(color: Color(0xFF1D2730), fontSize: 16, fontFamily: 'Poppins', fontWeight: FontWeight.w600, height: 1.2)),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(height: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Image.asset('assets/icons/farmer-icon.png', height: 18, color: const Color(0xFF2F9623)),
                                    const SizedBox(width: 5),
                                    Text(mainProvider.selectedSubProduct!.sellername, textScaler: TextScaler.noScaling, style: farmerNameStyle)
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        RatingBarIndicator(
                                            rating: product.sellerRating,
                                            itemBuilder: (context, index) => const Icon(Icons.star, color: Colors.amber),
                                            itemCount: 5,
                                            itemSize: 18,
                                            direction: Axis.horizontal),
                                        const SizedBox(width: 2),
                                        Text('(${product.sellernumofreview})', style: menusub),
                                      ],
                                    ),
                                    SizedBox(child: Center(child: Text('₹${product.calculateDiscountedPrice()}/${product.unit}', textScaler: TextScaler.noScaling, style: priceUnit)))
                                  ],
                                ),
                                Container(width: size.width, height: 1.5, margin: const EdgeInsets.symmetric(vertical: 10), color: const Color(0x111D2730)),
                                if (apiProvider.appliedCoupon != null)
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    height: 50,
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(color: const Color(0xFFF8FFF7), border: Border.all(width: 0.90, color: const Color(0xFF2F9623)), borderRadius: BorderRadius.circular(8)),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('${apiProvider.appliedCoupon!.code} Coupon Applied', style: orderDateStyle2),
                                            if (apiProvider.appliedCoupon!.type != 'subscription')
                                              Text(
                                                  mainProvider.pattenIndex == 3
                                                      ? apiProvider.appliedCoupon!.getFormattedDiscount2()
                                                      : apiProvider.appliedCoupon!.getFormattedDiscount1(mainProvider.productqty * double.parse(product.calculateDiscountedPrice())),
                                                  style: const TextStyle(color: Color(0xFF2F9623), fontSize: 13, fontFamily: 'Poppins', fontWeight: FontWeight.w700))
                                          ],
                                        ),
                                        if (apiProvider.appliedCoupon!.type == 'subscription') Text(apiProvider.appliedCoupon!.getFormattedDiscount2(), style: buyfree)
                                      ],
                                    ),
                                  ),
                                const Text('Subscription pattern', style: subSidehead),
                                const SizedBox(height: 7.5),
                                Row(children: [SubPatternBox(active: false, label: pattern[mainProvider.pattenIndex], ontap: () {})]),
                                if (mainProvider.pattenIndex == 3)
                                  Column(children: [
                                    for (CustomPatern i in mainProvider.customPattern)
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  width: 12,
                                                  height: 12,
                                                  margin: const EdgeInsets.symmetric(horizontal: 5),
                                                  decoration: const ShapeDecoration(color: Color(0xFFFFDBC6), shape: OvalBorder()),
                                                  child: Center(child: Container(width: 6, height: 6, decoration: const ShapeDecoration(color: Color(0xFFF28B51), shape: OvalBorder()))),
                                                ),
                                                Text(i.name, style: const TextStyle(color: Color(0xFF1D2730), fontSize: 15, fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
                                              ],
                                            ),
                                            Container(
                                              width: 50.84,
                                              height: 20.44,
                                              decoration: BoxDecoration(border: Border.all(width: 0.50, color: const Color(0xFFFD995B)), borderRadius: BorderRadius.circular(3.99)),
                                              child: Center(child: Text(i.qty.toString())),
                                            )
                                          ],
                                        ),
                                      )
                                  ]),
                                const SizedBox(height: 15),
                                const Text('Schedule time', style: subSidehead),
                                const SizedBox(height: 7.5),
                                Row(children: [SubPatternBox(active: false, label: schedule[mainProvider.scheduleIndex], ontap: () {})]),
                                const SizedBox(height: 15),
                                const Text('Subscription start date', style: subSidehead),
                                const SizedBox(height: 7.5),
                                Row(children: [SubPatternBox(active: false, label: formatDate(mainProvider.singleDate), ontap: () {})]),
                              ],
                            ),
                          ]),
                        ),
                        const Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Shipping address', textScaler: TextScaler.noScaling, style: subBoxHead)])),
                        if (selected != null)
                          Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                              width: size.width,
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(selected.address.split(',').toList().first, style: const TextStyle(color: Color(0xFF1D2730), fontSize: 16, fontFamily: 'Poppins', fontWeight: FontWeight.w700)),
                                  Text(selected.address, style: const TextStyle(color: Color(0xFF909090), fontSize: 11, fontFamily: 'Poppins', fontWeight: FontWeight.w400)),
                                  if (selected.addressLine.isNotEmpty)
                                    Text(selected.addressLine, style: const TextStyle(color: Color(0xFF909090), fontSize: 11, fontFamily: 'Poppins', fontWeight: FontWeight.w400)),
                                  const SizedBox(height: 5),
                                  Text('Landmark : ${selected.landmark}', style: const TextStyle(color: Color(0xFF909090), fontSize: 11, fontFamily: 'Poppins', fontWeight: FontWeight.w400)),
                                  Text('Phone number : ${selected.phone}', style: const TextStyle(color: Color(0xFF909090), fontSize: 11, fontFamily: 'Poppins', fontWeight: FontWeight.w400)),
                                  const SizedBox(height: 5),
                                ],
                              )),
                        if (mainProvider.instructions.isNotEmpty)
                          const Column(
                            children: [
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Delivery instruction', textScaler: TextScaler.noScaling, style: subBoxHead)]))
                            ],
                          ),
                        if (mainProvider.instructions.isNotEmpty)
                          Container(
                            width: size.width,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                            child: Wrap(
                              direction: Axis.horizontal,
                              runSpacing: 5,
                              runAlignment: WrapAlignment.spaceBetween,
                              alignment: WrapAlignment.spaceBetween,
                              children: [
                                for (var i = 0; i < allInstructions.length; i++)
                                  if (mainProvider.instructions.contains(allInstructions[i]))
                                    InstructionBox(
                                      lable: allInstructions[i],
                                      icon: instrunctionIcon[i],
                                      selected: true,
                                      onpressed: () {},
                                    )
                              ],
                            ),
                          ),
                        const SizedBox(height: 100)
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: const Color(0xFFF6F6F6),
                      padding: const EdgeInsets.fromLTRB(25, 0, 25, 20),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2F9623),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            apiProvider.walletRecharge2Suceess = false;
                            apiProvider.notify();
                            showDialog(
                                context: context, barrierDismissible: false, builder: (BuildContext context) => const PopScope(canPop: false, child: Center(child: CircularProgressIndicator())));
                            apiProvider.checkdue().then((value) {
                              Get.back();
                              facebookAppEvents.logInitiatedCheckout(totalPrice: product.unitPrice, numItems: mainProvider.productqty);
                              Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: CheckWalletSummary(due: value)));
                            });
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(43),
                          ),
                          child: const Text('PROCEED', textScaler: TextScaler.noScaling, style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
                        ),
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
