import 'dart:convert';

import 'package:intl/intl.dart';

import '../extrafunctions.dart';

class CustomPatern {
  final String label;
  final String name;
  int qty;
  CustomPatern({required this.label, required this.name, required this.qty});
  factory CustomPatern.fromJson(Map<String, dynamic> json) {
    return CustomPatern(
        label: json['label'], name: json['name'], qty: json['qty']);
  }
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CustomPatern && other.label == label;
  }

  @override
  int get hashCode {
    return label.hashCode;
  }

  Map<String, dynamic> toJson() {
    return {'label': label, 'name': name, 'qty': qty};
  }
}

class AddressList {
  final List coordinates;
  final String name;
  final String postcode;
  final String city;
  final String state;
  final String country;

  AddressList(
      {required this.coordinates,
      required this.name,
      required this.postcode,
      required this.city,
      required this.state,
      required this.country});
  factory AddressList.fromJson(Map<String, dynamic> json) {
    return AddressList(
      coordinates: json['geometry']['coordinates'] ?? "",
      name: json['properties']['name'] ?? "",
      postcode: json['properties']['postcode'] ?? '',
      state: json['properties']['state'] ?? "",
      country: json['properties']['country'] ?? '',
      city: json['properties']['city'] ?? '',
    );
  }
}

class UserDetails {
  int id;
  int enablesample;
  String name;
  String email;
  String phone;
  double balance;
  int lastCheckLocationcount;
  UserDetails({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.balance,
    required this.enablesample,
    required this.lastCheckLocationcount,
  });
  factory UserDetails.fromJson(Map<String, dynamic> json) {
    double balance = json['balance'] is String
        ? double.tryParse(json['balance']) ??
            0.0 // Convert string to double or default to 0.0 if parsing fails
        : (json['balance'] ?? 0)
            .toDouble(); // Convert null or other types to double or default to 0.0

    return UserDetails(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      enablesample: json['enable_sample'] ?? 0,
      lastCheckLocationcount: json['lastCheckLocation_count'] ?? 0,
      balance: balance,
    );
  }
}

class Subscription {
  int id;
  int uid;
  int pid;
  int addressId;
  int qty;
  String start;
  String updatedAt;
  String type;
  String schedule;
  List<CustomPatern> weekdays;
  int status;
  int approval;
  String updatenote;
  List<dynamic>? instruction;
  List<DateTime> skipped;
  SubProduct? product;
  UserAddress? address;
  Coupon? coupon;
  int tempfreeordercount;
  int tempordercount;

  Subscription(
      {required this.id,
      required this.uid,
      required this.pid,
      required this.addressId,
      required this.qty,
      required this.start,
      required this.type,
      required this.schedule,
      required this.weekdays,
      required this.status,
      required this.approval,
      required this.updatenote,
      required this.instruction,
      required this.skipped,
      required this.updatedAt,
      required this.tempfreeordercount,
      required this.tempordercount,
      this.product,
      this.address,
      this.coupon});

  factory Subscription.fromJson(Map<String, dynamic> json) {
    List<dynamic> weekdays = jsonDecode(json['weekdays']) ?? [];
    List<dynamic> skip = json['skip'] == null ? [] : jsonDecode(json['skip']);

    return Subscription(
      id: json['id'],
      uid: json['uid'],
      pid: json['pid'],
      addressId: json['address_id'],
      qty: json['qty'],
      start: json['start'],
      updatedAt: json['updated_at'],
      type: json['type'],
      schedule: json['schedule'],
      weekdays: weekdays.map((e) => CustomPatern.fromJson(e)).toList(),
      status: json['status'],
      approval: json['approval'],
      updatenote: json['update_note'] ?? '',
      tempfreeordercount: json['temp_free_order_count'] ?? 0,
      tempordercount: json['temp_order_count'] ?? 0,
      instruction:
          json['instruction'] != null ? jsonDecode(json['instruction']) : [],
      skipped: skip.map((e) => DateTime.parse(e)).toList(),
      product:
          json['product'] != null ? SubProduct.fromJson(json['product']) : null,
      address: json['address'] != null
          ? UserAddress.fromJson(json['address'])
          : null,
      coupon: json['applied_coupon'] != null
          ? Coupon.fromJson(json['applied_coupon'])
          : null,
    );
  }

  double estimate() {
    return qty * product!.unitPrice;
  }

