// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:gogreen_lite/Allproviders/api_provider.dart';
import 'package:gogreen_lite/Allproviders/main_provider.dart';
import 'package:gogreen_lite/Allproviders/object.dart';
import 'package:gogreen_lite/extrafunctions.dart';
import 'package:provider/provider.dart';

final emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
bool emailvalid = true;
TextEditingController name = TextEditingController();
TextEditingController email = TextEditingController();

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  @override
  void initState() {
    final apiProvider = Provider.of<ApiProvider>(context, listen: false);
    UserDetails? user = apiProvider.userDetails;
    name = TextEditingController(text: user?.name ?? '');
    email = TextEditingController(text: user?.email ?? '');
    if ((user?.email ?? '').isNotEmpty && !emailRegExp.hasMatch(user?.email ?? '')) {
      setState(() {
        emailvalid = false;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<ApiProvider>(context);
    final mainProvider = Provider.of<MainProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          color: const Color(0xFF1A232E),
          child: apiProvider.userDetails != null
              ? Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 80),
                        const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Text('Take the first step towards an \nhealthier lifestyle!',
                                style: TextStyle(fontFamily: 'Poppins', color: Colors.white, fontSize: 20.21, fontWeight: FontWeight.w600))),
                        const SizedBox(height: 30),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text("Name", style: TextStyle(fontFamily: 'Poppins', color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500)),
                        ),
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            height: 46,
                            decoration: ShapeDecoration(shape: RoundedRectangleBorder(side: const BorderSide(width: 1, color: Color(0xFF22B573)), borderRadius: BorderRadius.circular(43.20))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: TextField(
                                controller: name,
                                style: const TextStyle(color: Color.fromARGB(255, 255, 254, 254)),
                                decoration: const InputDecoration(
                                  hintText: 'First name',
                                  hintStyle: TextStyle(color: Color.fromARGB(127, 255, 255, 255), fontSize: 13, fontWeight: FontWeight.w400),
                                  contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 6),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text("Email Address", style: TextStyle(fontFamily: 'Poppins', color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500)),
                        ),
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 46,
                                decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(side: BorderSide(width: 1, color: emailvalid ? const Color(0xFF22B573) : Colors.red), borderRadius: BorderRadius.circular(43.20))),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: TextField(
                                          controller: email,
                                          style: const TextStyle(color: Colors.white),
                                          keyboardType: TextInputType.emailAddress,
                                          onChanged: (val) {
                                            if (emailRegExp.hasMatch(val)) {
                                              setState(() => emailvalid = true);
                                            } else if (val.length > 3) {
                                              setState(() => emailvalid = false);
                                            }
                                          },
                                          decoration: const InputDecoration(
                                              hintText: 'Enter Your Email Address',
                                              hintStyle: TextStyle(color: Color.fromARGB(127, 255, 255, 255), fontSize: 13, fontWeight: FontWeight.w400),
                                              contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 7),
                                              border: InputBorder.none),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (!emailvalid) const Text('Provide a valid email ', style: TextStyle(color: Colors.red, fontSize: 11))
                            ],
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 50,
                      left: 0,
                      right: 0,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: apiProvider.updateUserPreload
                            ? const Padding(padding: EdgeInsets.symmetric(vertical: 25, horizontal: 25), child: Center(child: LinearProgressIndicator(color: Colors.green, minHeight: 1)))
                            : ElevatedButton(
                                onPressed: () async {
                                  FocusScope.of(context).unfocus();
                                  if (name.text.isNotEmpty && email.text.isNotEmpty) {
                                    if (!emailvalid || email.text.length < 3) {
                                      notification(Colors.red, 3, 'Provide valid email', context);
                                    } else {
                                      apiProvider.changeupdateUserPreload(true);
                                      apiProvider.updateuser2(name.text, email.text, mainProvider, context, 0);
                                    }
                                  } else {
                                    notification(Colors.red, 3, 'Fields Cant be empty', context);
                                  }
                                  mainProvider.notify();
                                },
                                style:
                                    ElevatedButton.styleFrom(backgroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(43.20)), fixedSize: const Size(355, 46)),
                                child: const Text('Continue', textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Poppins', color: Colors.black, fontWeight: FontWeight.w500)),
                              ),
                      ),
                    ),
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }
}
