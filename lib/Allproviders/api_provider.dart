// ignore_for_file: use_build_context_synchronously, deprecated_member_use, duplicate_ignore

import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gogreen_lite/Allproviders/main_provider.dart';
import 'package:gogreen_lite/Allproviders/object.dart';
import 'package:gogreen_lite/main_check.dart';
import 'package:gogreen_lite/main_home.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';

import '../extraFunctions.dart';

class ApiProvider extends ChangeNotifier {
  // static const String domain = 'https://gogreenocean.com/api/user';
  // static const String domain = 'http://192.168.1.8:8003/api/user';
  static const String domain = 'https://demo.gogreenocean.com/api/user';

  static const storage = FlutterSecureStorage();
  String razorpayKey = '';
  void putSecureStore(String key, String value) async =>
      await storage.write(key: key, value: value);
  int appversion = 0;
  bool islogin = false;

  late BuildContext providercontext;
  void setContext(BuildContext context) => providercontext = context;

  String loginNumber = '';
  bool optreload = false;
  void updateoptreload(bool val) {
    optreload = val;
    notifyListeners();
  }

  void notify() => notifyListeners();

// Login Section Start

  List<UserAddress> userAddress = [];
  UserDetails? userDetails;

  void sendOtp(String phone, int count) async {
    loginNumber = phone;
    notifyListeners();
    final url = Uri.parse('$domain/generateOtp');
    final body = {'phone': phone};
    try {
      await http.post(url, body: body);
    } on Exception catch (_) {
      if (count < 3) {
        sendOtp(phone, count + 1);
      }
    }
  }

  void resendOtp(int count) async {
    notifyListeners();
    final url = Uri.parse('$domain/resendOtp');
    final body = {'phone': loginNumber};
    try {
      await http.post(url, body: body);
    } on Exception catch (_) {
      if (count < 3) {
        resendOtp(count + 1);
      }
    }
  }

  void vertifyOtp(String otp, MainProvider provider, BuildContext context,
      int count) async {
    try {
      final url = Uri.parse('$domain/confirmCode');
      final body = {'phone': loginNumber, 'code': otp};
      final response = await http.post(url, body: body);
      var responseData = jsonDecode(response.body);
      if (responseData['success']) {
        islogin = true;
        putSecureStore('access_token', responseData['access_token']);
        sendFcm(0);
        razorpayKey = responseData['RAZOR_KEY'];
        userDetails = UserDetails.fromJson(responseData['user']);
        List<dynamic> jsonList = responseData['address'];
        userAddress = jsonList
            .map((jsonObject) => UserAddress.fromJson(jsonObject))
            .toList();
        loadMilk();
        reloadWallet(0);
        loadSubscription(0);
        getorders(more: false, count: 0);
        getorders(more: false, status: 'cancelled', count: 0);
        getorders(more: false, status: 'delivered', count: 0);
        if (responseData['user']['name'] == null ||
            responseData['user']['email'] == null) {
          putSecureStore('user_details', 'false');
          provider.loginIndex = 3;
          provider.notify();
        } else {
          putSecureStore('user_details', 'true');
          if (userAddress.isEmpty) {
            provider.loginIndex = 4;
            provider.notify();
          } else {
            provider.pageType = 0;
            provider.homepageIndex = 5;
            Navigator.pushReplacement(
                context,
                PageTransition(
                    child: const MainHome(), type: PageTransitionType.fade));
          }
        }
      } else {
        notification(Colors.red, 3, responseData['msg'], context);
      }
      optreload = false;
      notifyListeners();
    } on Exception catch (_) {
      if (count < 3) {
        vertifyOtp(otp, provider, context, count + 1);
      }
    }
  }

  void logout(BuildContext context, MainProvider provider) async {
    islogin = false;
    removeFcm(0);
    provider.deleteSavedAddress();
    provider.deleteAddress();
    await storage.write(key: 'new', value: '');
    await storage.delete(key: 'access_token');
    await storage.delete(key: 'user_details');
    userDetails = null;
    notifyListeners();
    Navigator.pushReplacement(
        context,
        PageTransition(
            child: const CheckPage(
              islogin: false,
              isuser: false,
            ),
            type: PageTransitionType.fade));
  }

  void sendFcm(int count) async {
    String? fcm = await FirebaseMessaging.instance.getToken();
    String? token = await storage.read(key: 'access_token');
    final headers = {'Authorization': 'Bearer $token'};
    final Map<String, String> queryParams = {'fcm': fcm ?? ''};
    final url =
        Uri.parse('$domain/fcm/store').replace(queryParameters: queryParams);
    try {
      await http.get(url, headers: headers);
    } on Exception catch (_) {
      if (count < 3) {
        sendFcm(count + 1);
      }
    }
  }

