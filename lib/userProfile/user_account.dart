import 'package:flutter/material.dart';
import 'package:gogreen_lite/Allproviders/api_provider.dart';
import 'package:gogreen_lite/Allproviders/main_provider.dart';
import 'package:gogreen_lite/Allproviders/object.dart';
import 'package:gogreen_lite/extraStyle.dart';
import 'package:provider/provider.dart';
import '../extraFunctions.dart';
import '../extrawidgets.dart';

final emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
bool emailvalid = false;
TextEditingController name = TextEditingController();
TextEditingController email = TextEditingController();
FocusNode nameF = FocusNode();
FocusNode numF = FocusNode();
FocusNode emailF = FocusNode();

class UserAccount extends StatefulWidget {
  const UserAccount({super.key});

  @override
  State<UserAccount> createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {
  @override
  void initState() {
    final apiProvider = Provider.of<ApiProvider>(context, listen: false);
    name = TextEditingController(text: apiProvider.userDetails!.name);
    email = TextEditingController(text: apiProvider.userDetails!.email);
    if (emailRegExp.hasMatch(apiProvider.userDetails?.email ?? '')) {
      setState(() {
        emailvalid = true;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final mainProvider = Provider.of<MainProvider>(context);
    final apiProvider = Provider.of<ApiProvider>(context);
    final UserDetails? userDetails = apiProvider.userDetails;
    return Container(
      color: const Color(0xFFF6F6F6),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: size.width,
      height: size.height,
      child: userDetails == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                            const Text('Name', style: profileLabel),
                            const SizedBox(height: 15),
                            SizedBox(
                                width: size.width - 90,
                                height: 15,
                                child: TextField(
                                    controller: name, focusNode: nameF, style: profileFont, readOnly: mainProvider.usernameEdit, decoration: const InputDecoration(border: InputBorder.none))),
                          ]),
                          InkWell(
                              onTap: () {
                                if (!mainProvider.usernameEdit) {
                                  if (name.text.isEmpty) {
                                    notification(Colors.red, 3, "Name cant't be empty", context);
                                  } else {
                                    mainProvider.toggleusernameEdit();
                                    apiProvider.userDetails!.name = name.text;
                                    apiProvider.notify();
                                    apiProvider.updateuser(name.text, null, 0);
                                  }
                                } else {
                                  mainProvider.toggleusernameEdit();
                                  focusAndSelectLastLetter(controller: name, focusNode: nameF, context: context);
                                }
                              },
                              child: mainProvider.usernameEdit ? Image.asset('assets/icons/edit-pen.png', height: 30, color: Colors.black) : const Icon(Icons.done))
                        ]),
                      ),
                      userhorizontalLine2,
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [const Text('Phone Number', style: profileLabel), const SizedBox(height: 12), SizedBox(width: 300, child: Text(userDetails.phone, style: profileFont))]),
                        ]),
                      ),
                      userhorizontalLine2,
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                            Text('Email Address', style: TextStyle(color: emailvalid ? const Color(0xFF909090) : Colors.red, fontSize: 10, fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
                            const SizedBox(height: 15),
                            SizedBox(
                                width: size.width - 90,
                                height: 15,
                                child: TextField(
                                    controller: email,
                                    focusNode: emailF,
                                    onChanged: (val) {
                                      if (emailRegExp.hasMatch(val)) {
                                        setState(() {
                                          emailvalid = true;
                                        });
                                      } else {
                                        setState(() {
                                          emailvalid = false;
                                        });
                                      }
                                    },
                                    style: TextStyle(color: emailvalid ? const Color(0xFF1D2730) : Colors.red, fontSize: 15, fontFamily: 'Poppins', fontWeight: FontWeight.w500),
                                    readOnly: mainProvider.useremailEdit,
                                    decoration: const InputDecoration(border: InputBorder.none)))
                          ]),
                          InkWell(
                              onTap: () {
                                if (!mainProvider.useremailEdit) {
                                  if (email.text.isEmpty) {
                                    notification(Colors.red, 3, "Email cant't be empty", context);
                                  } else {
                                    if (emailvalid) {
                                      mainProvider.toggleuseremailEdit();
                                      apiProvider.userDetails!.email = email.text;
                                      apiProvider.notify();
                                      apiProvider.updateuser(null, email.text, 0);
                                    } else {
                                      notification(Colors.red, 3, "Enter a valid email id", context);
                                    }
                                  }
                                } else {
                                  mainProvider.toggleuseremailEdit();
                                  focusAndSelectLastLetter(controller: email, focusNode: emailF, context: context);
                                }
                              },
                              child: mainProvider.useremailEdit ? Image.asset('assets/icons/edit-pen.png', height: 30, color: Colors.black) : const Icon(Icons.done))
                        ]),
                      ),
                      userhorizontalLine2,
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        onTap: () {
                          mainProvider.useremailEdit = true;
                          mainProvider.useremailEdit = true;
                          mainProvider.menuFirst = 0;
                          mainProvider.menupagetype = 1;
                          mainProvider.notify();
                        },
                        leading: Image.asset('assets/icons/location2.png', height: 30),
                        title: const Text('Saved Addresses', style: profileFont),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 15),
                      ),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