  List<DateTime> getUpcomingTUWDeliveries() {
    if (status == 0 || approval == 0) {
      return [];
    }

    List<DateTime> upcomingDeliveries = [];
    DateTime now = DateTime.now();
    DateTime startDate = DateTime.parse(start);
    List<DateTime> skip = skipped;

    void addDeliveries(DateTime date, Duration interval,
        {bool isCustom = false}) {
      while (upcomingDeliveries.length < 2) {
        if (!skip.contains(date)) {
          if (isCustom) {
            String currentDayOfWeek = DateFormat('EEEE').format(date);
            for (CustomPatern day in weekdays) {
              if (day.name.toString().toLowerCase() ==
                  currentDayOfWeek.toLowerCase()) {
                upcomingDeliveries.add(date);
                break;
              }
            }
          } else {
            upcomingDeliveries.add(date);
          }
        }
        date = date.add(interval);
      }
    }

    if (type == 'One Time') {
      return startDate.isBefore(now) && !skip.contains(startDate)
          ? [startDate]
          : [];
    } else {
      if (startDate.isBefore(now)) {
        startDate = now;
      }

      if (type == 'Daily') {
        addDeliveries(startDate, const Duration(days: 1));
      } else if (type == 'Alternate') {
        if (!now.difference(startDate).inDays.isEven) {
          startDate = now.add(const Duration(days: 1));
        }
        addDeliveries(startDate, const Duration(days: 2));
      } else if (type == 'Custom') {
        addDeliveries(startDate, const Duration(days: 1), isCustom: true);
      }
    }

    return upcomingDeliveries;
  }

  // List<DateTime> getUpcomingTUWDeliveries() {
  //   if (status == 0 || approval == 0) {
  //     return [];
  //   }
  //   List<DateTime> upcomingDeliveries = [];
  //   DateTime now = DateTime.now();
  //   DateTime startDate = DateTime.parse(start);

  //   if (type == 'One TIme') {
  //     if (startDate.isBefore(now)) {
  //       return [startDate];
  //     } else {
  //       return [];
  //     }
  //   } else {
  //     if (type == 'Daily') {
  //       if (startDate.isBefore(now)) {
  //         DateTime date = startDate;
  //         while (upcomingDeliveries.length < 2) {
  //           if (skipped.contains(date)) {
  //             date = date.add(Duration(days: 1));
  //           } else {
  //             upcomingDeliveries.add(date);
  //           }
  //         }
  //       } else {
  //         DateTime date = now;
  //         while (upcomingDeliveries.length < 2) {
  //           if (skipped.contains(date)) {
  //             date = date.add(Duration(days: 1));
  //           } else {
  //             upcomingDeliveries.add(date);
  //           }
  //         }
  //       }
  //     } else if (type == 'Alternate') {
  //       if (startDate.isBefore(now)) {
  //         DateTime date = startDate;
  //         while (upcomingDeliveries.length < 2) {
  //           if (skipped.contains(date)) {
  //             date = date.add(Duration(days: 2));
  //           } else {
  //             upcomingDeliveries.add(date);
  //           }
  //         }
  //       } else {
  //         DateTime date = now;
  //         if (!now.difference(startDate).inDays.isEven) {
  //           date = now.add(Duration(days: 1));
  //         }
  //         while (upcomingDeliveries.length < 2) {
  //           if (skipped.contains(date)) {
  //             date = date.add(Duration(days: 2));
  //           } else {
  //             upcomingDeliveries.add(date);
  //           }
  //         }
  //       }
  //     } else {}
  //   }
  //   return upcomingDeliveries;
  // }

  String showText() {
    if (approval == 0) {
      if (updatenote == 'cancelled by the admin') {
        return 'This subscription has been cancelled by the admin. Please contact support for assistance';
      } else if (updatenote == 'cancelled by you') {
        return 'This subscription was cancelled by you on : ${formatDatefromString(updatedAt)}';
      } else if (updatenote ==
          'Subscription has been automatically cancelled Since one-time subscription is completed') {
        return 'Subscription has been automatically cancelled Since one-time subscription is completed.';
      } else if (updatenote ==
          'Insufficient balance led to cancellation of your one-time order; it cannot be resumed') {
        return 'Insufficient balance led to cancellation of your one-time order; it cannot be resumed';
      }
      return 'This subscription was cancelled on : ${formatDatefromString(updatedAt)}';
    } else if (status == 0) {
      if (updatenote == 'paused due to low balance') {
        return 'Subscription paused on ${formatDatefromString(updatedAt)} due to low balance; please recharge and resume';
      } else if (updatenote == 'paused by you') {
        return 'This subscription was paused by you on : ${formatDatefromString(updatedAt)}';
      }
      return 'This subscription was paused on : ${formatDatefromString(updatedAt)}';
    } else if (status == 1 && updatenote == 'paused by you') {
      return 'Subscription resumed on ${formatDatefromString(updatedAt)}';
    }

    return 'Subscription started on ${formatDatefromString(start)}';
  }