  void removeFcm(int count) async {
    String? token = await storage.read(key: 'access_token');
    final headers = {'Authorization': 'Bearer $token'};
    final url = Uri.parse('$domain/fcm/remove');
    try {
      await http.delete(url, headers: headers);
    } on Exception catch (_) {
      if (count < 3) {
        removeFcm(count + 1);
      }
    }
  }
  // Login Section End

  void getUserAddress(int count) async {
    try {
      final url = Uri.parse('$domain/address');
      String? token = await storage.read(key: 'access_token');
      final headers = {'Authorization': 'Bearer $token'};
      final response = await http.get(url, headers: headers);
      var responseData = jsonDecode(response.body);
      if (responseData['success']) {
        List<dynamic> jsonList = responseData['data'];
        userAddress = jsonList
            .map((jsonObject) => UserAddress.fromJson(jsonObject))
            .toList();
        notifyListeners();
      }
    } on Exception catch (_) {
      if (count < 3) {
        getUserAddress(count + 1);
      }
    }
  }

  void getUser(int count) async {
    try {
      final url = Uri.parse('$domain/details');
      String? token = await storage.read(key: 'access_token');
      final headers = {'Authorization': 'Bearer $token'};
      final response = await http.get(url, headers: headers);
      var responseData = jsonDecode(response.body);
      if (responseData['success']) {
        razorpayKey = responseData['RAZOR_KEY'];
        appversion = responseData['appversion'];
        userDetails = UserDetails.fromJson(responseData['user']);
        notifyListeners();
      }
      reloadWallet(0);
      sendFcm(0);
    } on Exception catch (_) {
      if (count < 3) {
        getUser(count + 1);
      }
    }
  }

  bool walletReload = false;

  void updatewalletReload(bool val) {
    walletReload = val;
    notifyListeners();
  }

  void reloadWallet(int count) async {
    final url = Uri.parse('$domain/wallet');
    String? token = await storage.read(key: 'access_token');
    final headers = {'Authorization': 'Bearer $token'};
    try {
      final response = await http.get(url, headers: headers);
      var responseData = jsonDecode(response.body);

      if (responseData['success']) {
        userDetails!.balance = responseData['balance'].toDouble() ?? 0.0;
      }
    } on Exception catch (_) {
      if (count < 3) {
        reloadWallet(count + 1);
      }
    }
    walletReload = false;
    notifyListeners();
  }

  void updateuser(String? name, String? email, int count) async {
    if (name != null) {
      userDetails!.name = name;
    }
    if (email != null) {
      userDetails!.email = email;
    }
    notifyListeners();
    final url = Uri.parse('$domain/updateUser');
    String? token = await storage.read(key: 'access_token');
    final headers = {'Authorization': 'Bearer $token'};
    putSecureStore('user_details', 'true');
    final body = {
      if (name != null) 'name': name,
      if (email != null) 'email': email
    };
    try {
      await http.post(url, body: body, headers: headers);
    } on Exception catch (_) {
      if (count < 3) {
        updateuser(name, email, count + 1);
      }
    }
  }

  bool updateUserPreload = false;
  void changeupdateUserPreload(bool val) {
    updateUserPreload = val;
    notifyListeners();
  }

  void updateuser2(String? name, String? email, MainProvider mainProvider,
      BuildContext context, int count) async {
    if (name != null) {
      userDetails!.name = name;
    }
    if (email != null) {
      userDetails!.email = email;
    }
    notifyListeners();
    final url = Uri.parse('$domain/updateUser');
    String? token = await storage.read(key: 'access_token');
    final headers = {'Authorization': 'Bearer $token'};

    final body = {
      if (name != null) 'name': name,
      if (email != null) 'email': email
    };
    try {
      var resposnse = await http.post(url, body: body, headers: headers);
      var responseData = jsonDecode(resposnse.body);
      if (responseData['success']) {
        putSecureStore('user_details', 'true');
        if (userAddress.isEmpty) {
          mainProvider.loginIndex = 4;
          mainProvider.notify();
        } else {
          mainProvider.pageType = 0;
          mainProvider.homepageIndex = 5;
          mainProvider.notify();
          Navigator.pushReplacement(
              context,
              PageTransition(
                  child: const MainHome(), type: PageTransitionType.fade));
        }
      } else {
        notification(Colors.red, 3, responseData['msg'], context);
      }
    } on Exception catch (_) {
      updateuser2(name, email, mainProvider, context, count + 1);
    }
    updateUserPreload = false;
    notifyListeners();
  }

