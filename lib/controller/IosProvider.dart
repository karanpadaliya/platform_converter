import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IosProvider extends ChangeNotifier {
  bool? isProfile;

  bool Theme_Mode = false;

  void showProfile(isProfile) {
    this.isProfile = isProfile;
    notifyListeners();
  }

  void changeTheme() {
   Theme_Mode =! Theme_Mode;
    notifyListeners();
  }
}
