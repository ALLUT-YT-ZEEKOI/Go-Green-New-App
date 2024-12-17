// ignore_for_file: file_names, use_build_context_synchronously, deprecated_member_use

import 'dart:async';
import 'dart:io';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:gogreen_lite/Allproviders/object.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;

final facebookAppEvents = FacebookAppEvents();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
int findIndexByKeyInCustomPatern(List<CustomPatern> patterns, String targetKey) {
  return patterns.indexWhere((pattern) => pattern.label == targetKey);
}

String formatDate(DateTime dateTime) {
  final String month = DateFormat('MMM').format(dateTime);
  final String day = DateFormat('dd').format(dateTime);
  final String year = DateFormat('yyyy').format(dateTime);
  return '$day $month $year';
}

String formatDatewithTime(DateTime dateTime) {
  final String month = DateFormat('MMMM').format(dateTime);
  final String day = DateFormat('dd').format(dateTime);
  final String year = DateFormat('yyyy').format(dateTime);
  return '$day $month $year ${dateTime.hour}:${dateTime.minute}';
}

bool isSameDate(DateTime date1, DateTime date2) {
  if (date1.year == date2.year && date1.month == date2.month && date1.day == date2.day) {}

  return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
}

String formatDate3(DateTime dateTime) {
  final String month = DateFormat('MM').format(dateTime);
  final String day = DateFormat('dd').format(dateTime);
  final String year = DateFormat('yyyy').format(dateTime);
  return '$day/$month/$year';
}

String formatDatefromString(String inputDate) {
  DateTime dateTime = DateFormat('yyyy-MM-dd').parse(inputDate);
  String formattedDate = DateFormat('dd MMMM yyyy').format(dateTime);
  return formattedDate;
}

String formatDatefromString2(String date) {
  DateTime inputDate = DateTime.parse(date);
  String formattedDate = DateFormat("MMM dd yyyy, HH:mm").format(inputDate);
  return formattedDate;
}

String formatDate2(DateTime dateTime) {
  final String month = DateFormat('MM').format(dateTime);
  final String day = DateFormat('dd').format(dateTime);
  final String year = DateFormat('yyyy').format(dateTime);
  return '$year-$month-$day';
}

String fomratDateapi(DateTime dateTime) {
  String formattedDate = DateFormat('dd-MM-yyyy hh:mm a').format(dateTime);
  return formattedDate;
}

String getschedule(String val) {
  return val == 'morning' ? '6am - 8am' : '4pm - 6pm';
}

void focusAndSelectLastLetter({required FocusNode focusNode, required TextEditingController controller, required BuildContext context}) {
  FocusScope.of(context).requestFocus(focusNode);
  focusNode.unfocus(); // Ensure focus is removed before setting selection
  focusNode.requestFocus();
  controller.selection = TextSelection.fromPosition(TextPosition(offset: controller.text.length));
}

void determinePosition(BuildContext context) async {
  await Geolocator.getCurrentPosition();
  LocationPermission permission;

  // // Test if location services are enabled.
  // serviceEnabled = await Geolocator.isLocationServiceEnabled();
  // // if (!serviceEnabled) {
  // //   showDialog(
  // //     context: context,
  // //     builder: (context) => AlertDialog(
  // //       backgroundColor: Colors.black,
  // //       title: const Text("Location Services Disabled", style: TextStyle(color: Colors.white)),
  // //       content: const Text("Please enable location services in your device settings.", style: TextStyle(color: Colors.white)),
  // //       actions: [
  // //         TextButton(
  // //           onPressed: () => Navigator.pop(context),
  // //           child: const Text("Cancel"),
  // //         ),
  // //         TextButton(
  // //           onPressed: () {
  // //             AppSettings.openAppSettings(type: AppSettingsType.location);
  // //             Navigator.pop(context);
  // //           },
  // //           child: const Text("Open Settings"),
  // //         ),
  // //       ],
  // //     ),
  // //   );
  // // }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }
}