  double calculateDiscountForDeliveryDays(
      {required Map<DateTime, int> deliveryDays,
      required List<MapEntry<String, dynamic>> couponDetails,
      required double pricePerUnit,
      required int currentDeliveryCount,
      required int currentFreeCount}) {
    int minOrderCount =
        int.parse(getKeyByValue('min_order_count', couponDetails) ?? '0');
    int freeDays = int.parse(getKeyByValue('free_days', couponDetails) ?? '0');
    int maxItemCount =
        int.parse(getKeyByValue('max_item_count', couponDetails) ?? '0');

    double totalDiscount = 0;
    int deliveryCount = currentDeliveryCount;
    int freeCount = currentFreeCount;

    for (DateTime day in deliveryDays.keys) {
      int qtyForDay = deliveryDays[day] ?? 0;
      if (deliveryCount < minOrderCount) {
        deliveryCount++;
      } else if (deliveryCount >= minOrderCount && freeCount < freeDays) {
        int discountQty = qtyForDay < maxItemCount ? qtyForDay : maxItemCount;
        totalDiscount += discountQty * pricePerUnit;
        freeCount++;
      } else if (freeCount >= freeDays) {
        break;
      }
    }

    return totalDiscount;
  }

  double calculateCouponDiscount(DateTime date, double val) {
    double discount = 0;
    if (coupon != null) {
      if (coupon!.type == 'subscription') {
        return discount;
      } else {
        if (coupon!.limit == 1) {
          if (checkIsSame(coupon!.startDate, date)) {
            discount = coupon!.discount.toDouble();
          }
        } else if (checkIsAfter(date, coupon!.startDate) &&
            checkIsBefore(date, coupon!.endDate)) {
          if (coupon!.discountType == 'percent') {
            double max = double.parse(
                getKeyByValue('max_discount', coupon!.details) ?? '0');
            if (val * (coupon!.discount / 100) < max) {
              discount = val * (coupon!.discount / 100);
            } else {
              discount = max;
            }
          } else {
            discount = coupon!.discount.toDouble();
          }
        }
      }
    }

    return discount;
  }

  double calculateNextdayEstimation() {
    if (status == 0 || approval == 0) {
      return 0;
    }
    double estimated = 0;
    DateTime now = DateTime.now().add(const Duration(days: 1));
    DateTime initialDate = DateTime(now.year, now.month, now.day);
    DateTime startDate = DateTime.parse(start);
    DateTime check = initialDate;
    List<DateTime> skip = skipped;

    if (startDate.isBefore(check) && !skip.contains(check)) {
      if (type == 'One TIme') {
        if (isSameDate(check, startDate)) {
          double val = qty * double.parse(product!.calculateDiscountedPrice());
          estimated += (val - (calculateCouponDiscount(check, val)));
        }
      } else if (type == 'Daily') {
        double val = qty * double.parse(product!.calculateDiscountedPrice());
        estimated += (val - (calculateCouponDiscount(check, val)));
      } else if (type == 'Alternate') {
        int daysSinceStart = startDate.difference(check).inDays;
        if (daysSinceStart.isEven) {
          double val = qty * double.parse(product!.calculateDiscountedPrice());
          estimated += (val - (calculateCouponDiscount(check, val)));
        }
      } else if (type == 'Custom') {
        String currentDayOfWeek = DateFormat('EEEE').format(check);
        for (CustomPatern day in weekdays) {
          if (day.name.toString().toLowerCase() ==
              currentDayOfWeek.toLowerCase()) {
            double val =
                day.qty * double.parse(product!.calculateDiscountedPrice());
            estimated += (val - (calculateCouponDiscount(check, val)));
            break;
          }
        }
      }
    }

    return estimated;
  }

