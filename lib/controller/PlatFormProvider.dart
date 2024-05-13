import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_converter/modal/DataModal.dart';

class PlatFormProvider extends ChangeNotifier {
  bool? isProfile;


  void showProfile(isProfile) {
    this.isProfile = isProfile;
    notifyListeners();
  }

  bool Android_Theme_Mode = false;
  void change_Android_Theme() {
    Android_Theme_Mode = !Android_Theme_Mode;
    notifyListeners();
  }


  bool Ios_Theme_Mode = false;

  void change_Ios_Theme() {
    Ios_Theme_Mode = !Ios_Theme_Mode;
    notifyListeners();
  }

//   Setting Image Set
  String? XFile;
  void setImage(getImage) {
    XFile = getImage;
  }

//   Profile Image Set
  String? PFile;
  void setPFile(getImage){
    PFile = getImage;
  }

  //Delete profile
  void removeProfile(index){
    profileList.removeAt(index);
    notifyListeners();
  }



//   All Profile Page Data
  String? FullName;
  String? MobileNo;
  String? Chat;
  String? Date;
  String? Time;

  List<DataModal> profileList = [];

  void getProfileDetails([fullName, mobileNo, chat, date, time]){

    profileList.add(DataModal(fullName: fullName, mobileNo: mobileNo, chat: chat, date: date, time: time));

    // FullName = fullName;
    // MobileNo = mobileNo;
    // Chat = chat;
    // Date = date;
    // Time = time;
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

//   set IOS Date and time
  TimeOfDay? time;
  DateTime? date;

  void setTime(TimeOfDay time) {
    this.time = time;
    notifyListeners();
  }
  void setDate(DateTime date) {
    this.date = date;
    notifyListeners();
  }

}