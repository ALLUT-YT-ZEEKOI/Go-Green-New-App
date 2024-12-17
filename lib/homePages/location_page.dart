// ignore_for_file: unused_local_variable

import 'package:address_search_field/address_search_field.dart';
import 'package:flutter/material.dart';
import 'package:gogreen_lite/Allproviders/api_provider.dart';
import 'package:gogreen_lite/Allproviders/main_provider.dart';
import 'package:gogreen_lite/homePages/widgets/location_saved.dart';
import '../customPackages/geo_methhods_sutom.dart' as custom;
import 'package:provider/provider.dart';
import 'widgets/new_location.dart';

List<Address> addressList = [];

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});
  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  @override
  void initState() {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    mainProvider.loadAddresses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);
    final apiProvider = Provider.of<ApiProvider>(context);
    performSearch(String searchQuery) async {
      // LocationPermission permission = await Geolocator.checkPermission();
      // Map<String, String> queryParams = {};
      // if ((permission == LocationPermission.whileInUse || permission == LocationPermission.always) && await Geolocator.isLocationServiceEnabled()) {
      //   Position currentPosition = await Geolocator.getCurrentPosition();
      //   queryParams = {"q": searchQuery, "lon": currentPosition.longitude.toString(), "lat": currentPosition.latitude.toString(), "osm_tag": 'place', 'limit': '5'};
      // } else {
      //   queryParams = {"q": searchQuery, "osm_tag": 'place', 'limit': '5'};
      // }
      // final url = Uri.parse('https://photon.komoot.io/api').replace(queryParameters: queryParams);
      // final response = await http.get(url);
      // List<dynamic> responsedata = jsonDecode(response.body)['features'];
      // setState(() {
      //   addressList = responsedata.map((json) => AddressList.fromJson(json)).toList();
      // });
      Address? existingAddress;
      try {
        existingAddress = mainProvider.searchList.where((address) => address.reference!.toLowerCase().contains(searchQuery.toLowerCase())).first;
      } catch (e) {
        existingAddress = null;
      }

      if (existingAddress != null) {
        List<Address> results = mainProvider.searchList.where((address) => address.reference!.toLowerCase().contains(searchQuery.toLowerCase())).take(5).toList();
        setState(() => addressList = results);
      } else {
        final geoMethods = custom.GeoMethods(googleApiKey: 'AIzaSyD-zFDSMo3Otg25k6NZ0bMZC2xCPIsof5c', language: 'en', country: 'India');
        Future<List<Address>> addressFuture = geoMethods.autocompletePlace(query: searchQuery);
        List<Address> all = await addressFuture;
        mainProvider.saveAddresses(all);
        setState(() => addressList = all);
      }
    }

    final Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
      color: const Color(0xFFF5F5F5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: size.width,
            height: 44,
            // ignore: prefer_const_constructors
            decoration: BoxDecoration(color: Colors.white, border: Border.all(width: 1, color: Color(0xFFD4D4D4)), borderRadius: BorderRadius.circular(9)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: Icon(Icons.search, color: Color(0xFFACA9A9))),
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      if (value.length > 2) {
                        performSearch(value);
                      } else {
                        if (addressList.isNotEmpty) {
                          setState(() => addressList.clear());
                        }
                      }
                    },
                    style: const TextStyle(color: Color(0xFFACA9A9), fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w400),
                    cursorHeight: 20,
                    decoration: const InputDecoration(
                        hintText: 'Enter location name or pin code',
                        contentPadding: EdgeInsets.only(top: -5),
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Color(0xFFACA9A9), fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w400)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          for (var address in addressList) NewLocation(address: address),
          if (addressList.isNotEmpty) const SizedBox(height: 20),
          InkWell(
            onTap: () async {
              mainProvider.innerpageIndex = 2;
              mainProvider.pageType = 1;
              mainProvider.notify();
            },
            child: Row(
              children: [
                Transform.rotate(angle: 45, child: const Icon(Icons.navigation, color: Color(0xFF2F9623))),
                const Text('Use my current location', textScaler: TextScaler.noScaling, style: TextStyle(color: Color(0xFF2F9623), fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w500))
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                const Text('Saved Addresses', style: TextStyle(color: Color(0xFF909090), fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
                for (var i in apiProvider.userAddress)
                  LocationSaved(
                    address: i,
                    onpressed: () {
                      mainProvider.homepageIndex = 0;
                      mainProvider.updatePickedsaved(i);
                    },
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