  double calculateWeeklyEstimation() {
    if (status == 0 || approval == 0) {
      return 0;
    }

    double estimated = 0;
    DateTime now = DateTime.now().add(const Duration(days: 1));
    DateTime initialDate = DateTime(now.year, now.month, now.day);
    DateTime startDate = DateTime.parse(start);
    for (int i = 0; i < 7; i++) {
      DateTime check = initialDate.add(Duration(days: i));
      List<DateTime> skip = skipped;

      if ((startDate.isBefore(check) || isSameDate(check, startDate)) &&
          !skip.contains(check)) {
        if (type == 'One TIme') {
          if (isSameDate(check, startDate)) {
            double val =
                qty * double.parse(product!.calculateDiscountedPrice());
            estimated += (val - (calculateCouponDiscount(check, val)));
          }
        } else if (type == 'Daily') {
          double val = qty * double.parse(product!.calculateDiscountedPrice());
          estimated += (val - (calculateCouponDiscount(check, val)));
        } else if (type == 'Alternate') {
          int daysSinceStart = startDate.difference(check).inDays;
          if (daysSinceStart.isEven) {
            double val =
                qty * double.parse(product!.calculateDiscountedPrice());
            estimated += (val - (calculateCouponDiscount(check, val)));
          }
        } else if (type == 'Custom') {
          String currentDayOfWeek = DateFormat('EEEE').format(check);
          for (CustomPatern day in weekdays) {
            if (day.name.toString().toLowerCase() ==
                currentDayOfWeek.toLowerCase()) {
              double val =
                  day.qty * double.parse(product!.calculateDiscountedPrice());
              estimated += (val - (calculateCouponDiscount(check, val)));
              break;
            }
          }
        }
      }
    }
    if (coupon != null && coupon!.type == 'subscription') {
      estimated -= calculateDiscountForDeliveryDays(
          couponDetails: coupon!.details,
          deliveryDays: calculateWeeklyDeliveryDays(),
          pricePerUnit: double.parse(product!.calculateDiscountedPrice()),
          currentDeliveryCount: tempordercount,
          currentFreeCount: tempfreeordercount);
    }

    return estimated;
  }

  Map<DateTime, int> calculateWeeklyDeliveryDays() {
    Map<DateTime, int> deliveryDays = {};

    if (status == 0 || approval == 0) {
      return deliveryDays;
    }

    DateTime now = DateTime.now().add(const Duration(days: 1));
    DateTime initialDate = DateTime(now.year, now.month, now.day);
    DateTime startDate = DateTime.parse(start);

    for (int i = 0; i < 7; i++) {
      DateTime check = initialDate.add(Duration(days: i));
      List<DateTime> skip = skipped;

      if ((startDate.isBefore(check) || isSameDate(check, startDate)) &&
          !skip.contains(check)) {
        int dayQty = 0;

        if (type == 'One Time') {
          if (isSameDate(check, startDate)) {
            dayQty = qty;
          }
        } else if (type == 'Daily') {
          dayQty = qty;
        } else if (type == 'Alternate') {
          int daysSinceStart = startDate.difference(check).inDays;
          if (daysSinceStart.isEven) {
            dayQty = qty;
          }
        } else if (type == 'Custom') {
          String currentDayOfWeek = DateFormat('EEEE').format(check);
          for (CustomPatern day in weekdays) {
            if (day.name.toString().toLowerCase() ==
                currentDayOfWeek.toLowerCase()) {
              dayQty = day.qty;
              break;
            }
          }
        }
        if (dayQty > 0) {
          deliveryDays[check] = dayQty;
        }
      }
    }

    return deliveryDays;
  }

  double calculateWeeklyEstimationNormal() {
    if (status == 0 || approval == 0) {
      return 0;
    }
    double estimated = 0;
    DateTime now = DateTime.now().add(const Duration(days: 1));
    DateTime initialDate = DateTime(now.year, now.month, now.day);
    DateTime startDate = DateTime.parse(start);

    for (int i = 0; i < 7; i++) {
      DateTime check = initialDate.add(Duration(days: i));
      List<DateTime> skip = skipped;

      if ((startDate.isBefore(check) || isSameDate(check, startDate)) &&
          !skip.contains(check)) {
        if (type == 'One TIme') {
          if (isSameDate(check, startDate)) {
            double val =
                qty * double.parse(product!.calculateDiscountedPrice());
            estimated += val;
          }
        } else if (type == 'Daily') {
          double val = qty * double.parse(product!.calculateDiscountedPrice());
          estimated += val;
        } else if (type == 'Alternate') {
          int daysSinceStart = startDate.difference(check).inDays;
          if (daysSinceStart.isEven) {
            double val =
                qty * double.parse(product!.calculateDiscountedPrice());
            estimated += val;
          }
        } else if (type == 'Custom') {
          String currentDayOfWeek = DateFormat('EEEE').format(check);
          for (CustomPatern day in weekdays) {
            if (day.name.toString().toLowerCase() ==
                currentDayOfWeek.toLowerCase()) {
              double val =
                  day.qty * double.parse(product!.calculateDiscountedPrice());
              estimated += val;
              break;
            }
          }
        }
      }
    }

    return estimated;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Subscription && other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}

class SubProduct {
  int id;
  String name;
  int userId;
  String unit;
  double unitPrice;
  double discount;
  String discountType;
  String sellername;
  String sellerimg;
  double sellerRating;
  int sellernumofreview;
  String imageurl;

