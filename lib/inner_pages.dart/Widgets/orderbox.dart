import 'package:flutter/material.dart';
import 'package:gogreen_lite/Allproviders/api_provider.dart';
import 'package:gogreen_lite/Allproviders/object.dart';
import 'package:gogreen_lite/extrafunctions.dart';
import 'package:gogreen_lite/orderPages/orderopen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../extraStyle.dart';

class OrderBox extends StatelessWidget {
  const OrderBox({super.key, required this.order});
  final Order order;
  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<ApiProvider>(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        boxShadow: const [BoxShadow(color: Color(0x14000000), blurRadius: 3.82, offset: Offset(0, 0), spreadRadius: 0)],
      ),
      child: Column(
        children: [
          Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
                color: order.deliveryStatus == 'cancelled' ? const Color(0xFFFFABA8) : const Color(0xFFEEFFC1),
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(17), topRight: Radius.circular(17))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text('Order No:', textScaler: TextScaler.noScaling, style: orderDateStyle),
                    const SizedBox(width: 5),
                    Text(order.code, textScaler: TextScaler.noScaling, style: orderHead1)
                  ],
                ),
                Text(formatDate(order.createdAt), textScaler: TextScaler.noScaling, style: orderDateStyle)
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
                color: order.deliveryStatus == 'cancelled' ? const Color(0xFFFFEAE9) : null,
                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(17), bottomRight: Radius.circular(17)),
                border: order.deliveryStatus == 'cancelled'
                    ? const Border(
                        bottom: BorderSide(color: Color(0xFFC60D05), width: 1.0),
                        left: BorderSide(color: Color(0xFFC60D05), width: 1.0),
                        right: BorderSide(color: Color(0xFFC60D05), width: 1.0),
                      )
                    : null),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text('No: of products:', textScaler: TextScaler.noScaling, style: orderDateStyle),
                          const SizedBox(width: 5),
                          Text('${order.orderDetailsCount}', textScaler: TextScaler.noScaling, style: orderHead1)
                        ],
                      ),
                      Row(
                        children: [
                          const Text('Total Amount:', textScaler: TextScaler.noScaling, style: orderDateStyle),
                          const SizedBox(width: 5),
                          Text('₹${order.grandTotal}', textScaler: TextScaler.noScaling, style: orderHead1)
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 12,
                                height: 12,
                                margin: const EdgeInsets.symmetric(horizontal: 5),
                                decoration: ShapeDecoration(color: getStatusBg(order.deliveryStatus), shape: const OvalBorder()),
                                child: Center(child: Container(width: 6, height: 6, decoration: ShapeDecoration(color: getStatus(order.deliveryStatus), shape: const OvalBorder()))),
                              ),
                              Text(capitalizeFirstLetter(order.deliveryStatus),
                                  textScaler: TextScaler.noScaling, style: TextStyle(color: getStatus(order.deliveryStatus), fontSize: 13, fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
                            ],
                          ),
                          if (order.delivered != null) Text(formatDate(order.delivered!), style: orderDateStyle2)
                        ],
                      ),
                      Padding(padding: const EdgeInsets.only(top: 10), child: Image.asset('assets/icons/order_icon.png', height: 25)),
                      Container(
                        width: 80,
                        height: 27,
                        decoration: BoxDecoration(color: const Color(0xFFE2F0FF), border: Border.all(width: 1.17, color: const Color(0xFF308CEF)), borderRadius: BorderRadius.circular(6.88)),
                        child: MaterialButton(
                            onPressed: () {
                              apiProvider.updateorderOpenPreload(1);
                              apiProvider.openOrder(order.id, 0);
                              Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: const OrderOpen()));
                            },
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.5)),
                            child: const Text('Detail',
                                textScaler: TextScaler.noScaling, style: TextStyle(color: Color(0xFF308CEF), fontSize: 11.66, fontFamily: 'Poppins', fontWeight: FontWeight.w500))),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
