// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:gogreen_lite/Allproviders/main_provider.dart';
import 'package:gogreen_lite/Allproviders/object.dart';
import 'package:provider/provider.dart';
import '../Allproviders/api_provider.dart';
import '../customPackages/custom_toggle.dart';
import '../extraStyle.dart';
import '../extrafunctions.dart';
import '../extrawidgets.dart';

class Trasaction extends StatelessWidget {
  const Trasaction({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final mainProvider = Provider.of<MainProvider>(context);
    final apiProvider = Provider.of<ApiProvider>(context);

    return RefreshIndicator(
      onRefresh: () async {
        apiProvider.updateTrasactionreload(true);
        apiProvider.getTransaction(mainProvider.transactionIndex, 0);
      },
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          toolbarHeight: 60,
          backgroundColor: const Color(0xFFF6F6F6),
          shadowColor: Colors.transparent,
          leading: InkWell(
              onTap: () {
                mainProvider.pageType = 0;
                mainProvider.notify();
              },
              child: Padding(padding: const EdgeInsets.all(8.0), child: Image.asset('assets/icons/left-broken.png', width: 40, color: const Color(0xFF1D2730)))),
          title: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [Text('Transaction History', textScaler: TextScaler.noScaling, style: TextStyle(color: Color(0xFF1D2730), fontSize: 16, fontFamily: 'Poppins', fontWeight: FontWeight.w500))]),
          actions: const [SizedBox(width: 60)],
        ),
        body: Container(
          color: const Color(0xFFF6F6F6),
          child: Column(
            children: [
              CustomToggle(
                width: size.width * .9,
                f1: () {
                  if (mainProvider.transactionIndex != 1) {
                    mainProvider.updatetransactionIndex(1);
                    apiProvider.updateTrasactionreload(true);
                    apiProvider.getTransaction(1, 0);
                  }
                },
                f2: () {
                  if (mainProvider.transactionIndex != 2) {
                    mainProvider.updatetransactionIndex(2);
                    apiProvider.updateTrasactionreload(true);
                    apiProvider.getTransaction(2, 0);
                  }
                },
                f3: () {
                  if (mainProvider.transactionIndex != 3) {
                    mainProvider.updatetransactionIndex(3);
                    apiProvider.updateTrasactionreload(true);
                    apiProvider.getTransaction(3, 0);
                  }
                },
              ),
              Container(
                width: size.width,
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                margin: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: const [BoxShadow(color: Color(0x14000000), blurRadius: 4, offset: Offset(0, 0), spreadRadius: 0)],
                ),
                child: Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      const Text('Advance Balance', textScaler: TextScaler.noScaling, style: orderHead1),
                      Text('${apiProvider.userDetails?.balance.toStringAsFixed(2) ?? 0}',
                          textScaler: TextScaler.noScaling, style: const TextStyle(color: Color(0xFF2F9623), fontSize: 13.37, fontFamily: 'Poppins', fontWeight: FontWeight.w600))
                    ]),
                    const SizedBox(height: 5),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      const Text('Balance Due', textScaler: TextScaler.noScaling, style: orderHead1),
                      Text(apiProvider.walletDue.toStringAsFixed(2),
                          textScaler: TextScaler.noScaling, style: const TextStyle(color: Color(0xFFDC3647), fontSize: 13.37, fontFamily: 'Poppins', fontWeight: FontWeight.w600))
                    ]),
                  ],
                ),
              ),
              apiProvider.trasactionreload
                  ? const SizedBox(height: 300, child: Center(child: CircularProgressIndicator()))
                  : apiProvider.walletTransactions.isEmpty
                      ? const SizedBox(height: 300, child: Center(child: Text('No Transaction')))
                      : Expanded(
                          child: Padding(
                          padding: const EdgeInsets.only(left: 25, right: 10),
                          child: ListView(children: [
                            const SizedBox(height: 10),
                            for (var i in apiProvider.walletTransactions)
                              i.headType() == 0
                                  ? MaterialButton(
                                      onPressed: () async {
                                        showDialog(context: context, barrierDismissible: false, builder: (BuildContext context) => WillPopScope(onWillPop: () async => false, child: const Column()));
                                        await apiProvider.openTranscationOrder(i.transactionid, 0).then((order) {
                                          if (order != null) {
                                            Navigator.pop(context);
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) => AlertDialog(
                                                backgroundColor: Colors.transparent, // Set background color to transparent
                                                contentPadding: EdgeInsets.zero,
                                                content: Container(
                                                  width: size.width * 0.8, // Adjust width as needed
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.circular(17),
                                                    boxShadow: const [BoxShadow(color: Color(0x14000000), blurRadius: 3.82, offset: Offset(0, 0), spreadRadius: 0)],
                                                  ),
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.all(15.0),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            for (OrderDetails i in order.orderDetails)
                                                              Padding(
                                                                padding: const EdgeInsets.only(bottom: 20.0),
                                                                child: Row(
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
                                                                            textScaler: TextScaler.noScaling,
                                                                            style: const TextStyle(color: Color(0xFF1D2730), fontSize: 16, fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
                                                                        const SizedBox(height: 5),
                                                                        Text('${i.calculateUnitPrice()}/${i.product.unit}',
                                                                            textScaler: TextScaler.noScaling,
                                                                            style: const TextStyle(color: Color(0xFF2F9623), fontSize: 15, fontFamily: 'Poppins', fontWeight: FontWeight.w600))
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            const SizedBox(height: 20),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                const Text('Product sold by', textScaler: TextScaler.noScaling, style: orderDateStyle),
                                                                Row(children: [
                                                                  Image.asset('assets/icons/farmer-icon.png', height: 18, color: const Color(0xFF2F9623)),
                                                                  const SizedBox(width: 5),
                                                                  SizedBox(
                                                                      width: (size.width * 0.8) - 150,
                                                                      child: Text(order.seller.name, textScaler: TextScaler.noScaling, overflow: TextOverflow.ellipsis, style: farmerNameStyle))
                                                                ])
                                                              ],
                                                            ),
                                                            const SizedBox(height: 15),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [for (var i = 0; i < (size.width - 60) / 20; i++) Container(height: 1, width: 15, color: const Color(0xFFD9D9D9))],
                                                            ),
                                                            const SizedBox(height: 10),
                                                            invoiceSummry(label: 'Invoice No :', val: '#1234'),
                                                            invoiceSummry(label: 'Bill To :', val: order.shippingAddress.name),
                                                            invoiceSummry(label: 'Date :', val: formatDate3(order.createdAt)),
                                                            invoiceSummry(label: 'Address :', val: order.shippingAddress.getAddressString()),
                                                            const SizedBox(height: 10),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [for (var i = 0; i < (size.width - 60) / 20; i++) Container(height: 1, width: 15, color: const Color(0xFFD9D9D9))],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [for (var i = 0; i < (size.width - 60) / 20; i++) Container(height: 1, width: 15, color: const Color(0xFFD9D9D9))],
                                                            ),
                                                            const SizedBox(height: 10),
                                                            invoiceSummry(label: 'Total Amount :', val: '₹${order.calculateTotal()}'),
                                                            invoiceSummry(label: 'Shipping Cost :', val: order.calculateTotalShipping() > 0 ? '₹${order.calculateTotalShipping}' : 'Free'),
                                                            invoiceSummry(label: 'Tax :', val: '₹${order.calculateTotalTax()}'),
                                                            invoiceSummry(label: 'Grand Total :', val: '₹${order.grandTotal}'),
                                                            const SizedBox(height: 10),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          } else {
                                            Navigator.pop(context);
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) => Dialog(
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                                backgroundColor: Colors.white,
                                                elevation: 0,
                                                child: Container(
                                                  padding: const EdgeInsets.all(20.0),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(20.0),
                                                    color: Colors.white,
                                                    boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10.0, offset: Offset(0.0, 10.0))],
                                                  ),
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      const SizedBox(height: 10.0),
                                                      const Text('No Order found! for this transaction', style: TextStyle(fontSize: 16.0)),
                                                      const SizedBox(height: 20.0),
                                                      Align(
                                                          alignment: Alignment.center,
                                                          child:
                                                              TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('OK', style: TextStyle(color: Colors.blue, fontSize: 18.0)))),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                        });
                                      },
                                      padding: EdgeInsets.zero,
                                      child: transaction(i))
                                  : transaction(i)
                          ]),
                        )),
            ],
          ),
        ),
      ),
    );
  }

  Widget transaction(WalletTransaction item) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 7.5),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(item.heading(), textScaler: TextScaler.noScaling, style: orderHead1),
                                const SizedBox(height: 3),
                                Text(formatDatefromString2(item.createdAt), style: const TextStyle(color: Color(0xFF676767), fontSize: 10.50, fontFamily: 'Poppins', fontWeight: FontWeight.w400)),
                              ],
                            )),
                            if (item.type == 'Sell Return')
                              Text(
                                item.isCredit() ? item.credit.toString() : '${item.debit}',
                                textScaler: TextScaler.noScaling,
                                style: const TextStyle(color: Colors.black, fontSize: 13.37, fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                              )
                            else
                              Text(
                                item.isCredit() ? item.credit.toString() : '-${item.debit}',
                                textScaler: TextScaler.noScaling,
                                style: TextStyle(color: item.isCredit() ? const Color(0xFF2F9623) : const Color(0xFFDC3647), fontSize: 13.37, fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                              )
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(
                                child: Text('Ref No: ${item.refno}',
                                    textScaler: TextScaler.noScaling, style: const TextStyle(color: Color(0xFF308CEF), fontSize: 11, fontFamily: 'Poppins', fontWeight: FontWeight.w400))),
                            const SizedBox(width: 5),
                            if (item.type != 'Sell Return')
                              const SizedBox(width: 75)
                            else
                              SizedBox(width: 75, child: Text('Status: ${item.paymentstatus}', textScaler: TextScaler.noScaling, style: orderDateStyle2)),
                            Expanded(
                                child: Text('Type: ${item.type}',
                                    textScaler: TextScaler.noScaling,
                                    textAlign: TextAlign.end,
                                    style: const TextStyle(color: Color(0xFF308CEF), fontSize: 10, fontFamily: 'Poppins', fontWeight: FontWeight.w400)))
                          ],
                        )
                      ],
                    ),
                  ),
                  if (item.headType() == 0) const Icon(Icons.keyboard_arrow_right)
                ],
              ),
              const SizedBox(height: 10),
              userhorizontalLine2,
            ],
          ),
        ),
      ],
    );
  }
}