Future<Position?> getlocation() async {
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }
  Position currentPosition = await Geolocator.getCurrentPosition();
  return currentPosition;
}

Future<void> shareImageFromAssets() async {
  final ByteData bytes = await rootBundle.load('assets/confirm_bg.png');
  final tempDir = await getTemporaryDirectory();
  final tempFile = File('${tempDir.path}/image_to_share.jpg');
  await tempFile.writeAsBytes(bytes.buffer.asUint8List());
  await Share.shareFiles([tempFile.path], text: 'Check out this image');
  // Share.shareXFiles([XFile('assets/confirm_bg.png')]);
}

void notification(Color bg, int duration, String text, BuildContext context) {
  bool dialoge = true;
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: duration), () {
          if (dialoge) {
            Get.back();
          }
        });
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          backgroundColor: bg,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                  Expanded(child: Center(child: Text(text))),
                  InkWell(
                      onTap: () {
                        dialoge = false;
                        Get.back();
                      },
                      child: const Icon(Icons.close))
                ])
              ],
            ),
          ),
        );
      });
}
// void notification(Color bg, int duration, String text, BuildContext context) {
//   ElegantNotification(
//     background: bg,
//     displayCloseButton: false,
//     showProgressIndicator: false,
//     width: double.maxFinite,
//     // notificationPosition: NotificationPosition.bottomCenter,
//     animation: AnimationType.fromBottom,
//     toastDuration: Duration(seconds: duration),
//     description: Center(
//       child: Text(
//         text,
//         textAlign: TextAlign.center,
//         style: const TextStyle(color: Colors.white),
//       ),
//     ),
//     onDismiss: () {},
//   ).show(context);
// }

// checkDistance(double userLatitude, double userLongitude) {
//   double southwestLatitude = 13.0473388;
//   double southwestLongitude = 79.8971725;
//   double northeastLatitude = 13.0826802;
//   double northeastLongitude = 80.2707184;
//   double distance = Geolocator.distanceBetween(userLatitude, userLongitude, referenceLatitude, referenceLongitude);
//   print(distance);
// }

dynamic findItemById(List<dynamic> items, int id) {
  for (dynamic item in items) {
    if (item is Map<String, dynamic> && item['id'] == id) {
      return item;
    }
  }
  return null; // Return null if no match is found
}

Color getStatus(String? status) {
  switch (status) {
    case 'confirmed':
      return const Color(0xFFF28B51);
    case 'pending':
      return const Color(0xFFF5CF47);
    case 'shipped':
      return const Color(0xFF308CEF);
    case 'delivered':
      return const Color(0xFF2F9623);
    case 'cancelled':
      return const Color(0xFFDC3647);
    default:
      return const Color(0xFF9A1503);
  }
}

Color getStatusBg(String? status) {
  switch (status) {
    case 'confirmed':
      return const Color(0xFFFFE5D7);
    case 'pending':
      return const Color(0xFFFFF3CB);
    case 'shipped':
      return const Color(0xFFE2F0FF);
    case 'delivered':
      return const Color(0xFFD7FAD3);
    case 'cancelled':
      return const Color(0xFFFFC5CA);
    default:
      return const Color(0xFFFFD5D0);
  }
}

String capitalizeFirstLetter(String text) {
  if (text.isEmpty) {
    return text;
  }
  return text[0].toUpperCase() + text.substring(1);
}

