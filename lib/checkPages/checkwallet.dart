// ignore_for_file: deprecated_member_use

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gogreen_lite/Allproviders/api_provider.dart';
import 'package:gogreen_lite/extraStyle.dart';
import 'package:gogreen_lite/extrafunctions.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

List<int> preamount = [100, 200, 500, 1000];
TextEditingController amount = TextEditingController();
int preCount = 0;

class CheckWallet extends StatefulWidget {
  const CheckWallet({super.key});

  @override
  State<CheckWallet> createState() => _CheckWalletState();
}

class _CheckWalletState extends State<CheckWallet> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  Future<void> playNotificationSound() async {
    await _audioPlayer.play(AssetSource('Coin.wav'));
  }

  void updateIndex(int index) {
    setState(() {
      preCount = index;
      amount = TextEditingController(text: preamount[index].toString());
    });
  }

  @override
  void initState() {
    updateIndex(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final apiProvider = Provider.of<ApiProvider>(context);
    void payment(double amount, String orderid, int walletid) {
      Razorpay razorpay = Razorpay();
      var options = {
        'key': apiProvider.razorpayKey,
        'amount': amount * 100,
        'name': 'GoGreen Ocean',
        'order_id': orderid,
        'retry': {'enabled': true, 'max_count': 1},
        'send_sms_hash': true,
        'prefill': {
          'contact': apiProvider.userDetails!.phone,
          'email': apiProvider.userDetails!.email
        },
      };
      razorpay.on(
          Razorpay.EVENT_PAYMENT_ERROR, (PaymentFailureResponse response) {});
      razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
          (PaymentSuccessResponse response) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) => WillPopScope(
                onWillPop: () async => false,
                child: const Center(
                  child: CircularProgressIndicator(),
                )));
        apiProvider.walletRecharge2(walletid.toString()).then((value) {
          apiProvider.walletRecharge2Suceess = value;
          apiProvider.notify();
          Navigator.of(context).pop();
          if (value) {
            playNotificationSound();
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) => WillPopScope(
                    onWillPop: () async => false,
                    child: Center(
                        child: Lottie.asset('assets/icons/vpSYXA65jy.json'))));
            facebookAppEvents.logPurchase(amount: amount, currency: 'inr');
            Future.delayed(const Duration(seconds: 3), () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            });
          } else {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) => WillPopScope(
                    onWillPop: () async => false,
                    child:
                        const Center(child: Text('Something Went Wrong !!'))));
            Future.delayed(const Duration(seconds: 3), () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            });
          }
        });
      });
      razorpay.open(options);
    }

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          toolbarHeight: 60,
          backgroundColor: const Color(0xFFF6F6F6),
          shadowColor: Colors.transparent,
          title:
              const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('Recharge',
                style: TextStyle(
                    color: Color(0xFF1D2730),
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500))
          ]),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            width: 1, color: const Color(0x191D2730)),
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Recharge Once', style: walletLabel),
                        const SizedBox(height: 5),
                        TextField(
                          style: walletValue,
                          controller: amount,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.currency_rupee),
                              prefixIconConstraints:
                                  BoxConstraints(minWidth: 20),
                              border: InputBorder.none),
                        ),
                        Container(height: 1, color: const Color(0x191D2730)),
                        const SizedBox(height: 15),
                        Wrap(
                          children: [
                            for (var i = 0; i < preamount.length; i++)
                              Container(
                                width: 60,
                                margin: const EdgeInsets.only(
                                    right: 10, bottom: 15),
                                height: 20,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.78,
                                        color: i == preCount
                                            ? const Color(0xFFFD995B)
                                            : const Color(0x111D2730)),
                                    borderRadius: BorderRadius.circular(36.51)),
                                child: MaterialButton(
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(36)),
                                    onPressed: () => updateIndex(i),
                                    child: Center(
                                        child: Text('₹${preamount[i]}',
                                            textScaler: TextScaler.noScaling,
                                            style: const TextStyle(
                                                color: Color(0xFF909090),
                                                fontSize: 10,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w500)))),
                              )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                bottom: 30,
                child: Container(
                  margin: const EdgeInsets.only(top: 100),
                  width: size.width - 30,
                  height: 50,
                  decoration: BoxDecoration(
                      color: const Color(0xFF2F9623),
                      borderRadius: BorderRadius.circular(43)),
                  child: MaterialButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) => WillPopScope(
                                onWillPop: () async => false,
                                child: const Center(
                                    child: CircularProgressIndicator())));

                        apiProvider.walletRegister(amount.text).then((value) {
                          Get.back();
                          if (value != null) {
                            payment(double.parse(amount.text), value.orderId,
                                value.id);
                          } else {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) => WillPopScope(
                                    onWillPop: () async => false,
                                    child: const Center(
                                        child:
                                            Text('Something Went Wrong !!'))));
                            Future.delayed(const Duration(seconds: 3),
                                () => Navigator.of(context).pop());
                          }
                        });
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(43)),
                      child: const Text('Add Money',
                          textScaler: TextScaler.noScaling,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500))),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