  // void walletRecharge(String amount, String razorpayid, Map<dynamic, dynamic>? data) async {
  //   userDetails!.balance = userDetails!.balance + double.parse(amount);
  //   notifyListeners();
  //   final url = Uri.parse('$domain/walletRecharge');
  //   String? token = await storage.read(key: 'access_token');
  //   final headers = {'Authorization': 'Bearer $token'};
  //   final body = {'amount': amount, 'razorpay_id': razorpayid, 'data': jsonEncode(data)};

  //   int maxRetries = 3;
  //   for (int count = 0; count < maxRetries; count++) {
  //     try {
  //       await http.post(url, body: body, headers: headers);
  //       break;
  //     } catch (_) {}
  //   }
  // }

  bool walletRecharge2Suceess = false;
  Future<bool> walletRecharge2(String id) async {
    notifyListeners();
    final url = Uri.parse('$domain/walletRecharge');
    String? token = await storage.read(key: 'access_token');
    final headers = {'Authorization': 'Bearer $token'};
    final body = {'wallet_id': id};

    int maxRetries = 3;
    for (int count = 0; count < maxRetries; count++) {
      try {
        await http.post(url, body: body, headers: headers);
        return true;
      } catch (_) {}
    }
    return true;
  }

  Future<WalletRegister?> walletRegister(String amount) async {
    final url = Uri.parse('$domain/walletRequest');
    String? token = await storage.read(key: 'access_token');
    final headers = {'Authorization': 'Bearer $token'};
    final body = {'amount': amount};
    int maxRetries = 3;
    for (int count = 0; count < maxRetries; count++) {
      try {
        var resposnse = await http.post(url, body: body, headers: headers);
        var responseData = jsonDecode(resposnse.body);
        return WalletRegister.fromJson(responseData['data']);
      } catch (_) {}
    }
    return null;
  }

  bool addAddressReload = false;
  void updateaddAddressReload(bool val) {
    addAddressReload = val;
    notifyListeners();
  }

  bool intialPreload = false;
  void addAddress(int count,
      {required String address,
      String? addressline,
      double? longitude,
      double? latitude,
      String? landmark}) async {
    final url = Uri.parse('$domain/address/add');
    String? token = await storage.read(key: 'access_token');
    final headers = {'Authorization': 'Bearer $token'};
    final body = {
      'address': address,
      'addressline': addressline,
      'longitude': longitude.toString(),
      'latitude': latitude.toString(),
      'landmark': landmark
    };
    try {
      var response = await http.post(url, body: body, headers: headers);
      var responseData = jsonDecode(response.body);
      if (responseData['success']) {
        UserAddress address = UserAddress.fromJson(responseData['data']);
        userAddress.insert(0, address);
        notifyListeners();
      } else {
        notification(Colors.red, 3, responseData['msg'], providercontext);
      }
    } on Exception catch (_) {
      if (count < 3) {
        addAddress(count + 1,
            address: address,
            addressline: addressline,
            latitude: latitude,
            longitude: longitude,
            landmark: landmark);
      }
    }
    addAddressReload = false;
    notifyListeners();
  }

  void updateAddress(
      {required int id,
      required String address,
      String? addressline,
      double? longitude,
      double? latitude,
      String? landmark}) async {
    final url = Uri.parse('$domain/address/update');
    String? token = await storage.read(key: 'access_token');
    final headers = {'Authorization': 'Bearer $token'};
    final body = {
      'id': '$id',
      'address': address,
      'addressline': addressline,
      'longitude': longitude.toString(),
      'latitude': latitude.toString(),
      'landmark': landmark
    };
    var response = await http.post(url, body: body, headers: headers);
    var responseData = jsonDecode(response.body);
    if (responseData['success']) {
      UserAddress address = UserAddress.fromJson(responseData['data']);
      int index = userAddress.indexWhere((element) => element.id == address.id);
      if (index >= 0) {
        userAddress[index] = address;
      }
      notifyListeners();
    } else {
      notification(Colors.red, 3, responseData['msg'], providercontext);
    }
    addAddressReload = false;
    notifyListeners();
  }