List<DateTime> generateDateList(String start, String type, List<CustomPatern> custompatern) {
  DateTime startDate = DateFormat('dd-MM-yyyy').parse(start);
  List<DateTime> dates = [];
  DateTime date = DateTime.now().hour < 11 ? DateTime.now().add(const Duration(days: 1)) : DateTime.now().add(const Duration(days: 2));
  DateTime initialDate = DateTime(date.year, date.month, date.day);
  DateTime finalDate = initialDate.add(const Duration(days: 30));
  DateTime currentDate = startDate.isBefore(initialDate) ? initialDate : startDate;

  if (type.toLowerCase() == 'alternate' && currentDate.difference(startDate).inDays % 2 != 0) {
    currentDate = startDate.isBefore(initialDate) ? initialDate.add(const Duration(days: 1)) : startDate;
  }

  if (type.toLowerCase() == 'daily') {
    while (currentDate.isBefore(finalDate)) {
      dates.add(currentDate);
      currentDate = currentDate.add(const Duration(days: 1));
    }
  } else if (type.toLowerCase() == 'alternate') {
    while (currentDate.isBefore(finalDate)) {
      dates.add(currentDate);
      currentDate = currentDate.add(const Duration(days: 2));
    }
  } else if (type.toLowerCase() == 'custom') {
    List<String> names = [];
    for (var pattern in custompatern) {
      names.add(pattern.name.toLowerCase());
    }

    while (currentDate.isBefore(finalDate)) {
      if (names.contains(DateFormat('EEEE').format(currentDate).toLowerCase())) {
        dates.add(currentDate);
      }
      currentDate = currentDate.add(const Duration(days: 1));
    }
  }

  return dates;
}

String formatDateWithoutTime(DateTime date) {
  return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
}

String getStartDate(int input) {
  DateTime now = DateTime.now();
  DateTime resultDate;

  if (input == 1) {
    resultDate = DateTime(now.year, now.month, 1);
  } else if (input == 2) {
    resultDate = DateTime(now.year, now.month - 1, 1);
  } else {
    resultDate = now.subtract(const Duration(days: 90));
  }

  String formattedDate = DateFormat('yyyy-MM-dd').format(resultDate);
  return formattedDate;
}

String getEndDate(int input) {
  DateTime now = DateTime.now();
  DateTime resultDate;

  if (input == 1) {
    resultDate = DateTime(now.year, now.month + 1, 0);
  } else if (input == 2) {
    resultDate = DateTime(now.year, now.month, 0);
  } else {
    resultDate = now;
  }

  String formattedDate = DateFormat('yyyy-MM-dd').format(resultDate);
  return formattedDate;
}

double calculateTotalWeeklyEstimation(List<Subscription> subscriptions) {
  double totalEstimation = 0;
  for (Subscription subscription in subscriptions) {
    totalEstimation += subscription.calculateWeeklyEstimation();
  }
  return totalEstimation;
}

double calculateTotalWeeklyEstimationNormal(List<Subscription> subscriptions) {
  double totalEstimation = 0;
  for (Subscription subscription in subscriptions) {
    totalEstimation += subscription.calculateWeeklyEstimationNormal();
  }
  return totalEstimation;
}

int checkPauseBybalnce(List<Subscription> subscriptions) {
  int count = 0;
  for (Subscription subscription in subscriptions) {
    if (subscription.approval == 1 && subscription.status == 0 && subscription.updatenote == 'paused due to low balance') {
      count++;
    }
  }
  return count;
}

int checkPauseByYou(List<Subscription> subscriptions) {
  int count = 0;
  for (Subscription subscription in subscriptions) {
    if (subscription.approval == 1 && subscription.status == 0 && subscription.updatenote == 'paused by you') {
      count++;
    }
  }
  return count;
}

int pausedCount(List<Subscription> subscriptions) {
  int count = 0;
  for (Subscription subscription in subscriptions) {
    if (subscription.approval == 1 && subscription.status == 0) {
      count++;
    }
  }
  return count;
}

bool checkAnyactive(List<Subscription> subscriptions) {
  for (Subscription subscription in subscriptions) {
    if (subscription.status == 1 && subscription.approval == 1) {
      return true;
    }
  }
  return false;
}

int checkAnyactivecount(List<Subscription> subscriptions) {
  int count = 0;
  for (Subscription subscription in subscriptions) {
    if (subscription.status == 1 && subscription.approval == 1) {
      count++;
    }
  }
  return count;
}

int checkcancelledcount(List<Subscription> subscriptions) {
  int count = 0;
  for (Subscription subscription in subscriptions) {
    if (subscription.approval == 0) {
      count++;
    }
  }
  return count;
}

