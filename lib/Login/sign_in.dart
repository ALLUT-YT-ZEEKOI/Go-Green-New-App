import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import '../Allproviders/main_provider.dart';

const storage = FlutterSecureStorage();
bool newlogin = false;

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  void initState() {
    check();
    super.initState();
  }

  void check() async {
    if (await storage.read(key: 'new') == null) {
      setState(() {
        newlogin = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(width: double.infinity, height: double.infinity, child: Image.asset('assets/OBJECTS (1).png', fit: BoxFit.cover)),
            Positioned(
              top: 355,
              left: 38,
              child: Container(
                width: 131,
                height: 45.85,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(43.20)),
                  shadows: const [BoxShadow(color: Color(0xFF0BF36F), blurRadius: 27, offset: Offset(0, 2), spreadRadius: -6)],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Image.asset('assets/logo strt1 1 (1).png', width: 50, height: 50),
              ),
            ),
            Positioned(
              top: 400,
              left: 0,
              right: 0,
              child: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Text('An initiative for your   future',
                          textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Poppins', color: Colors.white, fontSize: 21.21, fontWeight: FontWeight.w600)),
                    ),
                    const SizedBox(height: 40),
                    // ElevatedButton(
                    //   onPressed: () {},
                    //   style: ElevatedButton.styleFrom(
                    //     backgroundColor: Colors.white,
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(43.20),
                    //     ),
                    //     fixedSize: const Size(355, 46),
                    //   ),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Image.asset('assets/google 1 (2).png', width: 30, height: 40),
                    //       const Text('Sign in with Google', textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Poppins', color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500)),
                    //       const SizedBox(width: 30),
                    //     ],
                    //   ),
                    // ),
                    // const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        mainProvider.loginIndex = 1;
                        mainProvider.notify();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(0, 255, 255, 255),
                          shape: RoundedRectangleBorder(side: const BorderSide(width: 1, color: Color(0xFF22B573)), borderRadius: BorderRadius.circular(43.20)),
                          fixedSize: const Size(355, 46)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(width: 30, child: Icon(Icons.phone_iphone_outlined, color: Color(0xFF22B573))),
                          Text(newlogin ? 'Get started with phone' : 'Login',
                              textScaler: TextScaler.noScaling,
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Color(0xFF22B573), fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
                          const SizedBox(width: 30),
                        ],
                      ),
                    ),
                    // SizedBox(height: 100),

                    // InkWell(
                    //   onTap: () {
                    //     mainProvider.homepageIndex = 5;
                    //     Navigator.pushReplacement(context, PageTransition(child: const MainHome(), type: PageTransitionType.fade));
                    //   },
                    //   child: Text('Skip For Now',
                    //       textAlign: TextAlign.center,
                    //       style: const TextStyle(
                    //           color: Color(0xFF22B573), fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w500, decoration: TextDecoration.underline, decorationColor: Color(0xFF22B573))),
                    // ),
                    // const SizedBox(width: 30),
                  ],
                ),
              ),
            ),
            Positioned(right: 0, left: 215, top: 415, child: Image.asset('assets/Healthier (1).png', width: 40, height: 40)),
            Positioned(right: 0, left: 160, top: 468, child: Image.asset('assets/Artboard 7 1.png', width: 40, height: 40)),
            const Positioned(
              left: 0,
              right: 0,
              bottom: 25,
              child: Column(
                children: [
                  Text('Made with ❤️ by gogreenocean.',
                      textScaler: TextScaler.noScaling, textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Poppins', color: Colors.white, fontSize: 13, fontWeight: FontWeight.w400)),
                  SizedBox(height: 10),
                  Text('Version 6(beta)',
                      textScaler: TextScaler.noScaling, textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 10, fontFamily: 'Poppins', fontWeight: FontWeight.w400)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
