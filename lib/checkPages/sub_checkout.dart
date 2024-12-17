import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gogreen_lite/Allproviders/api_provider.dart';
import 'package:gogreen_lite/Allproviders/main_provider.dart';
import 'package:gogreen_lite/ExtraWidgets/stepper_button.dart';
import 'package:gogreen_lite/checkPages/widgets/location_saved_checkout.dart';
import 'package:gogreen_lite/extraFunctions.dart';
import 'package:gogreen_lite/extraStyle.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../Allproviders/object.dart';
import '../extrawidgets.dart';
import 'widgets/instruction_box.dart';
import 'widgets/sub_pattern_box.dart';

List<String> allInstructions = ['Avoid ringing bell', 'Leave at the door', 'Avoid calling', 'Leave with security'];
List<String> instrunctionIcon = ['assets/icons/bell.png', 'assets/icons/door.png', 'assets/icons/phone.png', 'assets/icons/security.png'];

class SubCheckout extends StatefulWidget {
  const SubCheckout({super.key});

  @override
  State<SubCheckout> createState() => _SubCheckoutState();
}

class _SubCheckoutState extends State<SubCheckout> with SingleTickerProviderStateMixin {
  TextEditingController couponEditor = TextEditingController(text: '');
  late Animation<double> _animation;
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    final apiProvider = Provider.of<ApiProvider>(context, listen: false);
    if (apiProvider.appliedCoupon != null) {
      couponEditor = TextEditingController(text: apiProvider.appliedCoupon?.code ?? "");
    }

    _controller = AnimationController(duration: const Duration(seconds: 4), vsync: this)..repeat();
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<ApiProvider>(context);
    final mainProvider = Provider.of<MainProvider>(context);
    SubProduct? product = mainProvider.selectedSubProduct;
    final Size size = MediaQuery.of(context).size;
    UserAddress? selected = mainProvider.pickedSaved;