List<Subscription> cancelledFilter(List<Subscription> subscriptions) {
  List<Subscription> list = [];
  for (Subscription subscription in subscriptions) {
    if (subscription.approval == 0) {
      list.add(subscription);
    }
  }
  return list;
}

List<Subscription> activeFilter(List<Subscription> subscriptions) {
  List<Subscription> list = [];
  for (Subscription subscription in subscriptions) {
    if (subscription.status == 1 && subscription.approval == 1) {
      list.add(subscription);
    }
  }
  return list;
}

List<Subscription> pausedFilter(List<Subscription> subscriptions) {
  List<Subscription> list = [];
  for (Subscription subscription in subscriptions) {
    if (subscription.approval == 1 && subscription.status == 0) {
      list.add(subscription);
    }
  }
  return list;
}

List<Subscription> filterSub(List<Subscription> subscriptions, int filter) {
  switch (filter) {
    case 0:
      return subscriptions;
    case 1:
      return activeFilter(subscriptions);
    case 2:
      return pausedFilter(subscriptions);
    case 3:
      return cancelledFilter(subscriptions);
    default:
      return subscriptions;
  }
}

double calculateTotalDailyEstimation(List<Subscription> subscriptions) {
  double totalEstimation = 0;
  for (Subscription subscription in subscriptions) {
    totalEstimation += subscription.calculateNextdayEstimation();
  }
  return totalEstimation;
}

double calculateCouponDiscount(DateTime date, double val, Coupon? coupon) {
  double discount = 0;
  if (coupon != null) {
    if (coupon.limit == 1) {
      if (checkIsSame(coupon.startDate, date)) {
        discount = coupon.discount.toDouble();
      }
    } else if (checkIsAfter(date, coupon.startDate) && checkIsBefore(date, coupon.endDate)) {
      if (coupon.discountType == 'percent') {
        double max = double.parse(getKeyByValue('max_discount', coupon.details) ?? '0');
        if (val * (coupon.discount / 100) < max) {
          discount = val * (coupon.discount / 100);
        } else {
          discount = max;
        }
      } else {
        discount = coupon.discount.toDouble();
      }
    }
  }
  return discount;
}

double first7daysCost(DateTime start, String type, SubProduct product, int qty, List<CustomPatern> weekdays, Coupon? coupon) {
  double estimated = 0;

  for (int i = 0; i < 7; i++) {
    DateTime check = start.add(Duration(days: i));
    if (type == 'One TIme') {
      if (isSameDate(check, start)) {
        double val = qty * double.parse(product.calculateDiscountedPrice());
        estimated += (val - (calculateCouponDiscount(check, val, coupon)));
      }
    } else if (type == 'Daily') {
      double val = qty * double.parse(product.calculateDiscountedPrice());
      estimated += (val - (calculateCouponDiscount(check, val, coupon)));
    } else if (type == 'Alternate') {
      int daysSinceStart = start.difference(check).inDays;
      if (daysSinceStart.isEven) {
        double val = qty * double.parse(product.calculateDiscountedPrice());
        estimated += (val - (calculateCouponDiscount(check, val, coupon)));
      }
    } else if (type == 'Custom') {
      String currentDayOfWeek = DateFormat('EEEE').format(check);
      for (CustomPatern day in weekdays) {
        if (day.name.toString().toLowerCase() == currentDayOfWeek.toLowerCase()) {
          double val = qty * double.parse(product.calculateDiscountedPrice());
          estimated += (val - (calculateCouponDiscount(check, val, coupon)));
          break;
        }
      }
    }
  }

  return estimated;
}

