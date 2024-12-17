import 'package:flutter/material.dart';

class Functions_v2 extends ChangeNotifier {
  Color borderColor = const Color.fromARGB(255, 0, 0, 0);
  Color textColor = const Color.fromARGB(255, 0, 0, 0);
  bool isTriggered = false;
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

  void changeBorderclr() {
    if (isTriggered == true) {
      borderColor = Colors.green; // Change to green
      textColor = Colors.green;
      isTriggered = false;
      notifyListeners(); // Notify listeners to update the UI
    } else if (isTriggered == false) {
      borderColor = const Color.fromARGB(255, 3, 3, 3); // Change to green
      textColor = const Color.fromARGB(255, 0, 0, 0);
      isTriggered = true;
      notifyListeners(); // Notify listeners to update the UI
    }
  }
}