  SubProduct({
    required this.id,
    required this.name,
    required this.userId,
    required this.unit,
    required this.unitPrice,
    required this.discount,
    required this.discountType,
    required this.sellername,
    required this.sellerimg,
    required this.sellerRating,
    required this.sellernumofreview,
    required this.imageurl,
  });

  factory SubProduct.fromJson(Map<String, dynamic> json) {
    return SubProduct(
      id: json['id'],
      name: json['name'] ?? "",
      userId: json['user_id'],
      unit: json['unit'] ?? "",
      unitPrice: json['unit_price']?.toDouble() ?? 0.00,
      discount: json['discount']?.toDouble() ?? 0.00,
      discountType: json['discount_type'] ?? "",
      sellername: json['user']['name'] ?? "",
      sellerimg: json['user']['imageurl'] ?? "",
      sellerRating: json['shop']['rating']?.toDouble() ?? 0.00,
      sellernumofreview: json['shop']['num_of_reviews'] ?? 0,
      imageurl: json['imageurl'] ?? '',
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SubProduct && other.id == id && other.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode;
  }

  String calculateDiscountedPrice() {
    double originalPrice = unitPrice;
    if (discountType == "amount") {
      double discountedPrice = originalPrice - discount;
      return discountedPrice.toStringAsFixed(
          discountedPrice.truncateToDouble() == discountedPrice ? 0 : 2);
    } else if (discountType == "percentage") {
      double percentageDiscount = (discount / 100) * originalPrice;
      double discountedPrice = originalPrice - percentageDiscount;
      return discountedPrice.toStringAsFixed(
          discountedPrice.truncateToDouble() == discountedPrice ? 0 : 2);
    }
    return originalPrice.toStringAsFixed(
        originalPrice.truncateToDouble() == originalPrice ? 0 : 2);
  }
}

class Product {
  int id;
  String name;
  int userId;
  String unit;
  double unitPrice;
  double discount;
  String discountType;
  String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.userId,
    required this.unit,
    required this.unitPrice,
    required this.discount,
    required this.discountType,
    required this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      userId: json['user_id'],
      unit: json['unit'],
      unitPrice: json['unit_price'].toDouble(),
      discount: json['discount'].toDouble(),
      discountType: json['discount_type'],
      imageUrl: json['imageurl'],
    );
  }

  String calculateDiscountedPrice() {
    double originalPrice = unitPrice;
    if (discountType == "amount") {
      double discountedPrice = originalPrice - discount;
      return discountedPrice.toStringAsFixed(
          discountedPrice.truncateToDouble() == discountedPrice ? 0 : 2);
    } else if (discountType == "percentage") {
      double percentageDiscount = (discount / 100) * originalPrice;
      double discountedPrice = originalPrice - percentageDiscount;
      return discountedPrice.toStringAsFixed(
          discountedPrice.truncateToDouble() == discountedPrice ? 0 : 2);
    }
    return originalPrice.toStringAsFixed(
        originalPrice.truncateToDouble() == originalPrice ? 0 : 2);
  }
}

class WalletRegister {
  int id;
  String orderId;
  WalletRegister({required this.id, required this.orderId});
  factory WalletRegister.fromJson(Map<String, dynamic> json) {
    return WalletRegister(id: json['id'], orderId: json['razor_pay_order_id']);
  }
}

class OrderDetails {
  int id;
  int orderId;
  int productId;
  double shippingCost;
  double tax;
  int quantity;
  double price;
  Product product;

  OrderDetails({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.shippingCost,
    required this.tax,
    required this.quantity,
    required this.price,
    required this.product,
  });
  double calculateUnitPrice() {
    return price / quantity;
  }