  Future<UserAddress?> addAddresscheckout(
      {required String address,
      String? addressline,
      double? longitude,
      double? latitude,
      String? landmark}) async {
    try {
      final url = Uri.parse('$domain/address/add');
      String? token = await storage.read(key: 'access_token');
      final headers = {'Authorization': 'Bearer $token'};
      final body = {
        'address': address,
        'addressline': addressline,
        'longitude': longitude.toString(),
        'latitude': latitude.toString(),
        'landmark': landmark
      };
      var response = await http.post(url, body: body, headers: headers);
      var responseData = jsonDecode(response.body);
      if (responseData['success']) {
        UserAddress address = UserAddress.fromJson(responseData['data']);
        userAddress.insert(0, address);
        return address;
      } else {
        notification(Colors.red, 3, responseData['msg'], providercontext);
      }
    } on Exception catch (_) {
      addAddresscheckout(
          address: address,
          addressline: addressline,
          longitude: longitude,
          latitude: latitude,
          landmark: landmark);
    }
    return null;
  }

  void removeAddress(UserAddress address) async {
    userAddress.remove(address);
    notifyListeners();
    final url = Uri.parse('$domain/address/remove');
    String? token = await storage.read(key: 'access_token');
    final headers = {'Authorization': 'Bearer $token'};
    final body = {'id': address.id.toString()};
    await http.post(url, body: body, headers: headers);
  }

  // FOR MILK PRODUCTS

  List<SubProduct> milkProducts = [];

  void loadMilk() async {
    try {
      final Map<String, String> queryParams = {'key': 'milk'};
      final url = Uri.parse('$domain/subscription/products')
          .replace(queryParameters: queryParams);
      var response = await http.get(url);
      var responseData = jsonDecode(response.body);
      if (responseData['success']) {
        List<dynamic> jsonList = responseData['data'];
        milkProducts = jsonList
            .map((jsonObject) => SubProduct.fromJson(jsonObject))
            .toList();
        notifyListeners();
      }
    } on Exception catch (_) {
      loadMilk();
    }
  }

  void updateSubscriptionStatus(int status, Subscription item) async {
    item.status = status;
    if (status == 0) {
      item.updatenote = 'paused by you';
      item.updatedAt = DateTime.now().toString();
    }
    notifyListeners();
    final url = Uri.parse('$domain/subscription/updateStatus');
    String? token = await storage.read(key: 'access_token');
    final headers = {'Authorization': 'Bearer $token'};
    final body = {'id': item.id.toString(), 'status': status.toString()};
    await http.post(url, body: body, headers: headers);
  }

  void cancelSubscription(Subscription item) async {
    item.status = 0;
    item.approval = 0;
    item.updatenote = 'cancelled by you';
    item.updatedAt = DateTime.now().toString();
    notifyListeners();
    final url = Uri.parse('$domain/subscription/cancel');
    String? token = await storage.read(key: 'access_token');
    final headers = {'Authorization': 'Bearer $token'};
    final body = {'id': item.id.toString()};
    await http.post(url, body: body, headers: headers);
  }

  List<DateTime> skipped = [];
  Subscription? openSubscription;
  List<Subscription> mysubscription = [];
  int subsctiptiontab = 0;

  void loadSubscription(int count) async {
    try {
      String? token = await storage.read(key: 'access_token');
      final headers = {'Authorization': 'Bearer $token'};
      final url = Uri.parse('$domain/mySubscription');
      var response = await http.get(url, headers: headers);
      var responseData = jsonDecode(response.body);
      if (responseData['success']) {
        List<dynamic> jsonList = responseData['data'];
        mysubscription = jsonList
            .map((jsonObject) => Subscription.fromJson(jsonObject))
            .toList();
        intialPreload = false;
        notifyListeners();
      }
    } on Exception catch (_) {
      if (count < 3) {
        loadSubscription(count + 1);
      }
    }
  }

  void subscriptionSkip(int id, List<DateTime> skip) async {
    mysubscription.firstWhere((subscription) => subscription.id == id).skipped =
        skip;
    notifyListeners();
    String? token = await storage.read(key: 'access_token');
    final headers = {'Authorization': 'Bearer $token'};
    final url = Uri.parse('$domain/subscription/skip');
    final body = {
      'id': '$id',
      'skip':
          jsonEncode(skip.map((date) => formatDateWithoutTime(date)).toList()),
    };
    await http.post(url, headers: headers, body: body);
  }

