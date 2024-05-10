import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_converter/controller/IosProvider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController ProfileNameController = TextEditingController();
  TextEditingController ProfileBioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: Text("Setting".toUpperCase()),
            leading: Icon(CupertinoIcons.settings),
            stretch: false,
            middle: Text("Custom Setting"),
            alwaysShowMiddle: false,
          ),
          SliverToBoxAdapter(
              // child: Text("All Widget accept here!!!"),
              ),
          SliverFillRemaining(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Consumer<IosProvider>(
                  builder: (BuildContext context, value, Widget? child) {
                    return CupertinoListSection(
                      header: Text("Set Platform".toUpperCase()),
                      children: [
                        CupertinoListTile(
                          padding: EdgeInsets.all(15),
                          leading: Icon(CupertinoIcons.person),
                          title: Text("Profile"),
                          subtitle: Text("Update Profile Data"),
                          trailing: CupertinoSwitch(
                            value: value.isProfile ?? false,
                            onChanged: (newValue) {
                              Provider.of<IosProvider>(context, listen: false)
                                  .showProfile(newValue);
                            },
                          ),
                        ),
                        Visibility(
                          visible:
                              Provider.of<IosProvider>(context).isProfile ??
                                  false,
                          child: Container(
                            height: 300,
                            // color: CupertinoColors.white,
                            child: Column(
                              children: [
                                CupertinoButton(
                                  onPressed: () {
                                    // Show dialog to choose between camera or gallery
                                    showCupertinoDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return CupertinoAlertDialog(
                                          title: Text(
                                            "Choose Image Source",
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                          content: SingleChildScrollView(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                                                        Provider.of<IosProvider>(
                                                                context,
                                                                listen: false)
                                                            .setImage(
                                                                file.path);
                                                        Navigator.pop(context);
                                                      } else {
                                                        // Handle if the user cancels capturing the image
                                                        print(
                                                            'User cancelled capturing image Camera');
                                                      }
                                                    },
                                                    child: Text(
                                                      "Camera",
                                                      style: TextStyle(
                                                          fontSize: 17),
                                                    ),
                                                  ),
                                                  Divider(),
                                                  GestureDetector(
                                                    onTap: () async {
                                                      //   Handle camera option
                                                      XFile? file =
                                                          await ImagePicker()
                                                              .pickImage(
                                                                  source: ImageSource
                                                                      .gallery);
                                                      if (file != null) {
                                                        // Do something with the captured image file
                                                        // For example, you can set it to the provider
                                                        Provider.of<IosProvider>(
                                                                context,
                                                                listen: false)
                                                            .setImage(
                                                                file.path);
                                                        Navigator.pop(context);
                                                      } else {
                                                        print(
                                                            'User cancelled capturing image Gallery');
                                                      }
                                                    },
                                                    child: Text(
                                                      "Gallery",
                                                      style: TextStyle(
                                                          fontSize: 17),
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
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Provider.of<IosProvider>(context).isImage
                                        ? CupertinoColors.activeBlue
                                        : null,
                                    backgroundImage: Provider.of<IosProvider>(context).isImage
                                        ? null
                                        : FileImage(
                                        File(value.XFile ?? "Image_NOT_Found")),
                                    child: CupertinoButton(
                                        child: Icon(
                                          CupertinoIcons.camera,
                                          // color: Colors.white,
                                        ),
                                        onPressed: () {}),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 30, right: 30, bottom: 15),
                                  child: CupertinoTextField(
                                    controller: ProfileNameController,
                                    decoration: BoxDecoration(
                                      color: CupertinoColors.lightBackgroundGray
                                          .withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    placeholder: "Name",
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30, right: 30, bottom: 20),
                                  child: CupertinoTextField(
                                    controller: ProfileBioController,
                                    decoration: BoxDecoration(
                                      color: CupertinoColors.lightBackgroundGray
                                          .withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    placeholder: "Bio",
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
                                        Provider.of<IosProvider>(context, listen: false)
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
                                        if (ProfileNameController
                                                .text.isNotEmpty &&
                                            ProfileBioController
                                                .text.isNotEmpty) {
                                          Provider.of<IosProvider>(context,
                                                  listen: false)
                                              .setProfile(
                                                  ProfileNameController.text,
                                                  ProfileBioController.text);

                                          showCupertinoModalPopup(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return CupertinoActionSheet(
                                                  title: Text("Saved!!!"),
                                                  cancelButton:
                                                      CupertinoActionSheetAction(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("Ok"),
                                                  ),
                                                );
                                              });
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
                        CupertinoListTile(
                          padding: EdgeInsets.all(15),
                          leading: Icon(CupertinoIcons.brightness),
                          title: Text("Theme"),
                          subtitle: Text("Change Theme"),
                          trailing: CupertinoSwitch(
                            value: value.Theme_Mode ?? false,
                            onChanged: (newValue) {
                              Provider.of<IosProvider>(context, listen: false)
                                  .changeTheme();
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
        ],
      ),
    );
  }
}
