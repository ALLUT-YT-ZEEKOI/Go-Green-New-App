import 'package:flutter/material.dart';
import 'package:gogreen_lite/Allproviders/api_provider.dart';
import 'package:gogreen_lite/Allproviders/object.dart';
import 'package:provider/provider.dart';

import '../extraStyle.dart';
import '../extrafunctions.dart';
import '../extrawidgets.dart';

class OrderOpen extends StatelessWidget {
  const OrderOpen({super.key});
  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<ApiProvider>(context);
    OrderOpenDetails? order = apiProvider.currentorder;
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        toolbarHeight: 60,
        backgroundColor: const Color(0xFFF6F6F6),
        shadowColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(onTap: () => Navigator.pop(context), child: Image.asset('assets/icons/left-broken.png', width: 40, color: const Color(0xFF1D2730))),
        ),
        title: const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [Text('Order Details', style: TextStyle(color: Color(0xFF1D2730), fontSize: 16, fontFamily: 'Poppins', fontWeight: FontWeight.w500))]),
        actions: const [SizedBox(width: 60)],
      ),
      body: Container(
        color: const Color(0xFFF6F6F6),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: apiProvider.orderOpenPreload == 1
            ? const Center(child: CircularProgressIndicator())
            : order != null
                ? ListView(
                    children: [
                      const SizedBox(height: 10),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 15),
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
                          shadows: const [BoxShadow(color: Color(0x14000000), blurRadius: 3.82, offset: Offset(0, 0), spreadRadius: 0)],
                        ),
                        child: Column(children: [
                          Row(children: [const Text('Order No : ', textScaler: TextScaler.noScaling, style: orderDateStyle), Text(order.code, textScaler: TextScaler.noScaling, style: orderHead1)]),
                          // const SizedBox(height: 10),
                          // Row(children: [const Text('Tracking Id : ', style: orderDateStyle), Text(order.trackingCode, style: orderHead1)])
                        ]),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 15),
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                        decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
                            shadows: const [BoxShadow(color: Color(0x14000000), blurRadius: 3.82, offset: Offset(0, 0), spreadRadius: 0)]),
                        child: Column(
                          children: [
                            for (OrderDetails i in order.orderDetails)
                              Row(
                                children: [
                                  Container(
                                    width: 55,
                                    height: 55,
                                    decoration: BoxDecoration(border: Border.all(width: 1, color: const Color(0xFF1D2730)), borderRadius: BorderRadius.circular(6)),
                                    child: ClipRRect(borderRadius: BorderRadius.circular(6), child: Image.network(i.product.imageUrl)),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('${i.product.name} (x${i.quantity})',
                                          textScaler: TextScaler.noScaling, style: const TextStyle(color: Color(0xFF1D2730), fontSize: 16, fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
                                      const SizedBox(height: 5),
                                      Text('${i.calculateUnitPrice()}/${i.product.unit}',
                                          textScaler: TextScaler.noScaling, style: const TextStyle(color: Color(0xFF2F9623), fontSize: 15, fontFamily: 'Poppins', fontWeight: FontWeight.w600))
                                    ],
                                  ),
                                ],
                              ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Product sold by', textScaler: TextScaler.noScaling, style: orderDateStyle),
                                Row(children: [
                                  Image.asset('assets/icons/farmer-icon.png', height: 18, color: const Color(0xFF2F9623)),
                                  const SizedBox(width: 5),
                                  Text(order.seller.name, textScaler: TextScaler.noScaling, style: farmerNameStyle)
                                ])
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [for (var i = 0; i < (size.width - 60) / 20; i++) Container(height: 1, width: 15, color: const Color(0xFFD9D9D9))]),
                            const SizedBox(height: 10),
                            invoiceSummry(label: 'Invoice No :', val: order.invoice),
                            invoiceSummry(label: 'Bill To :', val: order.shippingAddress.name),
                            invoiceSummry(label: 'Date :', val: formatDate3(order.createdAt)),
                            invoiceSummry(label: 'Address :', val: order.shippingAddress.getAddressString()),
                            const SizedBox(height: 10),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [for (var i = 0; i < (size.width - 60) / 20; i++) Container(height: 1, width: 15, color: const Color(0xFFD9D9D9))]),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [for (var i = 0; i < (size.width - 60) / 20; i++) Container(height: 1, width: 15, color: const Color(0xFFD9D9D9))]),
                            const SizedBox(height: 10),
                            invoiceSummry(label: 'Total Amount :', val: '₹ ${order.calculateTotal()}'),
                            invoiceSummry(label: 'Shipping Cost :', val: order.calculateTotalShipping() > 0 ? '₹${order.calculateTotalShipping}' : 'Free'),
                            invoiceSummry(label: 'Tax :', val: '₹ ${order.calculateTotalTax()}'),
                            invoiceSummry(label: 'Coupon Discount :', val: '- ₹ ${order.coupondiscount}'),
                            invoiceSummryBold(label: 'Grand Total :', val: '₹ ${order.grandTotal}'),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                      const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Text('Note:\nFor Subscription orders: Orders for the next day are generated at 12:05 PM the day before.', textScaler: TextScaler.noScaling, style: subSidehead)),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 25),
                        height: 40,
                        decoration: BoxDecoration(color: const Color(0xFFE2F0FF), border: Border.all(width: 1.17, color: const Color(0xFF308CEF)), borderRadius: BorderRadius.circular(6.88)),
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.5)),
                          child: const Text('Go Back', textScaler: TextScaler.noScaling, style: TextStyle(color: Color(0xFF308CEF), fontSize: 12, fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
                        ),
                      ),
                      // Container(
                      //   height: 40,
                      //   decoration: BoxDecoration(color: const Color(0xFFFFE8EA), border: Border.all(width: 1.17, color: const Color(0xFFDC3647)), borderRadius: BorderRadius.circular(6.88)),
                      //   child: MaterialButton(
                      //     onPressed: () {},
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(6.5),
                      //     ),
                      //     child: const Text('Cancel', style: TextStyle(color: Color(0xFFDC3647), fontSize: 12, fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
                      //   ),
                      // )
                    ],
                  )
                : const SizedBox(),
      ),
    );
  }
}