double first7daysCostnormal(DateTime start, String type, SubProduct product, int qty, List<CustomPatern> weekdays) {
  double estimated = 0;

  for (int i = 0; i < 7; i++) {
    DateTime check = start.add(Duration(days: i));
    if (type == 'One TIme') {
      if (isSameDate(check, start)) {
        double val = qty * double.parse(product.calculateDiscountedPrice());
        estimated += val;
      }
    } else if (type == 'Daily') {
      double val = qty * double.parse(product.calculateDiscountedPrice());
      estimated += val;
    } else if (type == 'Alternate') {
      int daysSinceStart = start.difference(check).inDays;
      if (daysSinceStart.isEven) {
        double val = qty * double.parse(product.calculateDiscountedPrice());
        estimated += val;
      }
    } else if (type == 'Custom') {
      String currentDayOfWeek = DateFormat('EEEE').format(check);
      for (CustomPatern day in weekdays) {
        if (day.name.toString().toLowerCase() == currentDayOfWeek.toLowerCase()) {
          double val = qty * double.parse(product.calculateDiscountedPrice());
          estimated += val;
          break;
        }
      }
    }
  }

  return estimated;
}

Future<dynamic> showAlert(BuildContext context, {String msg = 'Invalid mobile number !!!', Color clr = Colors.red, int seconds = 3}) async {
  // Check if the current route is already a dialog
  if (ModalRoute.of(context)?.isCurrent != true) {
    return null; // Don't show alert if not on top
  }

  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        Timer timer = Timer(Duration(seconds: seconds), () => Navigator.pop(context));
        return WillPopScope(
          onWillPop: () async {
            timer.cancel();
            return true;
          },
          child: Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            backgroundColor: clr,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                    Expanded(child: Center(child: Text(msg))),
                    InkWell(
                        onTap: () {
                          timer.cancel();
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.close))
                  ])
                ],
              ),
            ),
          ),
        );
      });
}

Future<dynamic> preloadView(BuildContext context) =>
    showDialog(context: context, barrierDismissible: false, builder: (BuildContext context) => WillPopScope(onWillPop: () async => false, child: const Column()));

String? getKeyByValue(dynamic key, List<MapEntry<String, dynamic>> details) {
  for (var entry in details) {
    if (entry.key == key) {
      return entry.value;
    }
  }
  return null; // Return null if the value is not found
}

void lastAcess({required double lat, required double long}) async {
  const storage = FlutterSecureStorage();
  final url = Uri.parse('https://gogreenocean.com/api/user/updateLastLocation');
  String? token = await storage.read(key: 'access_token');
  final body = {'location': '$lat,$long'};
  final headers = {'Authorization': 'Bearer $token'};
  await http.post(url, headers: headers, body: body);
}