  factory OrderDetails.fromJson(Map<String, dynamic> json) {
    return OrderDetails(
      id: json['id'],
      orderId: json['order_id'],
      productId: json['product_id'],
      shippingCost: json['shipping_cost'].toDouble(),
      tax: json['tax'].toDouble(),
      quantity: json['quantity'],
      price: json['price'].toDouble(),
      product: Product.fromJson(json['product']),
    );
  }
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is OrderDetails && other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}

class Seller {
  int id;
  String name;
  String avatarOriginal;
  String imageUrl;
  Seller(
      {required this.id,
      required this.name,
      required this.avatarOriginal,
      required this.imageUrl});
  factory Seller.fromJson(Map<String, dynamic> json) {
    return Seller(
        id: json['id'],
        name: json['name'] ?? "",
        avatarOriginal: json['avatar_original'] ?? "",
        imageUrl: json['imageurl'] ?? "");
  }
}

class ShippingAddress {
  final String name;
  final String address;
  final String addressline;
  final String city;
  final String state;
  final String landmark;
  final String pincode;
  final String phone;
  final double? lattitude;
  final double? longitude;

  ShippingAddress(
      {required this.name,
      required this.address,
      required this.addressline,
      required this.landmark,
      required this.pincode,
      required this.phone,
      required this.lattitude,
      required this.longitude,
      required this.city,
      required this.state});

  factory ShippingAddress.fromJson(Map<String, dynamic> json) {
    return ShippingAddress(
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      addressline: json['addressline'] ?? '',
      landmark: json['landmark'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      pincode: json['postal_code'] ?? '',
      phone: json['phone'] ?? '',
      lattitude: json['lattitude'] != null
          ? json['lattitude'].toString().isNotEmpty
              ? json['lattitude']
              : null
          : null,
      longitude: json['longitude'] != null
          ? json['longitude'].toString().isNotEmpty
              ? json['longitude']
              : null
          : null,
    );
  }
  String getAddressString() {
    List<String> nonEmptyFields = [];

    if (address.isNotEmpty) {
      nonEmptyFields.add(address);
    }

    if (addressline.isNotEmpty) {
      nonEmptyFields.add(addressline);
    }

    if (city.isNotEmpty) {
      nonEmptyFields.add(city);
    }
    if (state.isNotEmpty) {
      nonEmptyFields.add(state);
    }

    if (pincode.isNotEmpty) {
      nonEmptyFields.add(pincode);
    }

    if (nonEmptyFields.isNotEmpty) {
      return nonEmptyFields.join(', ');
    } else {
      return 'No Address Available';
    }
  }
}

class OrderOpenDetails {
  int id;
  String deliveryStatus;
  String code;
  String trackingCode;
  String invoice;
  DateTime createdAt;
  double grandTotal;
  String paymentType;
  String paymentStatus;
  double coupondiscount;
  ShippingAddress shippingAddress;
  List<OrderDetails> orderDetails;
  Seller seller;

  OrderOpenDetails(
      {required this.id,
      required this.deliveryStatus,
      required this.code,
      required this.trackingCode,
      required this.invoice,
      required this.createdAt,
      required this.grandTotal,
      required this.paymentType,
      required this.paymentStatus,
      required this.shippingAddress,
      required this.orderDetails,
      required this.coupondiscount,
      required this.seller});
  double calculateTotal() {
    return orderDetails.fold(
        0, (total, orderDetail) => total + orderDetail.price);
  }

  double calculateTotalTax() {
    return orderDetails.fold(0, (tax, orderDetail) => tax + orderDetail.tax);
  }

  double calculateTotalShipping() {
    return orderDetails.fold(
        0, (shipping, orderDetail) => shipping + orderDetail.shippingCost);
  }

  factory OrderOpenDetails.fromJson(Map<String, dynamic> json) {
    List<dynamic> jsonlist = json['order_details'] ?? [];
    return OrderOpenDetails(
        id: json['id'],
        deliveryStatus: json['delivery_status'],
        code: json['code'] ?? "",
        coupondiscount: (json['coupon_discount'] ?? 0.0).toDouble(),
        trackingCode: json['tracking_code'] ?? "",
        invoice: json['invoice'] ?? "",
        createdAt: DateTime.parse(json['created_at']),
        grandTotal: json['grand_total'].toDouble(),
        paymentType: json['payment_type'],
        paymentStatus: json['payment_status'],
        shippingAddress:
            ShippingAddress.fromJson(jsonDecode(json['shipping_address'])),
        orderDetails:
            jsonlist.map((details) => OrderDetails.fromJson(details)).toList(),
        seller: Seller.fromJson(json['seller']));
  }
}

class Order {
  int id;
  String deliveryStatus;
  String code;
  DateTime createdAt;
  double grandTotal;
  String paymentType;
  String paymentStatus;
  int orderDetailsCount;
  DateTime? delivered;

