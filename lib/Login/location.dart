import 'package:flutter/material.dart';
import 'package:gogreen_lite/Allproviders/main_provider.dart';
import 'package:gogreen_lite/main_home.dart';
import 'package:provider/provider.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Column(
          children: [
            const SizedBox(height: 150),
            const Row(
              children: [
                SizedBox(width: 18),
                Text('What’s your location?', style: TextStyle(fontFamily: 'Poppins', color: Colors.black, fontSize: 20.21, fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 5),
            const Row(
              children: [
                SizedBox(width: 18),
                Expanded(
                  child: Text('We need your location to show available products from farmers near you.',
                      style: TextStyle(color: Color(0xFF626363), fontSize: 15, fontFamily: 'Poppins', fontWeight: FontWeight.w400)),
                )
              ],
            ),
            const SizedBox(height: 50),
            Image.asset('assets/locatn 1 (2).png', width: 350, height: 350),
            const SizedBox(height: 80),
            ElevatedButton(
              onPressed: () {
                mainProvider.innerpageIndex = 2;
                mainProvider.pageType = 1;
                mainProvider.homepageIndex = 5;
                mainProvider.notify();

                Navigator.pushReplacementNamed(context, MainHome.route);
              },
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2F9623), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(43.20)), fixedSize: const Size(355, 46)),
              child: const Row(
                children: [
                  SizedBox(width: 80),
                  Text('Allow location access', textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Poppins', color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
                onTap: () {
                  mainProvider.homepageIndex = 5;
                  mainProvider.notify();
                  Navigator.pushReplacementNamed(context, MainHome.route);
                },
                child: const Text('Enter Location Manually', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF2F9623), fontSize: 16, fontFamily: 'Roboto', fontWeight: FontWeight.w500)))
          ],
        ),
      )),
    );
  }
}
