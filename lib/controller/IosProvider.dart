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
    Theme_Mode = !Theme_Mode;
    notifyListeners();
  }

//   Image Set
  String? XFile;

  void setImage(getImage) {
    XFile = getImage;
  }

// Method to clear the image-related data
  void clearImage() {
    XFile = null; // Clear the image file path
    isImage = false; // Update the flag indicating whether an image is present
    notifyListeners();
  }

//   Profile Name, Bio
  String? ProfileName;
  String? ProfileBio;

  void setProfile(String Name, String Bio) {
    ProfileName = Name;
    ProfileBio = Bio;
  }

  bool isImage = false;

  void removeImg(img) {
    isImage = img;
  }
}