  Future<bool> storeSubscription(int count,
      {required int pid,
      required int addressid,
      required int qty,
      required String start,
      required String type,
      List<CustomPatern>? weekdays,
      required String schedule,
      List<String>? instruction}) async {
    try {
      String? token = await storage.read(key: 'access_token');
      final headers = {'Authorization': 'Bearer $token'};
      final url = Uri.parse('$domain/subscription/store');
      final body = {
        if (appliedCoupon != null) 'coupon_id': '${appliedCoupon!.id}',
        'pid': '$pid',
        'address_id': '$addressid',
        'qty': '$qty',
        'start': start,
        'type': type,
        'weekdays': weekdays == null
            ? '[]'
            : jsonEncode(weekdays.map((e) => e.toJson()).toList()),
        'schedule': schedule,
        'instruction': instruction == null ? "[]" : jsonEncode(instruction)
      };

      var response = await http.post(url, headers: headers, body: body);
      var responseData = jsonDecode(response.body);

      if (responseData['success']) {
        Subscription data = Subscription.fromJson(responseData['data']);
        mysubscription.insert(0, data);
        return true;
      } else {
        return false;
      }
    } on Exception catch (_) {
      if (count > 3) {
        return false;
      }
      storeSubscription(count++,
          pid: pid,
          addressid: addressid,
          qty: qty,
          start: start,
          type: type,
          weekdays: weekdays,
          schedule: schedule,
          instruction: instruction);
    }
    return false;
  }

  bool isSampleCheckout = false;

  Future<bool> sampleOrder(
    int count, {
    required int pid,
    required int addressid,
    required String schedule,
    List<String>? instruction,
    required String start,
  }) async {
    try {
      String? token = await storage.read(key: 'access_token');
      final headers = {'Authorization': 'Bearer $token'};
      final url = Uri.parse('$domain/createSampleOrder');
      final body = {
        'product_id': '$pid',
        'address_id': '$addressid',
        'start': start,
        'schedule': schedule,
        'instruction': instruction == null ? "[]" : jsonEncode(instruction)
      };
      var response = await http.post(url, headers: headers, body: body);
      var responseData = jsonDecode(response.body);
      if (responseData['success'] == 1) {
        Order data = Order.fromJson(responseData['data']);
        allOrders.insert(0, data);
        userDetails!.enablesample = 0;
        isSampleCheckout = false;
        return true;
      } else {
        return false;
      }
    } on Exception catch (_) {
      if (count <= 3) {
        return await sampleOrder(count + 1,
            pid: pid,
            addressid: addressid,
            schedule: schedule,
            instruction: instruction,
            start: start);
      }
      return false;
    }
  }

// fetch orders
  bool orderPreload = false;
  void updateorderPreload(bool val) {
    orderPreload = val;
    notifyListeners();
  }

  bool moreOrderPreload = false;
  void updateMoreOrderPreload(bool val) {
    moreOrderPreload = val;
    notifyListeners();
  }

  List<Order> allOrders = [];
  int allOrderscurrentpage = 1;
  int allordersfinalpage = 1;
  List<Order> allDeliverd = [];
  int allDeliverdcurrentpage = 1;
  int allDeliverdfinalpage = 1;
  List<Order> allCancelled = [];
  int allCancelledcurrentpage = 1;
  int allCancelledfinalpage = 1;
  int getcurentpage(String? val) {
    if (val != null) {
      return val == 'cancelled'
          ? allCancelledcurrentpage
          : allDeliverdcurrentpage;
    }
    return allOrderscurrentpage;
  }

  void getorders(
      {required bool more, String? status, required int count}) async {
    String? token = await storage.read(key: 'access_token');
    final headers = {'Authorization': 'Bearer $token'};
    Map<String, dynamic> queryParams = {};
    if (more) {
      queryParams = {
        'page': (getcurentpage(status) + 1),
        if (status != null) 'status': status
      };
    } else {
      queryParams = {'page': '1', if (status != null) 'status': status};
    }

    final dio = Dio();
    dio.options.headers = headers;

    try {
      var response =
          await dio.get('$domain/orders', queryParameters: queryParams);
      var responseData = response.data;
      if (responseData['success']) {
        List<dynamic> jsonList = responseData['data']['data'];
        List<Order> list = jsonList.map((e) => Order.fromJson(e)).toList();
        if (status == null) {
          allOrderscurrentpage = responseData['data']['current_page'];
          allordersfinalpage = responseData['data']['last_page'];
          if (more) {
            allOrders = [...allOrders, ...list];
          } else {
            allOrders = list;
          }
        } else if (status == 'cancelled') {
          allCancelledcurrentpage = responseData['data']['current_page'];
          allCancelledfinalpage = responseData['data']['last_page'];
          if (more) {
            allCancelled = [...allCancelled, ...list];
          } else {
            allCancelled = list;
          }
        } else if (status == 'delivered') {
          allDeliverdcurrentpage = responseData['data']['current_page'];
          allDeliverdfinalpage = responseData['data']['last_page'];
          if (more) {
            allDeliverd = [...allDeliverd, ...list];
          } else {
            allDeliverd = list;
          }
        }
        orderPreload = false;
        moreOrderPreload = false;
        notifyListeners();
      }
    } catch (e) {
      if (count < 3) {
        getorders(more: more, status: status, count: count + 1);
      }
    }
  }

