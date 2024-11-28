import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:gogreen_lite/Allproviders/api_provider.dart';
import 'package:gogreen_lite/Allproviders/main_provider.dart';
import 'package:gogreen_lite/Allproviders/object.dart';
import 'package:provider/provider.dart';

bool show = false;
TextEditingController address = TextEditingController();
TextEditingController landmark = TextEditingController();
TextEditingController address2 = TextEditingController();

class AddressEdit extends StatefulWidget {
  const AddressEdit({super.key});
  @override
  State<AddressEdit> createState() => _AddressEditState();
}

class _AddressEditState extends State<AddressEdit> {
  @override
  void initState() {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    UserAddress? edit = mainProvider.currentEdit;
    Placemark? place = mainProvider.pickedAddress;
    if (edit != null) {
      setState(() {
        address = TextEditingController(text: edit.address);
        landmark = TextEditingController(text: edit.landmark);
      });
    }
    if (place != null) address2 = TextEditingController(text: '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final mainProvider = Provider.of<MainProvider>(context);
    final apiProvider = Provider.of<ApiProvider>(context);
    Placemark? place = mainProvider.pickedAddress;
    return Container(
      color: const Color(0xFFF6F6F6),
      width: size.width,
      height: size.height,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: place == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Located place', style: TextStyle(color: Color(0xFF909090), fontSize: 12, fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
                          Row(
                            children: [
                              Image.asset('assets/icons/location.png', height: 40),
                              const SizedBox(width: 10),
                              Text(place.subLocality ?? '', style: const TextStyle(color: Color(0xFF1D2730), fontSize: 16, fontFamily: 'Poppins', fontWeight: FontWeight.w700)),
                            ],
                          ),
                          Text('${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}',
                              style: const TextStyle(color: Color(0xFF1D2730), fontSize: 11.5, fontFamily: 'Poppins', fontWeight: FontWeight.w400))
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(12, 12, 12, 20),
                        margin: const EdgeInsets.only(top: 30),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                        child: IntrinsicHeight(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('HOUSE/FLAT/BLOCK NO. *', style: TextStyle(color: Color(0xFF909090), fontSize: 10, fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
                              TextField(
                                decoration: const InputDecoration(border: InputBorder.none),
                                maxLines: null,
                                controller: address,
                                onChanged: (val) {
                                  if (val.isNotEmpty && !show) {
                                    setState(() {
                                      show = true;
                                    });
                                  } else if (val.isEmpty && show) {
                                    setState(() {
                                      show = false;
                                    });
                                  }
                                },
                              ),
                              Container(height: 1.2, margin: const EdgeInsets.only(bottom: 10), color: const Color(0x111D2730)),
                              const Text('LANDMARK (OPTIONAL)', style: TextStyle(color: Color(0xFF909090), fontSize: 10, fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
                              Flexible(
                                  child: TextField(
                                decoration: const InputDecoration(border: InputBorder.none),
                                maxLines: null,
                                controller: landmark,
                                style: const TextStyle(fontSize: 13),
                              )),
                              Container(height: 1.2, margin: const EdgeInsets.only(bottom: 10), color: const Color(0x111D2730)),
                              const Text('STREET/ROAD/AREA (OPTIONAL)', style: TextStyle(color: Color(0xFF909090), fontSize: 10, fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
                              Flexible(
                                  child: TextField(
                                decoration: const InputDecoration(border: InputBorder.none),
                                maxLines: null,
                                controller: address2,
                                style: const TextStyle(fontSize: 13),
                              )),
                              Container(height: 1.2, color: const Color(0x111D2730)),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                !show
                    ? Container(
                        height: 50,
                        width: size.width,
                        margin: const EdgeInsets.only(bottom: 30),
                        decoration: ShapeDecoration(
                          color: const Color(0xFFE9CDBE),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Center(child: Text('Save', style: TextStyle(color: Colors.white, fontSize: 13, fontFamily: 'Poppins', fontWeight: FontWeight.w600))),
                      )
                    : Container(
                        height: 50,
                        width: size.width,
                        margin: const EdgeInsets.only(bottom: 30),
                        decoration: ShapeDecoration(
                          color: const Color(0xFFF28B51),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: MaterialButton(
                            onPressed: () {
                              if (address.text.isNotEmpty) {
                                apiProvider.updateaddAddressReload(true);
                                mainProvider.menupagetype = 1;
                                mainProvider.notify();
                                apiProvider.updateAddress(
                                  id: mainProvider.currentEdit!.id,
                                  address: address.text,
                                  addressline: address2.text,
                                  landmark: landmark.text,
                                  latitude: mainProvider.lat!.latitude,
                                  longitude: mainProvider.lat!.logitude,
                                );
                              }
                            },
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            child: const Text('Save', style: TextStyle(color: Colors.white, fontSize: 13, fontFamily: 'Poppins', fontWeight: FontWeight.w600))),
                      )
              ],
            ),
    );
  }
}
