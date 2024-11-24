import 'package:flutter/material.dart';
import 'package:gogreen_lite/Allproviders/api_provider.dart';
import 'package:gogreen_lite/extrafunctions.dart';
import 'package:provider/provider.dart';
import '../Allproviders/main_provider.dart';

class SigninWithPhone extends StatefulWidget {
  const SigninWithPhone({super.key});
  @override
  State<SigninWithPhone> createState() => _SigninWithPhoneState();
}

class _SigninWithPhoneState extends State<SigninWithPhone> {
  TextEditingController phone = TextEditingController(text: '');
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);
    final apiProvider = Provider.of<ApiProvider>(context);
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        mainProvider.loginIndex = 0;
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
                        mainProvider.loginIndex = 0;
                        mainProvider.notify();
                      },
                      child: Image.asset('assets/mingcute_close-line.png', height: 35))),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const SizedBox(height: 150),
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    child: Text('Enter you phone number to countinue',
                        textScaler: TextScaler.noScaling, textAlign: TextAlign.start, style: TextStyle(fontFamily: 'Poppins', color: Colors.white, fontSize: 21.21, fontWeight: FontWeight.w600))),
                const SizedBox(height: 50),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  child: Text('Phone Number', textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Poppins', color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500)),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      width: 365,
                      height: 46,
                      decoration: ShapeDecoration(shape: RoundedRectangleBorder(side: const BorderSide(width: 1, color: Color(0xFF22B573)), borderRadius: BorderRadius.circular(43.20))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            const Text('+91', style: TextStyle(color: Color(0xFF22B573), fontSize: 17)),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextField(
                                controller: phone,
                                maxLength: 10,
                                keyboardType: TextInputType.phone,
                                style: const TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                  counter: Offstage(),
                                  hintText: 'Enter phone number',
                                  hintStyle: TextStyle(color: Color.fromARGB(127, 255, 255, 255), fontSize: 13, fontWeight: FontWeight.w400),
                                  contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 6),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
              ]),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () {
                      if (phone.text.length == 10) {
                        apiProvider.updateoptreload(false);
                        apiProvider.sendOtp(phone.text, 0);
                        mainProvider.loginIndex = 2;
                        mainProvider.notify();
                      } else {
                        notification(Colors.red, 3, 'invalid Phone Number', context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(43.20)),
                      fixedSize: const Size(355, 46),
                    ),
                    child: const Text('Get OTP ', textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Poppins', color: Colors.black, fontWeight: FontWeight.w500)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
