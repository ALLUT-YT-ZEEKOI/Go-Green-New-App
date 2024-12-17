import 'dart:convert';
import 'package:address_search_field/address_search_field.dart';
import 'package:flutter/material.dart';
import 'package:gogreen_lite/Allproviders/object.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;

import '../extrafunctions.dart';

class Lat {
  final double latitude;
  final double logitude;
  Lat({required this.latitude, required this.logitude});
  Map<String, dynamic> toJson() =>
      {'latitude': latitude, 'longitude': logitude};

  factory Lat.fromJson(Map<String, dynamic> json) =>
      Lat(latitude: json['latitude'], logitude: json['longitude']);
}

class MainProvider extends ChangeNotifier {
  void notify() => notifyListeners();

  //curent address
  Placemark? pickedAddress;
  Lat? lat;
  UserAddress? pickedSaved;
  void updatePickedfrom(double lati, double long) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lati, long);

    if (placemarks.isNotEmpty) {
      pickedAddress = placemarks.first;
      lat = Lat(latitude: lati, logitude: long);
      if (pickedAddress != null) {
        storecurrentAddress(pickedAddress!, lat!);
      }
      notifyListeners();
    }
  }

  void updatePickedsaved(UserAddress userAddress) {
    avilable = distanceInMeters(
        lat: userAddress.latitude, long: userAddress.longitude);
    pickedSaved = userAddress;
    notifyListeners();
    storecurrentsavedAddress(userAddress);
  }

  void getCoordinates(String placeId) async {
    const String apiKey = 'AIzaSyD-zFDSMo3Otg25k6NZ0bMZC2xCPIsof5c';
    const String apiUrl =
        'https://maps.googleapis.com/maps/api/place/details/json';
    final url = Uri.parse('$apiUrl?place_id=$placeId&key=$apiKey');
    final response = await http.get(url);
    final decodedResponse = json.decode(response.body);
    if (decodedResponse['status'] == 'OK') {
      final location = decodedResponse['result']['geometry']['location'];
      final double latitude = location['lat'];
      final double longitude = location['lng'];
      seacrchCo = LatLong(latitude, longitude);
      notifyListeners();
    }
  }

  LatLong? seacrchCo;
  LatLong? editCo;
  UserAddress? currentEdit;
  bool avilable = false;

  Future<bool> updatePickedAddress(LatLong pickedData) async {
    seacrchCo = pickedData;
    avilable =
        distanceInMeters(lat: pickedData.latitude, long: pickedData.longitude);
    List<Placemark> placemarks = await placemarkFromCoordinates(
        pickedData.latitude, pickedData.longitude);
    if (placemarks.isNotEmpty) {
      pickedAddress = placemarks.first;
      lat = Lat(latitude: pickedData.latitude, logitude: pickedData.longitude);
      if (pickedAddress != null) {
        storecurrentAddress(pickedAddress!, lat!);
        pickedSaved = null;
        deleteSavedAddress();
      }
      notifyListeners();
    }
    return true;
  }

  // for page navigation
  int pageType = 0;
  int homepageIndex = 0;
  int innerpageIndex = 0;
  int checkpagesIndex = 0;
  int loginIndex = 0;