    void showCustomBottomCoupon() {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Consumer<ApiProvider>(builder: (context, provider, child) {
              return Column(children: [
                Expanded(
                    child: apiProvider.couponreload
                        ? const Center(child: CircularProgressIndicator())
                        : apiProvider.couponlist.isEmpty
                            ? const Center(child: Text('No Coupons Available', textScaler: TextScaler.noScaling, style: premoHint))
                            : ListView(
                                padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                                children: [
                                  for (var coupon in apiProvider.couponlist)
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: (coupon.multisub == 0 && coupon.usedcount > 1) ? Colors.black12 : Colors.white,
                                              borderRadius: BorderRadius.circular(12),
                                              boxShadow: (coupon.multisub == 0 && coupon.usedcount > 1) ? null : [const BoxShadow(color: Color(0x3F000000), blurRadius: 4, offset: Offset(0, 2))]),
                                          child: MaterialButton(
                                            onPressed: () {
                                              // Navigator.pop(context);
                                              preloadView(context);
                                              apiProvider.couponChecking = true;
                                              apiProvider.notify();
                                              apiProvider.subCheckCoupon(code: coupon.code, product: product).then((value) {
                                                apiProvider.couponChecking = false;
                                                apiProvider.notify();
                                                Navigator.pop(context);
                                                if (value['status']) {
                                                  couponEditor.text = coupon.code;
                                                  apiProvider.appliedCoupon = coupon;
                                                  apiProvider.couponreadonly = true;
                                                  apiProvider.notify();
                                                  Navigator.pop(context);
                                                } else {
                                                  showAlert(context, clr: Colors.red, msg: value['msg']).then((value) => Navigator.pop(context));
                                                }
                                              });
                                            },
                                            // onPressed: (coupon.multisub == 0 && coupon.usedcount > 1)
                                            //     ? () {}
                                            //     : () {
                                            //         couponEditor.text = coupon.code;
                                            //         apiProvider.appliedCoupon = coupon;
                                            //         apiProvider.couponreadonly = true;
                                            //         apiProvider.notify();
                                            //         Future.delayed(const Duration(milliseconds: 400)).then((value) => Navigator.pop(context));
                                            //       },
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(coupon.desc,
                                                    textScaler: TextScaler.noScaling,
                                                    style: const TextStyle(color: Color(0xFF1D2730), fontSize: 16, fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
                                                Text(coupon.getFormattedDiscount(double.parse(product!.calculateDiscountedPrice()) * mainProvider.productqty),
                                                    textScaler: TextScaler.noScaling,
                                                    style: const TextStyle(color: Color(0xFF308CEF), fontSize: 9, fontFamily: 'Poppins', fontWeight: FontWeight.w400)),
                                                const SizedBox(height: 10),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Container(
                                                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                                        decoration:
                                                            BoxDecoration(border: Border.all(width: 1, color: const Color.fromARGB(255, 105, 105, 105)), borderRadius: BorderRadius.circular(5)),
                                                        child: Text(coupon.code,
                                                            textScaler: TextScaler.noScaling,
                                                            style: const TextStyle(color: Color(0xFF1D2730), fontSize: 12, fontFamily: 'Poppins', fontWeight: FontWeight.w500, letterSpacing: 2.88))),
                                                    InkWell(
                                                      splashColor: Colors.transparent,
                                                      onTap: () {
                                                        coupon.expand = !coupon.expand;
                                                        apiProvider.notify();
                                                      },
                                                      child: Row(
                                                        children: [
                                                          const Text('View Details',
                                                              textScaler: TextScaler.noScaling,
                                                              style: TextStyle(color: Color(0xFF515151), fontSize: 9, fontFamily: 'Poppins', fontWeight: FontWeight.w400)),
                                                          Icon(!coupon.expand ? Icons.keyboard_arrow_down_outlined : Icons.keyboard_arrow_up_outlined)
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                if (coupon.expand) HtmlWidget(coupon.terms, textStyle: const TextStyle(color: Colors.black54, fontSize: 11))
                                              ],
                                            ),
                                          ),
                                        ),
                                        if (coupon.multisub == 0 && coupon.usedcount > 1)
                                          const Text('Not Available', textScaler: TextScaler.noScaling, style: TextStyle(color: Colors.red, fontSize: 11)),
                                        const SizedBox(height: 10)
                                      ],
                                    ),
                                ],
                              ))
              ]);
            });
          });
    }

    void showCustomBottomAddress() {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Choose a delivery address', textScaler: TextScaler.noScaling, style: priceUnit),
                      Container(
                        height: 20,
                        decoration: BoxDecoration(color: const Color(0xFFFFF3F3), border: Border.all(width: 0.87, color: const Color(0xFFC60D05)), borderRadius: BorderRadius.circular(6)),
                        child: SizedBox(
                          width: 55,
                          child: MaterialButton(
                            onPressed: () => Future.delayed(const Duration(milliseconds: 300), () => Navigator.pop(context)),
                            elevation: 10,
                            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                            child: const Text('Close',
                                textScaler: TextScaler.noScaling, style: TextStyle(color: Color(0xFFC60D05), fontSize: 9.5, fontFamily: 'Poppins', fontWeight: FontWeight.w500, height: 1.2)),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  Expanded(
                    child: ListView(children: [
                      for (var i in apiProvider.userAddress)
                        LocationSavedCheckout(
                            address: i,
                            onpressed: () {
                              Future.delayed(const Duration(milliseconds: 500), () => Navigator.pop(context));
                              mainProvider.updatePickedsaved(i);
                            })
                    ]),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 20),
                      width: size.width,
                      height: 44,
                      decoration: BoxDecoration(color: const Color(0xFFF8FFF7), border: Border.all(width: 1, color: const Color(0xFF2F9623)), borderRadius: BorderRadius.circular(9)),
                      child: MaterialButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.5)),
                          onPressed: () {
                            mainProvider.checkpagesIndex = 4;
                            mainProvider.notify();
                            Navigator.pop(context);
                          },
                          child: const Text('ADD NEW ADDRESS',
                              textScaler: TextScaler.noScaling, style: TextStyle(color: Color(0xFF2F9623), fontSize: 13, fontFamily: 'Poppins', fontWeight: FontWeight.w400))))
                ],
              ),
            );
          });
    }

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
                mainProvider.pageType--;
                mainProvider.notify();
              },
              child: Image.asset('assets/icons/left-broken.png', width: 40, color: const Color(0xFF1D2730))),
        ),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [Text('Subscription Checkout', textScaler: TextScaler.noScaling, style: TextStyle(color: Color(0xFF1D2730), fontSize: 16, fontFamily: 'Poppins', fontWeight: FontWeight.w500))],
        ),
        actions: const [SizedBox(width: 60)],
      ),
      body: product == null
          ? Container(height: size.height, width: size.width, color: const Color(0xFFF6F6F6), child: const Center(child: CircularProgressIndicator()))
          : Stack(
              children: [
                Container(
                  height: size.height,
                  width: size.width,
                  padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                  color: const Color(0xFFF6F6F6),
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      Container(
                        width: size.width,
                        margin: const EdgeInsets.only(top: 15),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
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
                              StepperButton(
                                  f1: () {
                                    if (mainProvider.productqty > 1) {
                                      mainProvider.productqty--;
                                      mainProvider.notify();
                                    }
                                  },
                                  f2: () {
                                    mainProvider.productqty++;
                                    mainProvider.notify();
                                  },
                                  val: mainProvider.productqty)
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
                                        direction: Axis.horizontal,
                                      ),
                                      const SizedBox(width: 2),
                                      Text('(${product.sellernumofreview})', style: menusub),
                                    ],
                                  ),
                                  SizedBox(child: Center(child: Text('₹${product.calculateDiscountedPrice()}/${product.unit}', textScaler: TextScaler.noScaling, style: priceUnit)))
                                ],
                              ),
                              Container(width: size.width, height: 1.5, margin: const EdgeInsets.symmetric(vertical: 10), color: const Color(0x111D2730)),
                              const Text('Subscription pattern', style: subSidehead),
                              const SizedBox(height: 7.5),
                              mainProvider.onlyOne
                                  ? Row(children: [SubPatternBox(active: mainProvider.pattenIndex == 0, label: pattern[0], ontap: () => mainProvider.updatepattenIndex(0))])
                                  : Row(
                                      children: [
                                        for (var i = 1; i < pattern.length; i++)
                                          SubPatternBox(
                                              active: mainProvider.pattenIndex == i,
                                              label: pattern[i],
                                              ontap: () {
                                                if (i == 3) {
                                                  for (var item in custom) {
                                                    item.qty = 1;
                                                  }
                                                  mainProvider.customPattern.clear();
                                                }
                                                mainProvider.updatepattenIndex(i);
                                              }),
                                      ],
                                    ),
                              if (mainProvider.pattenIndex == 3)
                                Container(
                                  width: size.width,
                                  margin: const EdgeInsets.only(top: 10),
                                  padding: const EdgeInsets.fromLTRB(10, 05, 10, 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 1, color: const Color(0x77F28B51)),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('Choose days', style: TextStyle(color: Color(0xFF909090), fontSize: 11, fontWeight: FontWeight.w500)),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          for (CustomPatern i in custom)
                                            Container(
                                              width: 35,
                                              height: 27.5,
                                              margin: const EdgeInsets.only(right: 5),
                                              decoration: BoxDecoration(
                                                  color: findIndexByKeyInCustomPatern(mainProvider.customPattern, i.label) != -1 ? const Color(0xFFFFF1EA) : null,
                                                  border: Border.all(
                                                      width: 0.90, color: findIndexByKeyInCustomPatern(mainProvider.customPattern, i.label) != -1 ? const Color(0xFFF28B51) : const Color(0xFF909090)),
                                                  borderRadius: BorderRadius.circular(6)),
                                              child: MaterialButton(
                                                onPressed: () {
                                                  if (findIndexByKeyInCustomPatern(mainProvider.customPattern, i.label) == -1) {
                                                    mainProvider.customPattern.add(i);
                                                  } else {
                                                    custom[findIndexByKeyInCustomPatern(custom, i.label)].qty = 1;
                                                    mainProvider.customPattern.remove(i);
                                                  }
                                                  mainProvider.notify();
                                                },
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                                padding: EdgeInsets.zero,
                                                splashColor: const Color(0xFFFFF1EA),
                                                highlightColor: const Color(0xFFFFF1EA),
                                                child: Center(
                                                  child: Text(
                                                    i.label,
                                                    style: TextStyle(
                                                        color: findIndexByKeyInCustomPatern(mainProvider.customPattern, i.label) != -1 ? const Color(0xFFF28B51) : const Color(0xFF909090),
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                                ),
                                              ),
                                            )
                                        ],
                                      ),
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
                                              StepperButton(
                                                  f1: () {
                                                    if (i.qty > 1) {
                                                      i.qty--;
                                                      mainProvider.notify();
                                                    }
                                                  },
                                                  f2: () {
                                                    i.qty++;
                                                    mainProvider.notify();
                                                  },
                                                  val: i.qty,
                                                  clr: const Color(0xFFFD995B),
                                                  width: 70,
                                                  height: 25)
                                            ],
                                          ),
                                        )
                                    ],
                                  ),
                                ),
                              const SizedBox(height: 15),
                              const Text('Schedule time', style: subSidehead),
                              const SizedBox(height: 7.5),
                              Row(
                                children: [
                                  for (var i = 0; i < schedule.length; i++) SubPatternBox(active: mainProvider.scheduleIndex == i, label: schedule[i], ontap: () => mainProvider.updatescheduleIndex(i))
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
                                    child: MaterialButton(
                                      onPressed: () => mainProvider.togglecheckoutCalandershow(),
                                      padding: EdgeInsets.zero,
                                      child: Center(
                                          child: Text(formatDate(mainProvider.singleDate),
                                              textScaler: TextScaler.noScaling,
                                              style: const TextStyle(color: Color(0xFF2F9623), fontSize: 11, fontFamily: 'Poppins', fontWeight: FontWeight.w500),
                                              textAlign: TextAlign.center)),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 7.5),
                              if (DateTime.now().hour > 11)
                                const Text("Note : Sorry, you won't be able to set the subscription start date for tomorrow as the order for tomorrow has already been generated.",
                                    textScaler: TextScaler.noScaling, style: subSidehead),
                              if (mainProvider.checkoutCalandershow)
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(width: 1, color: const Color(0xFFEBEBEB)),
                                      borderRadius: BorderRadius.circular(23),
                                      boxShadow: const [BoxShadow(color: Color(0x192F9623), blurRadius: 20)]),
                                  child: SfDateRangePicker(
                                    selectionMode: DateRangePickerSelectionMode.single,
                                    // minDate: DateTime.now().subtract(const Duration(days: 2)),
                                    minDate: DateTime.now().hour < 11 ? DateTime.now().add(const Duration(days: 1)) : DateTime.now().add(const Duration(days: 2)),
                                    initialSelectedDate: mainProvider.singleDate,
                                    onSelectionChanged: (val) {
                                      mainProvider.singleDate = val.value;
                                      mainProvider.checkoutCalandershow = false;
                                      mainProvider.notify();
                                    },
                                  ),
                                ),
                            ],
                          ),
                        ]),
                      ),

                      const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Coupons & discount', textScaler: TextScaler.noScaling, style: subBoxHead)])),
                      CustomPaint(
                        painter: apiProvider.couponChecking ? SnakeBorderPainter(animation: _animation) : null,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                          width: size.width,
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset('assets/icons/bxs_offer.png', height: 25, color: const Color(0xFF2F9623)),
                                      const SizedBox(width: 5),
                                      const Text('Select promo code', textScaler: TextScaler.noScaling, style: walletLabel)
                                    ],
                                  ),
                                  InkWell(
                                      onTap: () {
                                        apiProvider.couponreload = true;
                                        apiProvider.notify();
                                        showCustomBottomCoupon();
                                        apiProvider.getCoupons().then((value) {
                                          apiProvider.couponlist = value;
                                          apiProvider.couponreload = false;
                                          apiProvider.notify();
                                        });
                                      },
                                      child: const Text('View all offers',
                                          textScaler: TextScaler.noScaling, style: TextStyle(color: Color(0xFFF28B51), fontSize: 13, fontFamily: 'Poppins', fontWeight: FontWeight.w500)))
                                ],
                              ),
                              Stack(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                          child: TextField(
                                              controller: couponEditor,
                                              readOnly: apiProvider.couponreadonly,
                                              style: const TextStyle(fontWeight: FontWeight.w600),
                                              decoration: const InputDecoration(hintText: 'Enter promo code', hintStyle: premoHint, border: InputBorder.none))),
                                      InkWell(
                                          onTap: () {
                                            if (apiProvider.couponreadonly) {
                                              apiProvider.appliedCoupon = null;
                                              apiProvider.couponreadonly = false;
                                              apiProvider.notify();
                                            } else {
                                              if (couponEditor.text.length > 3) {
                                                FocusScope.of(context).unfocus();
                                                preloadView(context);
                                                apiProvider.couponChecking = true;
                                                apiProvider.notify();
                                                apiProvider.subCheckCoupon(code: couponEditor.text, product: product).then((value) {
                                                  apiProvider.couponChecking = false;
                                                  apiProvider.notify();
                                                  Navigator.pop(context);
                                                  if (value['status']) {
                                                    apiProvider.couponreadonly = true;
                                                    apiProvider.notify();
                                                  } else {
                                                    showAlert(context, clr: Colors.red, msg: value['msg']);
                                                  }
                                                });
                                              }
                                            }
                                          },
                                          child: Text(apiProvider.couponreadonly ? 'Change' : 'APPLY',
                                              textScaler: TextScaler.noScaling,
                                              style: TextStyle(
                                                  color: apiProvider.couponreadonly ? const Color(0xFFF28B51) : const Color(0xFF2F9623),
                                                  fontSize: 14,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500)))
                                    ],
                                  ),
                                  Positioned(bottom: 0, child: Container(width: size.width, height: 1, color: const Color(0x5E1D2730)))
                                ],
                              ),
                              if (apiProvider.couponreadonly)
                                Row(
                                  children: [
                                    Image.asset('assets/icons/bxs_offer.png', height: 25, color: const Color(0xFF2F9623)),
                                    const Text('Coupon Applied', textScaler: TextScaler.noScaling, style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600))
                                  ],
                                )
                            ],
                          ),
                        ),
                      ),

                      // address container

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Shipping address', textScaler: TextScaler.noScaling, style: subBoxHead),
                            Container(
                                height: 23,
                                decoration: BoxDecoration(color: const Color(0xFFFFF6F1), border: Border.all(width: 1, color: const Color(0xFFF28B51)), borderRadius: BorderRadius.circular(6)),
                                child: MaterialButton(
                                    onPressed: () => showCustomBottomAddress(),
                                    child: const Text('Change',
                                        textScaler: TextScaler.noScaling, style: TextStyle(color: Color(0xFFF28B51), fontSize: 10, fontFamily: 'Poppins', fontWeight: FontWeight.w500))))
                          ],
                        ),
                      ),
                      if (apiProvider.addAddressReload) const LinearProgressIndicator(color: Colors.green, minHeight: 1),
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
                              const SizedBox(height: 15),
                            ],
                          ),
                        )
                      else
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                          width: size.width,
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                          child: const Center(child: Text('No address is selected', style: premoHint)),
                        ),
                      const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Select delivery instruction', textScaler: TextScaler.noScaling, style: subBoxHead)])),
                      Container(
                        width: size.width,
                        padding: const EdgeInsets.all(10),
                        height: 105,
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                        child: Wrap(
                          direction: Axis.horizontal,
                          runAlignment: WrapAlignment.spaceBetween,
                          alignment: WrapAlignment.spaceBetween,
                          children: [
                            for (var i = 0; i < allInstructions.length; i++)
                              InstructionBox(
                                lable: allInstructions[i],
                                icon: instrunctionIcon[i],
                                selected: mainProvider.instructions.contains(allInstructions[i]),
                                onpressed: () {
                                  if (mainProvider.instructions.contains(allInstructions[i])) {
                                    mainProvider.instructions.remove(allInstructions[i]);
                                  } else {
                                    mainProvider.instructions.add(allInstructions[i]);
                                  }
                                  mainProvider.notify();
                                },
                              )
                          ],
                        ),
                      ),
                      const SizedBox(height: 100)
                    ],
                  )),
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
                      decoration: BoxDecoration(color: const Color(0xFF2F9623), borderRadius: BorderRadius.circular(15)),
                      child: MaterialButton(
                        onPressed: () {
                          if (mainProvider.pickedSaved != null) {
                            facebookAppEvents.logAddToCart(id: '', type: '', currency: 'inr', price: 1, content: {'name': product.name + product.unit});
                            mainProvider.checkpagesIndex = 1;
                            mainProvider.notify();
                          } else {
                            showCustomBottomAddress();
                          }
                        },
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(43)),
                        child: const Text('Review Order', textScaler: TextScaler.noScaling, style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
                      ),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}

class SnakeBorderPainter extends CustomPainter {
  final Animation<double> animation;
  SnakeBorderPainter({required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = const Color(0xFFF28B51)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    final double progress = animation.value;
    final double perimeter = 2 * (size.width + size.height);
    const double snakeLength = 50;
    final double distance = perimeter * progress;
    final RRect rRect = RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, size.width, size.height), const Radius.circular(15));
    final Path path = Path()..addRRect(rRect);
    final PathMetrics pathMetrics = path.computeMetrics();
    for (PathMetric pathMetric in pathMetrics) {
      final Path extractPath = pathMetric.extractPath(distance - snakeLength, distance);
      canvas.drawPath(extractPath, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