  // void getorders({required bool more, String? status}) async {
  //   String? token = await storage.read(key: 'access_token');
  //   final headers = {'Authorization': 'Bearer $token'};
  //   Map<String, String> queryParams = {};
  //   if (more) {
  //     queryParams = {'page': (getcurentpage(status) + 1).toString(), if (status != null) 'status': status};
  //   } else {
  //     queryParams = {'page': '1', if (status != null) 'status': status};
  //   }
  //   final url = Uri.parse('$domain/orders').replace(queryParameters: queryParams);
  //   var response = await http.get(url, headers: headers);
  //   var responseData = jsonDecode(response.body);
  //   if (responseData['success']) {
  //     List<dynamic> jsonList = responseData['data']['data'];
  //     List<Order> list = jsonList.map((e) => Order.fromJson(e)).toList();
  //     if (status == null) {
  //       allOrderscurrentpage = responseData['data']['current_page'];
  //       allordersfinalpage = responseData['data']['last_page'];
  //       if (more) {
  //         allOrders = [...allOrders, ...list];
  //       } else {
  //         allOrders = list;
  //       }
  //     } else if (status == 'cancelled') {
  //       allCancelledcurrentpage = responseData['data']['current_page'];
  //       allCancelledfinalpage = responseData['data']['last_page'];
  //       if (more) {
  //         allCancelled = [...allCancelled, ...list];
  //       } else {
  //         allCancelled = list;
  //       }
  //     } else if (status == 'delivered') {
  //       allDeliverdcurrentpage = responseData['data']['current_page'];
  //       allDeliverdfinalpage = responseData['data']['last_page'];
  //       if (more) {
  //         allDeliverd = [...allDeliverd, ...list];
  //       } else {
  //         allDeliverd = list;
  //       }
  //     }
  //     orderPreload = false;
  //     moreOrderPreload = false;
  //     notifyListeners();
  //   }
  // }

  int orderOpenPreload = 0; //0-no,1-preload,2-something went wrong
  void updateorderOpenPreload(int val) {
    orderOpenPreload = val;
    notifyListeners();
  }

  OrderOpenDetails? currentorder;
  void openOrder(int id, int count) async {
    String? token = await storage.read(key: 'access_token');
    final headers = {'Authorization': 'Bearer $token'};
    Map<String, String> queryParams = {'id': '$id'};
    try {
      final url =
          Uri.parse('$domain/openOrder').replace(queryParameters: queryParams);
      var response = await http.get(url, headers: headers);
      var responseData = jsonDecode(response.body);
      if (responseData['success']) {
        currentorder = OrderOpenDetails.fromJson(responseData['data']);
        orderOpenPreload = 0;
      } else {
        orderOpenPreload = 2;
      }
    } on Exception catch (_) {
      if (count < 3) {
        openOrder(id, count + 1);
      } else {
        orderOpenPreload = 2;
      }
    }
    notifyListeners();
  }

// order hhistory section
  int ordertab = 0;
  void updateOrdertab(int v) {
    ordertab = v;
    notifyListeners();
  }

  double walletDue = 0;
  List<WalletTransaction> walletTransactions = [];
  // Map<String, List<WalletTransaction>> groupedTransactions = {};
  // int trasactionCurrentpage = 1;
  // int trasactionFinalpage = 1;
  bool trasactionreload = false;
  // bool trasnsactionmorereload = false;
  void updateTrasactionreload(bool val) {
    trasactionreload = val;
    notifyListeners();
  }

  // void updateTrasactionMorereload(bool val) {
  //   trasnsactionmorereload = val;
  //   notifyListeners();
  // }

  // void getTransaction(int sort) async {
  //   String start = getStartDate(sort);
  //   String end = getEndDate(sort);
  //   String? token = await storage.read(key: 'access_token');
  //   final headers = {'Authorization': 'Bearer $token'};
  //   Map<String, String> queryParams = {'start': start, 'end': end};
  //   final url = Uri.parse('$domain/Transactions').replace(queryParameters: queryParams);
  //   var response = await http.get(url, headers: headers);
  //   var responseData = jsonDecode(response.body);
  //   if (responseData['success']) {
  //     List<dynamic> jsonList = responseData['data']['ledger'];
  //     if (jsonList.isNotEmpty) {
  //       jsonList.removeAt(0);
  //     }
  //     walletDue = responseData['data']['balance_due'];
  //     List<WalletTransaction> items = jsonList.map((e) => WalletTransaction.fromJson(e)).toList();