//make only one is true if click only once subscription o product page
  bool onlyOne = false;
  SubProduct? selectedSubProduct;

  // for ScrollSnapList border and index
  int scrollSnapListIndex = 0;
  void updateScrollSnapListIndex(int val) {
    scrollSnapListIndex = val;
    notifyListeners();
  }

  // for subscription patten
  int pattenIndex = 0;
  void updatepattenIndex(int val) {
    if (val != pattenIndex) {
      pattenIndex = val;
      notifyListeners();
    }
  }

  int scheduleIndex = 0;
  void updatescheduleIndex(int val) {
    if (val != scheduleIndex) {
      scheduleIndex = val;
      notifyListeners();
    }
  }

  List<CustomPatern> customPattern = [];
  List<String> instructions = [];
  int productqty = 1;

  DateTime singleDate = DateTime.now().hour < 11
      ? DateTime.now().add(const Duration(days: 1))
      : DateTime.now().add(const Duration(days: 2));
  bool checkoutCalandershow = false;
  void togglecheckoutCalandershow() {
    checkoutCalandershow = !checkoutCalandershow;
    notifyListeners();
  }

  //  for user menu
  int menupagetype = 0;
  int menuMain = 0;
  int menuInner = 0;
  int menuFirst = 0;
  //for user acount editable;
  bool usernameEdit = true;
  void toggleusernameEdit() {
    usernameEdit = !usernameEdit;
    notifyListeners();
  }

  int transactionIndex = 1; //1-this month,2-last month,3-last30days
  void updatetransactionIndex(int val) {
    transactionIndex = val;
    notifyListeners();
  }

  bool usernumberEdit = true;
  void toggleusernumberEdit() {
    usernumberEdit = !usernumberEdit;
    notifyListeners();
  }

  bool useremailEdit = true;
  void toggleuseremailEdit() {
    useremailEdit = !useremailEdit;
    notifyListeners();
  }

  List<Address> searchList = [];

  Future<void> loadAddresses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? addressesJson = prefs.getString('addresses');
    if (addressesJson != null) {
      List<dynamic> decodedAddresses = json.decode(addressesJson);
      List<Address> loadedAddresses = decodedAddresses
          .map((item) => Address(
              coords: item['coords'],
              bounds: item['bounds'],
              reference: item['reference'],
              placeId: item['placeId']))
          .toList();
      searchList = loadedAddresses;
      searchList.length;
      notifyListeners();
    }
  }

  List<Map<String, dynamic>> addressesToMapList(List<Address> addresses) {
    return addresses.map((address) {
      return {
        'coords': address.coords?.toJson(),
        'bounds': address.bounds?.toJson(),
        'reference': address.reference,
        'placeId': address.placeId
      };
    }).toList();
  }

  Future<void> saveAddresses(List<Address> newAddresses) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Combine the new addresses with the existing addresses, removing duplicates
    List<Address> combinedList = List.from(searchList);
    combinedList.addAll(newAddresses);
    combinedList = combinedList.toSet().toList(); // Remove duplicates
    // Convert the combined list to a map list
    List<Map<String, dynamic>> addressesMapList =
        addressesToMapList(combinedList);
    // Save the updated list to SharedPreferences
    String addressesJson = json.encode(addressesMapList);
    prefs.setString('addresses', addressesJson);
    // Update the current list
    searchList = combinedList;
    notifyListeners();
  }

  Future<void> storecurrentAddress(Placemark placemark, Lat lat) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> jsonPickedData = placemark.toJson();
    Map<String, dynamic> jsonPickedData1 = lat.toJson();
    await prefs.setString('currentAddress', jsonEncode(jsonPickedData));
    await prefs.setString('currentAddresslat', jsonEncode(jsonPickedData1));
  }

  Future<void> deleteStoredAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('currentAddress');
  }

  Future<void> storecurrentsavedAddress(UserAddress placemark) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> jsonPickedData = placemark.toJson();
    await prefs.setString('savedAddress', jsonEncode(jsonPickedData));
  }

  Future<void> deleteSavedAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('savedAddress');
  }

  Future<void> deleteAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('addresses');
  }

  Future<Placemark?> retrievecurrentAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonPickedData = prefs.getString('currentAddress');
    String? jsonPickedData1 = prefs.getString('currentAddresslat');
    if (jsonPickedData != null) {
      Map<String, dynamic> pickedDataMap = jsonDecode(jsonPickedData);
      Map<String, dynamic> pickedDataMap1 = jsonDecode(jsonPickedData1!);
      Placemark data = Placemark.fromMap(pickedDataMap);
      Lat data1 = Lat.fromJson(pickedDataMap1);
      pickedAddress = data;
      avilable = distanceInMeters(lat: data1.latitude, long: data1.logitude);
      notifyListeners();
      return data;
    } else {
      return null;
    }
  }

  Future<UserAddress?> retrievesavedAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonPickedData = prefs.getString('savedAddress');
    if (jsonPickedData != null) {
      Map<String, dynamic> pickedDataMap = jsonDecode(jsonPickedData);
      UserAddress data = UserAddress.fromJson(pickedDataMap);
      pickedSaved = data;
      avilable = distanceInMeters(lat: data.latitude, long: data.longitude);
      notifyListeners();
      return data;
    } else {
      return null;
    }
  }
}
