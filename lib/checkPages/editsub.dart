import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gogreen_lite/Allproviders/api_provider.dart';
import 'package:gogreen_lite/Allproviders/object.dart';
import 'package:provider/provider.dart';
import '../CustomSf/datepicker.dart';
import '../extraStyle.dart';
import '../extrafunctions.dart';

class EditSub extends StatelessWidget {
  const EditSub({super.key});
  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<ApiProvider>(context);
    Subscription? open = apiProvider.openSubscription;
    Future<String?> submit() {
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
            title: Image.asset('assets/icons/Artboard 26 1.png', height: 120),
            content: const Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: Text(
                "Are You Sure",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: 'Poppins', fontWeight: FontWeight.w400),
              ),
            ),
            actions: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  width: 83.04,
                  height: 28.09,
                  decoration: BoxDecoration(color: const Color(0xFFD1FFCC), border: Border.all(width: 1.22, color: const Color(0xFF2F9623)), borderRadius: BorderRadius.circular(7.21)),
                  child: MaterialButton(
                    onPressed: () {
                      if (open != null) {
                        apiProvider.subscriptionSkip(open.id, apiProvider.skipped);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }
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

    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        toolbarHeight: 60,
        backgroundColor: const Color(0xFFF6F6F6),
        shadowColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset('assets/icons/left-broken.png', width: 40, color: const Color(0xFF1D2730))),
        ),
        title: const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [Text('Edit Subscription', style: TextStyle(color: Color(0xFF1D2730), fontSize: 16, fontFamily: 'Poppins', fontWeight: FontWeight.w500))]),
        actions: const [SizedBox(width: 60)],
      ),
      body: Container(
        height: size.height,
        width: size.width,
        padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
        color: const Color(0xFFF6F6F6),
        child: open == null
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(children: [
                      // const SizedBox(height: 20),
                      // subscription shedule container
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
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(6),
                                        child: open.product != null && open.product!.imageurl.isNotEmpty ? Image.network(open.product!.imageurl) : const SizedBox()),
                                  ),
                                  const SizedBox(width: 5),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(open.product?.name ?? "", textScaler: TextScaler.noScaling, style: productNameStyle),
                                      Text(open.product?.unit ?? "",
                                          textScaler: TextScaler.noScaling, style: const TextStyle(color: Color(0xFF1D2730), fontSize: 11.25, fontFamily: 'Poppins', fontWeight: FontWeight.w500))
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Text('Qty : ',
                                        textScaler: TextScaler.noScaling, style: TextStyle(color: Color(0xFF909090), fontSize: 16, fontFamily: 'Poppins', fontWeight: FontWeight.w400)),
                                    Text('${open.qty}',
                                        textScaler: TextScaler.noScaling,
                                        style: const TextStyle(color: Color(0xFF1D2730), fontSize: 16, fontFamily: 'Poppins', fontWeight: FontWeight.w600, height: 1.2)),
                                  ],
                                ),
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
                                  Text(open.product?.sellername ?? '', textScaler: TextScaler.noScaling, style: farmerNameStyle)
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      RatingBarIndicator(
                                          rating: open.product?.sellerRating ?? 0,
                                          itemBuilder: (context, index) => const Icon(Icons.star, color: Colors.amber),
                                          itemCount: 5,
                                          itemSize: 18,
                                          direction: Axis.horizontal),
                                      const SizedBox(width: 2),
                                      Text('(${open.product?.sellernumofreview ?? 0})', style: menusub),
                                    ],
                                  ),
                                  Center(child: Text('₹${open.product?.calculateDiscountedPrice() ?? 0}/${open.product?.unit ?? ''}', textScaler: TextScaler.noScaling, style: priceUnit))
                                ],
                              ),
                              Container(width: size.width, height: 1.5, margin: const EdgeInsets.symmetric(vertical: 10), color: const Color(0x111D2730)),
                              if (open.coupon != null)
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
                                          Text('${open.coupon!.code} Coupon Applied', textScaler: TextScaler.noScaling, style: orderDateStyle2),
                                          if (open.coupon!.type != 'subscription')
                                            Text(
                                                open.type == 'Custom'
                                                    ? open.coupon!.getFormattedDiscount2()
                                                    : open.coupon!.getFormattedDiscount1(open.qty * double.parse(open.product!.calculateDiscountedPrice())),
                                                style: const TextStyle(color: Color(0xFF2F9623), fontSize: 13, fontFamily: 'Poppins', fontWeight: FontWeight.w700)),
                                        ],
                                      ),
                                      if (open.coupon!.type == 'subscription') Text(open.coupon!.getFormattedDiscount2(), style: buyfree)
                                    ],
                                  ),
                                ),
                              const Text('Subscription pattern', style: subSidehead),
                              const SizedBox(height: 7.5),
                              Row(
                                children: [
                                  Container(
                                      height: 27.5,
                                      padding: const EdgeInsets.symmetric(horizontal: 5),
                                      margin: const EdgeInsets.only(right: 5),
                                      decoration:
                                          BoxDecoration(border: Border.all(width: 1, color: const Color(0xFF2F9623)), borderRadius: BorderRadius.circular(5.90), color: const Color(0xFFEFFFED)),
                                      child: Center(
                                          child: Text(open.type,
                                              textScaler: TextScaler.noScaling, style: const TextStyle(color: Color(0xFF2F9623), fontSize: 11, fontFamily: 'Poppins', fontWeight: FontWeight.w500)))),
                                ],
                              ),
                              if (open.type == 'Custom')
                                Column(children: [
                                  for (CustomPatern i in open.weekdays)
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
                                              Text(i.name,
                                                  textScaler: TextScaler.noScaling, style: const TextStyle(color: Color(0xFF1D2730), fontSize: 15, fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
                                            ],
                                          ),
                                          Container(
                                            width: 50.84,
                                            height: 20.44,
                                            decoration: BoxDecoration(border: Border.all(width: 0.50, color: const Color(0xFFFD995B)), borderRadius: BorderRadius.circular(3.99)),
                                            child: Center(child: Text(i.qty.toString(), textScaler: TextScaler.noScaling)),
                                          )
                                        ],
                                      ),
                                    )
                                ]),
                              const SizedBox(height: 15),
                              const Text('Schedule time', style: subSidehead),
                              const SizedBox(height: 7.5),
                              Row(
                                children: [
                                  Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 5),
                                      height: 27.5,
                                      margin: const EdgeInsets.only(right: 5),
                                      decoration:
                                          BoxDecoration(border: Border.all(width: 1, color: const Color(0xFF2F9623)), borderRadius: BorderRadius.circular(5.90), color: const Color(0xFFEFFFED)),
                                      child: Center(
                                          child: Text(getschedule(open.schedule),
                                              textScaler: TextScaler.noScaling, style: const TextStyle(color: Color(0xFF2F9623), fontSize: 11, fontFamily: 'Poppins', fontWeight: FontWeight.w500)))),
                                ],
                              ),
                              const SizedBox(height: 15),
                              const Text('Subscription start date', style: subSidehead),
                              const SizedBox(height: 7.5),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    height: 27.5,
                                    decoration: BoxDecoration(color: const Color(0xFFEFFFED), border: Border.all(width: 1, color: const Color(0xFF2F9623)), borderRadius: BorderRadius.circular(5.90)),
                                    child: Center(
                                        child: Text(formatDatefromString(open.start),
                                            textScaler: TextScaler.noScaling,
                                            style: const TextStyle(color: Color(0xFF2F9623), fontSize: 11, fontFamily: 'Poppins', fontWeight: FontWeight.w500),
                                            textAlign: TextAlign.center)),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 7.5),
                              if (open.getUpcomingTUWDeliveries().isNotEmpty)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Upcomming Deliveries', style: subSidehead),
                                    const SizedBox(height: 7.5),
                                    Row(
                                      children: [
                                        for (DateTime i in open.getUpcomingTUWDeliveries())
                                          Container(
                                            margin: const EdgeInsets.only(right: 5),
                                            padding: const EdgeInsets.symmetric(horizontal: 10),
                                            height: 27.5,
                                            decoration:
                                                BoxDecoration(color: const Color(0xFFEFFFED), border: Border.all(width: 1, color: const Color(0xFF2F9623)), borderRadius: BorderRadius.circular(5.90)),
                                            child: Center(
                                                child: Text(formatDatefromString(i.toString()),
                                                    textScaler: TextScaler.noScaling,
                                                    style: const TextStyle(color: Color(0xFF2F9623), fontSize: 11, fontFamily: 'Poppins', fontWeight: FontWeight.w500),
                                                    textAlign: TextAlign.center)),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                            ],
                          ),
                          if (open.type.toLowerCase() != "one time")
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 15),
                                const Text('Choose days to cancel', style: subSidehead),
                                const SizedBox(height: 15),
                                const Text('You can cancel the date for a given day until 11:30 AM the day before.', textScaler: TextScaler.noScaling, style: subSidehead),
                                Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                    decoration: ShapeDecoration(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(side: const BorderSide(width: 1, color: Color(0xFFEBEBEB)), borderRadius: BorderRadius.circular(20)),
                                      shadows: const [BoxShadow(color: Color(0x192F9623), blurRadius: 19.48)],
                                    ),
                                    child: CustomCalendar(
                                        inactive: apiProvider.skipped, active: generateDateList(open.start, open.type, open.weekdays), onCalendarChanged: (val) => apiProvider.skipped = val))
                              ],
                            ),
                        ]),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Shipping address', textScaler: TextScaler.noScaling, style: subBoxHead),
                          ],
                        ),
                      ),
                      if (open.address != null)
                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                            width: size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Text(open.address!.address.split(',').toList().first, style: const TextStyle(color: Color(0xFF1D2730), fontSize: 16, fontFamily: 'Poppins', fontWeight: FontWeight.w700)),
                              Text(open.address!.address, style: const TextStyle(color: Color(0xFF909090), fontSize: 11, fontFamily: 'Poppins', fontWeight: FontWeight.w400)),
                              if (open.address!.addressLine.isNotEmpty)
                                Text(open.address!.addressLine, style: const TextStyle(color: Color(0xFF909090), fontSize: 11, fontFamily: 'Poppins', fontWeight: FontWeight.w400)),
                              const SizedBox(height: 5),
                              Text('Landmark : ${open.address!.landmark}', style: const TextStyle(color: Color(0xFF909090), fontSize: 11, fontFamily: 'Poppins', fontWeight: FontWeight.w400)),
                              Text('Phone number : ${open.address!.phone}', style: const TextStyle(color: Color(0xFF909090), fontSize: 11, fontFamily: 'Poppins', fontWeight: FontWeight.w400)),
                              const SizedBox(height: 15),
                            ])),
                    ]),
                    if (open.type.toLowerCase() != "one time")
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 30),
                        width: size.width,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xFF308CEF),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            submit();
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Text('Confirm', textScaler: TextScaler.noScaling, style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
                        ),
                      )
                  ],
                ),
              ),
      ),
    );
  }
}
