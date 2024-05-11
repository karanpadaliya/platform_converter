import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../controller/AppProvider.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController ProfileNameController = TextEditingController();
  TextEditingController ProfileBioController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize text controllers with values from the provider
    ProfileNameController.text =
        Provider.of<PlatFormProvider>(context, listen: false).ProfileName ?? '';
    ProfileBioController.text =
        Provider.of<PlatFormProvider>(context, listen: false).ProfileBio ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<PlatFormProvider>(
              builder: (BuildContext context, value, Widget? child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    ListTile(
                      leading: Icon(Icons.person),
                      title: Text("Profile"),
                      subtitle: Text("Update Profile Data"),
                      trailing: Switch(
                        value: value.isProfile ?? false,
                        onChanged: (newValue) {
                          Provider.of<PlatFormProvider>(context, listen: false)
                              .showProfile(newValue);
                        },
                      ),
                    ),
                    Visibility(
                      visible:
                          Provider.of<PlatFormProvider>(context).isProfile ??
                              false,
                      child: Container(
                        height: 350,
                        // color: CupertinoColors.white,
                        child: Column(
                          children: [
                            TextButton(
                              onPressed: () {
                                // Show dialog to choose between camera or gallery
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
                                      content: SingleChildScrollView(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ListBody(
                                            children: [
                                              GestureDetector(
                                                onTap: () async {
                                                  XFile? file =
                                                      await ImagePicker()
                                                          .pickImage(
                                                              source:
                                                                  ImageSource
                                                                      .camera);

                                                  if (file != null) {
                                                    // Do something with the captured image file
                                                    // For example, you can set it to the provider
                                                    Provider.of<PlatFormProvider>(
                                                            context,
                                                            listen: false)
                                                        .setImage(file.path);
                                                    Navigator.pop(context);
                                                  } else {
                                                    // Handle if the user cancels capturing the image
                                                    print(
                                                        'User cancelled capturing image Camera');
                                                  }
                                                },
                                                child: Text(
                                                  "Camera",
                                                  style:
                                                      TextStyle(fontSize: 17),
                                                ),
                                              ),
                                              Divider(),
                                              GestureDetector(
                                                onTap: () async {
                                                  //   Handle camera option
                                                  XFile? file =
                                                      await ImagePicker()
                                                          .pickImage(
                                                              source:
                                                                  ImageSource
                                                                      .gallery);
                                                  if (file != null) {
                                                    // Do something with the captured image file
                                                    // For example, you can set it to the provider
                                                    Provider.of<PlatFormProvider>(
                                                            context,
                                                            listen: false)
                                                        .setImage(file.path);
                                                    Navigator.pop(context);
                                                  } else {
                                                    print(
                                                        'User cancelled capturing image Gallery');
                                                  }
                                                  setState(() {});
                                                },
                                                child: Text(
                                                  "Gallery",
                                                  style:
                                                      TextStyle(fontSize: 17),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Stack(
                                children: [
                                  Consumer<PlatFormProvider>(
                                    builder: (BuildContext context, value,
                                        Widget? child) {
                                      return CircleAvatar(
                                        radius: 50,
                                        backgroundColor:
                                            Provider.of<PlatFormProvider>(
                                                        context,
                                                        listen: false)
                                                    .isImage
                                                ? Colors.blue
                                                : null,
                                        backgroundImage:
                                            Provider.of<PlatFormProvider>(
                                                        context)
                                                    .isImage
                                                ? null
                                                : FileImage(
                                                    File(value.XFile ??
                                                        "Image_NOT_Found"),
                                                  ),
                                      );
                                    },
                                  ),
                                  Positioned(
                                    top: 65,
                                    left: 65,
                                    // bottom: 20,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.add_circle,
                                        // color: Colors.blue,
                                        size: 25,
                                      ),
                                      onPressed: () {},
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 5, left: 30, right: 30),
                              child: TextFormField(
                                controller: ProfileNameController,
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  label: Text("Name"),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 30, right: 30, bottom: 5),
                              child: TextFormField(
                                controller: ProfileBioController,
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  label: Text("Bio"),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    ProfileNameController.clear();
                                    ProfileBioController.clear();
                                    Provider.of<PlatFormProvider>(context,
                                            listen: false)
                                        .clearImage();
                                  },
                                  child: Text(
                                    "Reset",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // String? ProfileName = ProfileNameController.text;
                                    if (ProfileNameController.text.isNotEmpty &&
                                        ProfileBioController.text.isNotEmpty) {
                                      Provider.of<PlatFormProvider>(context,
                                              listen: false)
                                          .setProfile(
                                              ProfileNameController.text,
                                              ProfileBioController.text);

                                      // Show dialog indicating that data is saved
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text("Saved !!!"),
                                            content: Text(
                                                "Your profile data has been saved."),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(
                                                      context); // Close the dialog
                                                },
                                                child: Text("Ok"),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                      print(
                                          "Name= ${ProfileNameController.text} AND Bio= ${ProfileBioController.text}");
                                    } else {
                                      print("Field is Blank");
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
                    ListTile(
                      leading: Icon(Icons.brightness_6),
                      title: Text("Theme"),
                      subtitle: Text("Change Theme"),
                      trailing: Switch(
                        value: value.Android_Theme_Mode ?? false,
                        onChanged: (newValue) {
                          Provider.of<PlatFormProvider>(context, listen: false)
                              .change_Android_Theme();
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
