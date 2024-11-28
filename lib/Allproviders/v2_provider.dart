import 'package:flutter/material.dart';

class CourcelProvider_1 extends ChangeNotifier {
  // for carosel slider dots index
  int caroselindex = 0;
  void updateCaroselindex(int val) {
    caroselindex = val;
    notifyListeners();
  }

  //for cat selection
  int catselcted = 0;
  void updateCatselcted(int val) {
    catselcted = val;
    notifyListeners();
  }

  // for accept term
  bool accept = false;
  void toggleAccept() {
    accept = !accept;
    notifyListeners();
  }
}