  Order(
      {required this.id,
      required this.deliveryStatus,
      required this.code,
      required this.createdAt,
      required this.delivered,
      required this.grandTotal,
      required this.paymentType,
      required this.paymentStatus,
      required this.orderDetailsCount});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      deliveryStatus: json['delivery_status'],
      code: json['code'],
      createdAt: DateTime.parse(json['created_at']),
      delivered: json['delivered_on'] != null
          ? DateTime.parse(json['delivered_on']['created_at'])
          : null,
      grandTotal: (json['grand_total'] ?? 0).toDouble(),
      paymentType: json['payment_type'],
      paymentStatus: json['payment_status'],
      orderDetailsCount: json['order_details_count'],
    );
  }
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Order && other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}

class UserAddress {
  int id;
  String address;
  String addressLine;
  double longitude;
  double latitude;
  String phone;
  String landmark;
  int type;

  UserAddress({
    required this.id,
    required this.address,
    required this.addressLine,
    required this.longitude,
    required this.latitude,
    required this.type,
    required this.phone,
    required this.landmark,
  });

  factory UserAddress.fromJson(Map<String, dynamic> json) {
    return UserAddress(
      id: json['id'],
      address: json['address'] ?? "",
      longitude: json['longitude'] ?? 0.0,
      latitude: json['latitude'] ?? 0.0,
      phone: json['phone'] ?? "",
      landmark: json['landmark'] ?? "",
      addressLine: json['addressline'] ?? "",
      type: json['type'] ?? "",
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'address': address,
      'longitude': longitude,
      'latitude': latitude,
      'phone': phone,
      'landmark': landmark,
      'addressline': addressLine,
      'type': type,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserAddress && other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}

class WalletTransaction {
  final double debit;
  final int transactionid;
  final double credit;
  final String createdAt;
  final String refno;
  final String paymentstatus;
  final String type;
  final String others;
  WalletTransaction({
    required this.debit,
    required this.transactionid,
    required this.credit,
    required this.refno,
    required this.paymentstatus,
    required this.others,
    required this.type,
    required this.createdAt,
  });
  factory WalletTransaction.fromJson(Map<String, dynamic> json) {
    return WalletTransaction(
      debit: parseDouble(json['debit']) ?? 0.0,
      credit: parseDouble(json['credit']) ?? 0.0,
      refno: json['ref_no'] ?? '',
      transactionid: json['transaction_id'] ?? 0,
      paymentstatus: json['payment_status'] ?? '',
      others: json['others'] ?? '',
      type: json['type'] ?? '',
      createdAt: json['date'],
    );
  }
  bool isCredit() {
    return credit != 0.0;
  }

  String heading() {
    if (others == 'Total payment from 3rd party Used') {
      return 'Amount deducted for Online order';
    } else if (debit != 0 && type == 'Sales') {
      return 'Sale bill created';
    } else if (others == '<small>Advance payment</small>' &&
        type == 'Payment') {
      return 'Amount Added to Wallet';
    } else if (others != '<small>Advance payment</small>' &&
        type == 'Payment') {
      return others.replaceAll(RegExp(r'<small>|<\/small>'), '');
    } else if (type == 'Sell Return') {
      return 'Indication For Sell Return ';
    } else {
      return '';
    }
  }

  int headType() {
    // 0->app orders,1->salesorder,2->advance,3->paymentfororder,4->none
    if (others == 'Total payment from 3rd party Used') {
      return 0;
    } else if (debit != 0 && type == 'Sales') {
      return 1;
    } else if (others == '<small>Advance payment</small>' &&
        type == 'Payment') {
      return 2;
    } else if (others != '<small>Advance payment</small>' &&
        type == 'Payment') {
      return 3;
    } else {
      return 4;
    }
  }

  static double? parseDouble(dynamic value) {
    if (value is double) {
      return value;
    } else if (value is int) {
      return value.toDouble();
    } else if (value is String && value.isNotEmpty) {
      return double.tryParse(value);
    }
    return null;
  }
}

class Feed {
  final int id;
  final String title;
  final String product;
  final String category;
  final String desc;
  final DateTime createdAt;
  final String imageUrl;

  Feed({
    required this.id,
    required this.title,
    required this.product,
    required this.category,
    required this.desc,
    required this.createdAt,
    required this.imageUrl,
  });

  factory Feed.fromJson(Map<String, dynamic> json) {
    return Feed(
      id: json['id'],
      title: json['tittle'] ?? '',
      product: json['product'] ?? "",
      category: json['category'] ?? "",
      desc: json['desc'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
      imageUrl: json['imageurl'] ?? '',
    );
  }
}

class Coupon {
  final int id;
  final int userId;
  final String type;
  final String code;
  final List<MapEntry<String, dynamic>> details;
  final double discount;
  final String discountType;
  final String terms;
  final String desc;
  final int status;
  final int visibility;
  final int limit;
  final DateTime startDate;
  final DateTime endDate;
  final int usedcount;
  final int multisub;
  bool expand = false;

  Coupon(
      {required this.id,
      required this.userId,
      required this.usedcount,
      required this.type,
      required this.multisub,
      required this.code,
      required this.desc,
      required this.terms,
      required this.details,
      required this.discount,
      required this.discountType,
      required this.status,
      required this.visibility,
      required this.limit,
      required this.startDate,
      required this.endDate});

  factory Coupon.fromJson(Map<String, dynamic> json) {
    List<MapEntry<String, dynamic>> otherDetailsList = [];
    if (jsonDecode(json['details']) is Map &&
        jsonDecode(json['details']).isNotEmpty) {
      jsonDecode(json['details'])
          .forEach((key, value) => otherDetailsList.add(MapEntry(key, value)));
    }

    return Coupon(
      id: json['id'],
      userId: json['user_id'],
      type: json['type'],
      code: json['code'],
      details: otherDetailsList,
      discount: (json['discount'] ?? 0).toDouble(),
      discountType: json['discount_type'],
      status: json['status'],
      visibility: json['visibility'],
      limit: json['limit'],
      startDate: DateTime.fromMillisecondsSinceEpoch(json['start_date'] * 1000),
      endDate: DateTime.fromMillisecondsSinceEpoch(json['end_date'] * 1000),
      usedcount: json['applied_subscription_count'] ?? 0,
      desc: json['desc'] ?? "",
      terms: json['terms'] ?? "",
      multisub: json['multisub'],
    );
  }
  double maxdiscount() =>
      double.parse(getKeyByValue('max_discount', details) ?? '0');
  double minBuy() => double.parse(getKeyByValue('min_buy', details) ?? '0');

  double getFormattedDiscountvalu(double val) {
    double calculate = 0;

    if (discountType == 'percent') {
      if (val * (discount / 100) < maxdiscount()) {
        calculate = val * (discount / 100);
      } else {
        calculate = maxdiscount();
      }
    } else {
      calculate = discount.toDouble();
    }
    return calculate;
  }

  String getFormattedDiscount(double val) {
    double calculate = 0;

    if (discountType == 'percent') {
      if (val * (discount / 100) < maxdiscount()) {
        calculate = val * (discount / 100);
      } else {
        calculate = maxdiscount();
      }
    } else {
      calculate = discount.toDouble();
    }
    if (limit == 1) {
      return 'Save ₹$calculate with this code ';
    }
    return 'Save ₹$calculate/day with this code ';
  }

  String getFormattedDiscount1(double val) {
    if (type == 'subscription') {
      return 'Pay ${getKeyByValue('min_order_count', details)} days and enjoy ${getKeyByValue('free_days', details)} days free afterwards! *';
    }
    double calculate = 0;
    if (discountType == 'percent') {
      if (val * (discount / 100) < maxdiscount()) {
        calculate = val * (discount / 100);
      } else {
        calculate = maxdiscount();
      }
    } else {
      calculate = discount.toDouble();
    }
    if (limit == 1) {
      return ' ₹${val - calculate} ';
    }
    return ' ₹${val - calculate}/day';
  }

  String getFormattedDiscount2() {
    if (type == 'subscription') {
      return 'Pay ${getKeyByValue('min_order_count', details)} days and enjoy ${getKeyByValue('free_days', details)} days free afterwards! *';
    }
    if (discountType == 'percent') {
      if (limit == 1) {
        return '$discount% off';
      }
      return '$discount% off /day';
    } else {
      if (limit == 1) {
        return '₹$discount off';
      }
      return '₹$discount off/day';
    }
  }
}

// v2 start 


// v2 end