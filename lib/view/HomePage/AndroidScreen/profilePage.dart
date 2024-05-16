import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../controller/PlatFormProvider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController Pro_Full_Name_Controller = TextEditingController();
  TextEditingController Pro_Mobile_No_Controller = TextEditingController();
  TextEditingController Pro_Chat_Controller = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  XFile? file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          "Choose Image Source",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        content: Consumer<PlatFormProvider>(
                          builder:
                              (BuildContext context, value, Widget? child) {
                            return SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListBody(
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        file = await ImagePicker().pickImage(
                                          source: ImageSource.camera,
                                        );

                                        if (file != null) {
                                          Provider.of<PlatFormProvider>(
                                            context,
                                            listen: false,
                                          ).setPFile(file!.path);
                                          Navigator.pop(context);
                                        } else {
                                          print(
                                              'User cancelled capturing image Camera');
                                        }
                                        setState(() {});
                                      },
                                      child: Text(
                                        "Camera",
                                        style: TextStyle(fontSize: 17),
                                      ),
                                    ),
                                    Divider(),
                                    GestureDetector(
                                      onTap: () async {
                                        file = await ImagePicker().pickImage(
                                          source: ImageSource.gallery,
                                        );

                                        if (file != null) {
                                          Provider.of<PlatFormProvider>(
                                            context,
                                            listen: false,
                                          ).setPFile(file!.path);
                                          Navigator.pop(context);
                                        } else {
                                          print(
                                              'User cancelled capturing image Camera');
                                        }
                                        setState(() {});
                                      },
                                      child: Text(
                                        "Gallery",
                                        style: TextStyle(fontSize: 17),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
                child: Consumer<PlatFormProvider>(
                  builder: (BuildContext context, value, Widget? child) {
                    return Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: Provider.of<PlatFormProvider>(
                            context,
                          ).isImage
                              ? null
                              : FileImage(
                                  File(value.PFile ?? "Image_NOT_Found"),
                                ),
                        ),
                        Positioned(
                          top: 65,
                          left: 65,
                          child: IconButton(
                            icon: Icon(
                              Icons.add_circle,
                              size: 25,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 30, right: 30),
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  maxLength: 30,
                  controller: Pro_Full_Name_Controller,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                    label: Text("Full Name"),
                    counterText: '',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 30,
                  right: 30,
                  bottom: 5,
                ),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  maxLength: 10,
                  controller: Pro_Mobile_No_Controller,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(),
                    label: Text("Phone Number"),
                    counterText: '',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 30,
                  right: 30,
                  bottom: 5,
                ),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  maxLength: 80,
                  maxLines: 2,
                  controller: Pro_Chat_Controller,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.chat),
                    border: OutlineInputBorder(),
                    label: Text("Chat Conversation"),
                    counterText: '',
                  ),
                ),
              ),
              // Date picker button
              TextButton(
                onPressed: () => _selectDate(context),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Icon(Icons.date_range),
                      Text(
                        selectedDate == null
                            ? 'Select Date'
                            : 'Date: ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                      ),
                    ],
                  ),
                ),
              ),
              // Time picker button
              TextButton(
                onPressed: () => _selectTime(context),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 0),
                  child: Row(
                    children: [
                      Icon(Icons.access_time),
                      Text(
                        selectedTime == null
                            ? 'Select Time'
                            : 'Time: ${selectedTime!.hour}:${selectedTime!.minute}',
                      ),
                    ],
                  ),
                ),
              ),

              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      if (Pro_Full_Name_Controller.text.isNotEmpty &&
                          Pro_Mobile_No_Controller.text.isNotEmpty &&
                          Pro_Chat_Controller.text.isNotEmpty &&
                          selectedDate != null &&
                          selectedTime != null &&
                          file != null) {
                        Provider.of<PlatFormProvider>(
                          context,
                          listen: false,
                        ).getProfileDetails(
                          Pro_Full_Name_Controller.text,
                          Pro_Mobile_No_Controller.text,
                          Pro_Chat_Controller.text,
                          selectedDate!.toString(),
                          selectedTime!.format(context),
                          file?.path,
                        );

                        // Reset text controllers
                        Pro_Full_Name_Controller.clear();
                        Pro_Mobile_No_Controller.clear();
                        Pro_Chat_Controller.clear();
                        file = null;
                        Provider.of<PlatFormProvider>(
                          context,
                          listen: false,
                        ).setPFile(null);

                        // Clear selected date and time
                        setState(() {
                          selectedDate = null;
                          selectedTime = null;
                        });

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Saved !!!"),
                              content:
                                  Text("Your profile data has been saved."),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Ok"),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              children: [
                                Icon(
                                  Icons.warning_amber,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Field is Blank"),
                              ],
                            ),
                          ),
                        );
                      }
                    },
                    child: Text(
                      "Save",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime)
      setState(() {
        selectedTime = picked;
      });
  }
}
