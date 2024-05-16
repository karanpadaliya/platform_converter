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
            Consumer<PlatFormProvider>(
              builder: (BuildContext context, PlatFormProvider value, Widget? child) {
                return TextButton(
                  onPressed: () => _selectDate(context),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        Icon(Icons.date_range),
                        Text('Date: ${selectedDate != null ? selectedDate!.day.toString() : "No Date Selected"}'),
                        Text('Time: ${selectedTime != null ? selectedTime!.format(context) : "No Time Selected"}'),
                      ],
                    ),
                  ),
                );
              },
            ),

            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 80,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: DateTime.now(),
                minimumYear: 1900,
                maximumYear: 2101,
                onDateTimeChanged: (DateTime value) {
                  // Handle the selected date here
                  Provider.of<PlatFormProvider>(context, listen: false)
                      .setDate(value);
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
                height: 80,
                child: CupertinoTimerPicker(
                  mode: CupertinoTimerPickerMode.hms,
                  initialTimerDuration:
                  Duration(hours: 0, minutes: 0, seconds: 0),
                  onTimerDurationChanged: (value) {
                    // Handle the selected timer duration here
                    Provider.of<PlatFormProvider>(context, listen: false)
                        .setTime(value);
                  },
                )),
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
    if (proFullNameController.text.isNotEmpty &&
        proMobileNoController.text.isNotEmpty &&
        proChatController.text.isNotEmpty &&
        selectedDate != null &&
        selectedTime != null &&
        file != null) {
      Provider.of<PlatFormProvider>(context, listen: false).getProfileDetails(
        proFullNameController.text,
        proMobileNoController.text,
        proChatController.text,
        selectedDate!.toString(),
        selectedTime!.format(context),
        file?.path,
      );

      // Reset text controllers
      proFullNameController.clear();
      proMobileNoController.clear();
      proChatController.clear();
      Provider.of<PlatFormProvider>(
        context,
        listen: false,
      ).setPFile(null);

      // Reset date and time
      setState(() {
        selectedDate = null;
        selectedTime = null;
      });

      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('Saved !!!'),
            content: Text('Your profile data has been saved.'),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Ok'),
              ),
            ],
          );
        },
      );
    } else {
      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return CupertinoActionSheet(
            title: Column(
              children: [
                Text('fullname is Blank ${proFullNameController.text}'),
                Text('mobile is Blank ${proMobileNoController.text}'),
                Text('chat is Blank ${proChatController.text}'),
                Text('date is Blank ${selectedDate ?? "null Date"}'),
                Text('Time is Blank ${selectedTime??"null Time"}'),
                Text('image is Blank ${file?.path}'),
              ],
            ),
            actions: [
              CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Ok'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }
}