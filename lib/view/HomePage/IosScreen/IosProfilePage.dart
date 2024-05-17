import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../controller/PlatFormProvider.dart';

class IosProfilePage extends StatefulWidget {
  const IosProfilePage({Key? key});

  @override
  State<IosProfilePage> createState() => _IosProfilePageState();
}

class _IosProfilePageState extends State<IosProfilePage> {
  TextEditingController proFullNameController = TextEditingController();
  TextEditingController proMobileNoController = TextEditingController();
  TextEditingController proChatController = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  XFile? file;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Profile'),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            CupertinoButton(
              onPressed: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (BuildContext context) {
                    return CupertinoActionSheet(
                      title: Text(
                        'Choose Image Source',
                        style: TextStyle(fontSize: 20),
                      ),
                      actions: [
                        CupertinoActionSheetAction(
                          onPressed: () async {
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
                              print('User cancelled capturing image Camera');
                            }
                          },
                          child: Text('Camera'),
                        ),
                        CupertinoActionSheetAction(
                          onPressed: () async {
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
                              print('User cancelled capturing image Camera');
                            }
                          },
                          child: Text('Gallery'),
                        ),
                      ],
                      cancelButton: CupertinoActionSheetAction(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel'),
                      ),
                    );
                  },
                );
              },
              child: Consumer<PlatFormProvider>(
                builder: (context, value, child) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 150),
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: value.isImage
                              ? null
                              : FileImage(
                            File(value.PFile ?? "Image_NOT_Found"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 60, left: 60),
                          child: IconButton(
                            icon: Icon(
                              CupertinoIcons.add_circled,
                              size: 25,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 30, right: 30),
              child: CupertinoTextField(
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                maxLength: 30,
                controller: proFullNameController,
                placeholder: 'Full Name',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
              child: CupertinoTextField(
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                maxLength: 10,
                controller: proMobileNoController,
                placeholder: 'Phone Number',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
              child: CupertinoTextField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                maxLength: 80,
                maxLines: 2,
                controller: proChatController,
                placeholder: 'Chat Conversation',
              ),
            ),

            SizedBox(
              height: 10,
            ),

            // Date picker button
            CupertinoButton(
              onPressed: () => _selectDate(context),
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    Icon(CupertinoIcons.calendar),
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
            CupertinoButton(
              onPressed: () => _selectTime(context),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 0),
                child: Row(
                  children: [
                    Icon(CupertinoIcons.clock),
                    Text(
                      selectedTime == null
                          ? 'Select Time'
                          : 'Time: ${selectedTime!.hour}:${selectedTime!.minute}',
                    ),
                  ],
                ),
              ),
            ),
            CupertinoButton(
              onPressed: () {
                _saveProfile(context);
              },
              child: Text(
                'Save',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveProfile(BuildContext context) {
    // Your save profile logic here
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