  //     walletTransactions = items;
  //     // groupedTransactions.clear();
  //     // for (var transaction in walletTransactions) {
  //     //   String dateKey = transaction.getFormattedDate();
  //     //   if (!groupedTransactions.containsKey(dateKey)) {
  //     //     groupedTransactions[dateKey] = [];
  //     //   }
  //     //   groupedTransactions[dateKey]!.add(transaction);
  //     // }
  //     trasactionreload = false;
  //     // trasnsactionmorereload = false;
  //     notifyListeners();
  //   }
  // }
  Future<double> checkdue() async {
    String start = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String end = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String? token = await storage.read(key: 'access_token');
    final headers = {'Authorization': 'Bearer $token'};
    Map<String, dynamic> queryParams = {'start': start, 'end': end};
    final dio = Dio();
    dio.options.headers = headers;
    try {
      final url = Uri.parse('$domain/Transactions')
          .replace(queryParameters: queryParams);
      var response = await http.get(url, headers: headers);
      var responseData = jsonDecode(response.body);
      if (responseData['success']) {
        List<dynamic> jsonList = responseData['data']['ledger'];
        if (jsonList.isNotEmpty) {
          jsonList.removeAt(0);
        }
        return double.parse(responseData['data']['balance_due'].toString());
      }
      return 0;
    } catch (e) {
      return 0;
    }
  }

  void getTransaction(int sort, int count) async {
    String start = getStartDate(sort);
    String end = getEndDate(sort);
    String? token = await storage.read(key: 'access_token');
    final headers = {'Authorization': 'Bearer $token'};
    Map<String, dynamic> queryParams = {'start': start, 'end': end};
    final dio = Dio();
    dio.options.headers = headers;
    try {
      final url = Uri.parse('$domain/Transactions')
          .replace(queryParameters: queryParams);
      var response = await http.get(url, headers: headers);
      var responseData = jsonDecode(response.body);
      if (responseData['success']) {
        List<dynamic> jsonList = responseData['data']['ledger'];
        if (jsonList.isNotEmpty) {
          jsonList.removeAt(0);
        }
        walletDue =
            double.parse(responseData['data']['balance_due'].toString());
        List<WalletTransaction> items =
            jsonList.map((e) => WalletTransaction.fromJson(e)).toList();
        walletTransactions = items;
        trasactionreload = false;
        notifyListeners();
      }
    } catch (e) {
      if (count < 3) {
        getTransaction(sort, count++);
      }
    }
  }

  List<Feed> benefits = [];
  int benefitsCurrentpage = 1;
  int benefitsFinalpage = 1;
  bool benefitsreload = false;
  bool benefitsmorereload = false;
  void updatebenefitsreload(bool val) {
    benefitsreload = val;
    notifyListeners();
  }

  void updatebenefitsMorereload(bool val) {
    benefitsmorereload = val;
    notifyListeners();
  }

  void getBenefits(bool more, int count) async {
    try {
      Map<String, String> queryParams = {};
      if (more) {
        queryParams = {'page': (benefitsCurrentpage + 1).toString()};
      }
      final url =
          Uri.parse('$domain/benefits').replace(queryParameters: queryParams);
      var response = await http.get(url);
      var responseData = jsonDecode(response.body);
      if (responseData['success']) {
        benefitsCurrentpage = responseData['data']['current_page'];
        benefitsFinalpage = responseData['data']['last_page'];
        List<dynamic> jsonList = responseData['data']['data'];
        List<Feed> items = jsonList.map((e) => Feed.fromJson(e)).toList();
        if (more) {
          benefits = [...benefits, ...items];
        } else {
          benefits = items;
        }
        benefitsreload = false;
        benefitsmorereload = false;
        notifyListeners();
      }
    } on Exception catch (_) {
      if (count < 3) {
        getBenefits(more, count + 1);
      }
    }
  }

// new updates
  Future<OrderOpenDetails?> openTranscationOrder(int posID, int count) async {
    Dio dio = Dio();
    String? token = await storage.read(key: 'access_token');
    final headers = {'Authorization': 'Bearer $token'};
    Map<String, dynamic> queryParams = {'id': posID};
    try {
      Response response = await dio.get('$domain/loadOrder',
          queryParameters: queryParams, options: Options(headers: headers));
      var responseData = response.data;
      if (responseData['success'] && responseData['data'] != null) {
        OrderOpenDetails data = OrderOpenDetails.fromJson(responseData['data']);
        return data;
      }
    } catch (e) {
      if (count < 3) {
        openTranscationOrder(posID, count++);
      } else {
        return null;
      }
    }
    return null;
  }

// coupon api
  void intalizeCouponVar() {
    couponreload = false;
    couponreadonly = false;
    appliedCoupon = null;
    couponlist = [];
    notifyListeners();
  }