bool distanceInMeters({required double lat, required double long}) {
  double d1 = Geolocator.distanceBetween(12.933741, 80.229569, lat, long);
  double d2 = Geolocator.distanceBetween(13.052035, 80.206055, lat, long);
  double d3 = Geolocator.distanceBetween(12.9299577, 80.0948447, lat, long);
  double d4 = Geolocator.distanceBetween(12.5071158, 79.8889116, lat, long);
  double d5 = Geolocator.distanceBetween(13.1235114, 80.2837033, lat, long);
  double d6 = Geolocator.distanceBetween(12.9730633, 80.2217117, lat, long); // velacherry
  double d7 = Geolocator.distanceBetween(12.7741287, 80.2148898, lat, long); //Incor PBEL City Chennai
  double d8 = Geolocator.distanceBetween(12.9497708, 80.1916336, lat, long); //Sunnambu Kolathur (606402)
  double d9 = Geolocator.distanceBetween(12.9582068, 80.1749976, lat, long); //Keelkattalai 600117
  double d10 = Geolocator.distanceBetween(12.9674966, 80.1440511, lat, long); //Pallavaram 600043
  double d11 = Geolocator.distanceBetween(12.9496714, 80.1256835, lat, long); //Chrompet 600044
  double d12 = Geolocator.distanceBetween(12.9215723, 80.113479, lat, long); //Chitlapakam 600059
  double d13 = Geolocator.distanceBetween(12.9357568, 80.1382692, lat, long); //Chitlapakam 600064
  double d14 = Geolocator.distanceBetween(12.9687931, 80.18784, lat, long); //Madipakam 600091
  double d15 = Geolocator.distanceBetween(12.8492447, 80.2260141, lat, long); //Navalur Chennai - 600130
  double d16 = Geolocator.distanceBetween(13.0381648, 80.2592599, lat, long); //Mylapore
  double d17 = Geolocator.distanceBetween(13.0067528, 80.2489858, lat, long); //Adyar
  double d18 = Geolocator.distanceBetween(12.9982507, 80.2579375, lat, long); //Besant Nagar && Thiruvanmiyur && SRP tools
  double d19 = Geolocator.distanceBetween(13.0067063, 80.2093726, lat, long); //Guindy
  double d20 = Geolocator.distanceBetween(12.9199886, 80.1661609, lat, long); //Medavakkam
  double d21 = Geolocator.distanceBetween(12.9646597, 80.2427498, lat, long); //Kandhanchavadi && perungudi && seevaram && DB jain clg - mettukuppam
  double d22 = Geolocator.distanceBetween(12.9168791, 80.2166273, lat, long); //karapakkam && sholinganallur && ponniyamman kovil
  double d23 = Geolocator.distanceBetween(13.1268033, 80.1902104, lat, long); //Kumaran nagar
  double d24 = Geolocator.distanceBetween(12.8677589, 80.2174695, lat, long); //sathyabama dental clg && semengerry && navalur
  double d25 = Geolocator.distanceBetween(12.8305217, 80.1678388, lat, long); //Siruseri
  double d26 = Geolocator.distanceBetween(12.8201849, 80.2246466, lat, long); //Kazhipathur
  double d27 = Geolocator.distanceBetween(12.8020867, 80.2123939, lat, long); //Padur
  double d28 = Geolocator.distanceBetween(12.800335, 79.6720658, lat, long); //Hindusthan clg
  double d29 = Geolocator.distanceBetween(12.788156, 80.2126174, lat, long); //Kelambakkm
  double d30 = Geolocator.distanceBetween(12.738841, 80.1696824, lat, long); //Thaiyur
  double d31 = Geolocator.distanceBetween(13.0915175, 80.248508, lat, long); //otteri

  // print([d1, d2, d3, d4, d5, d6, d7, d8, d9, d10, d11, d12, d13, d14]);

  if ([d1, d2, d3, d4, d5, d7, d8, d9, d10, d11, d12, d13, d14, d15, d16, d17, d19, d20, d23, d25, d26, d27, d28, d29, d30, d31].any((distance) => distance < 3200) ||
      [d6].any((distance) => distance < 13500) ||
      [d18, d21, d22, d24].any((distance) => distance < 4200)) {
    return true;
  }
  return false;
}
// double distanceInMeters2 = Geolocator.distanceBetween(latitude1, longitude1, latitude2, longitude2);

bool checkIsAfter(DateTime date1, DateTime date2) {
  DateTime date1Only = DateTime(date1.year, date1.month, date1.day);
  DateTime date2Only = DateTime(date2.year, date2.month, date2.day);
  return date1Only.isAfter(date2Only);
}

bool isActiveSubscriptionExists(int productId, List<Subscription> item) {
  return item.any((subscription) => subscription.pid == productId && subscription.status == 1 && subscription.approval == 1);
}

bool isPausedSubscriptionExists(int productId, List<Subscription> item) {
  return item.any((subscription) => subscription.pid == productId && subscription.status == 0 && subscription.approval == 1);
}

bool checkIsBefore(DateTime date1, DateTime date2) {
  DateTime date1Only = DateTime(date1.year, date1.month, date1.day);
  DateTime date2Only = DateTime(date2.year, date2.month, date2.day);
  return date1Only.isBefore(date2Only);
}

bool checkIsSame(DateTime date1, DateTime date2) {
  DateTime date1Only = DateTime(date1.year, date1.month, date1.day);
  DateTime date2Only = DateTime(date2.year, date2.month, date2.day);
  return date1Only.isAtSameMomentAs(date2Only);
}
