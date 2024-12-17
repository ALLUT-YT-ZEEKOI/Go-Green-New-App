// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gogreen_lite/Allproviders/api_provider.dart';
import 'package:gogreen_lite/Allproviders/main_provider.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

int secondsRemaining = 58;
late Timer timer;
String otp = '';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  void initState() {
    restartTimer();
    super.initState();
  }

  void restartTimer() {
    setState(() {
      secondsRemaining = 58;
      startTimer();
    });
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (secondsRemaining > 0) {
          secondsRemaining--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final mainProvider = Provider.of<MainProvider>(context);
    final apiProvider = Provider.of<ApiProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        mainProvider.loginIndex = 1;
        mainProvider.notify();
        return false;
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          color: const Color(0xFF1A232E),
          child: Stack(
            children: [
              Positioned(
                  top: 65,
                  right: 18,
                  child: InkWell(
                      onTap: () {
                        mainProvider.loginIndex = 1;
                        mainProvider.notify();
                      },
                      child: Image.asset('assets/mingcute_close-line.png',
                          height: 35))),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const SizedBox(height: 150),
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    child: Text('Verify your number',
                        textScaler: TextScaler.noScaling,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 20.21,
                            fontWeight: FontWeight.w600))),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Text(
                      'Enter OTP received on +91  ${apiProvider.loginNumber}',
                      textScaler: TextScaler.noScaling,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500)),
                ),
                SizedBox(height: size.height * 0.05),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  child: Text('ENTER THE 4 DIGIT OTP',
                      textScaler: TextScaler.noScaling,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500)),
                ),
                Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    child: PinCodeTextField(
                      appContext: context,
                      length: 4,
                      onChanged: (value) => setState(() => otp = value),
                      cursorHeight: 19,
                      onCompleted: (value) {
                        apiProvider.updateoptreload(true);
                        apiProvider.vertifyOtp(value, mainProvider, context, 0);
                      },
                      keyboardType: TextInputType.number,
                      textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: Colors.white),
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        fieldWidth: 48,
                        fieldHeight: 50,
                        inactiveColor: Colors.grey,
                        selectedColor: const Color.fromARGB(255, 255, 255, 255),
                        activeFillColor:
                            const Color.fromARGB(255, 247, 248, 248),
                        selectedFillColor:
                            const Color.fromARGB(255, 255, 255, 255),
                        inactiveFillColor: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 18),
                  child: secondsRemaining > 0
                      ? Text('Resend in $secondsRemaining Seconds',
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500))
                      : Container(
                          height: 23,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF6F1),
                            border: Border.all(
                                width: 1, color: Colors.grey.shade100),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: MaterialButton(
                              onPressed: () {
                                apiProvider.resendOtp(0);
                                restartTimer();
                              },
                              child: const Text('Resend',
                                  textScaler: TextScaler.noScaling,
                                  style: TextStyle(
                                      color: Color(0xFF1A232E),
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500)))),
                ),
              ]),
              Positioned(
                bottom: 25,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    apiProvider.optreload
                        ? const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 25, horizontal: 25),
                            child: Center(
                                child: LinearProgressIndicator(
                                    color: Colors.green, minHeight: 1)))
                        : ElevatedButton(
                            onPressed: () {
                              if (otp.length == 4) {
                                apiProvider.updateoptreload(true);
                                apiProvider.vertifyOtp(
                                    otp, mainProvider, context, 0);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(43.20)),
                                fixedSize: const Size(355, 46)),
                            child: const Text('Verify',
                                textScaler: TextScaler.noScaling,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500)),
                          ),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        launch('https://gogreenocean.com/terms');
                      },
                      child: const Text(
                          'By verifying OTP, you agree to our Terms & Conditions',
                          textScaler: TextScaler.noScaling,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400)),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