  bool couponreload = false;
  bool couponreadonly = false;
  Coupon? appliedCoupon;
  List<Coupon> couponlist = [];

  Future<List<Coupon>> getCoupons() async {
    String? token = await storage.read(key: 'access_token');
    final headers = {'Authorization': 'Bearer $token'};
    final url = Uri.parse('$domain/coupon/get');
    int retries = 0;
    while (retries < 3) {
      try {
        var response = await http.get(url, headers: headers);
        var responseData = jsonDecode(response.body);

        if (responseData['success']) {
          List<dynamic> jsonList = responseData['data'];

          List<Coupon> list = jsonList.map((e) => Coupon.fromJson(e)).toList();
          return list;
        } else {
          break;
        }
      } catch (e) {
        retries++;
        if (retries >= 3) {
          break;
        }
      }
    }
    return [];
  }

  bool couponChecking = false;

  Future<Map<String, dynamic>> subCheckCoupon({
    required String code,
    SubProduct? product,
    int qt = 0,
  }) async {
    String? token = await storage.read(key: 'access_token');
    final headers = {'Authorization': 'Bearer $token'};
    final queryParams = {'code': code};
    final url =
        Uri.parse('$domain/coupon/check').replace(queryParameters: queryParams);
    int retries = 0;

    while (retries < 3) {
      try {
        final response = await http.get(url, headers: headers);
        final responseData = jsonDecode(response.body);

        if (responseData['success']) {
          final data = responseData['data'];

          if (data['multisub'] == 0 && data['applied_subscription_count'] > 0) {
            return {
              'status': false,
              'msg': 'Not Applicable with Multiple Subscriptions'
            };
          }

          if (data['type'] == 'subscription') {
            final details = jsonDecode(data['details']);

            if (product != null &&
                int.parse(details['product_id']) == product.id) {
              appliedCoupon = Coupon.fromJson(data);
              return {'status': true};
            }
            return {
              'status': false,
              'msg': 'Coupon is not valid for this product'
            };
          }

          appliedCoupon = Coupon.fromJson(data);
          return {'status': true};
        } else {
          return {'status': false, 'msg': 'No coupon found'};
        }
      } catch (e) {
        retries++;
        if (retries >= 3) {
          return {'status': false, 'msg': 'Something Went Wrong'};
        }
      }
    }

    return {'status': false, 'msg': 'Something Went Wrong'};
  }

// for update notification
  Future<String?> showUpdate() {
    final Size size = MediaQuery.of(providercontext).size;
    return showDialog<String>(
      barrierDismissible: false,
      // barrierColor: Colors.transparent,
      context: providercontext,
      builder: (BuildContext context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: AlertDialog(
            elevation: 0,
            titlePadding: EdgeInsets.zero,
            insetPadding: const EdgeInsets.all(17),
            backgroundColor: Colors.transparent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            contentPadding: EdgeInsets.zero,
            content: Container(
              width: size.width,
              height: size.height,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.transparent),
              child: Center(
                child: SizedBox(
                  width: 360,
                  height: 500,
                  child: InkWell(
                    // ignore: deprecated_member_use
                    onTap: () => launch(
                        'https://play.google.com/store/apps/details?id=com.zeekoi.gogreen_lite'),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 75,
                          left: 13.5,
                          child: Container(
                            width: 325,
                            padding: const EdgeInsets.all(30),
                            color: Colors.white,
                            height: 350,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Dear User',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black)),
                                  const SizedBox(height: 5),
                                  const Text(
                                      'For more features and a btter experience , please update this app',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black)),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton(
                                          onPressed: () {},
                                          style: TextButton.styleFrom(
                                              padding: EdgeInsets.zero),
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: Colors.green),
                                              height: 30,
                                              width: 90,
                                              child: const Center(
                                                  child: Text('Update',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color:
                                                              Colors.white))))),
                                    ],
                                  )
                                ]),
                          ),
                        ),
                        Positioned(
                            left: 0,
                            right: 0,
                            child: Image.asset(
                                width: 360,
                                'assets/update.png',
                                fit: BoxFit.fill)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
