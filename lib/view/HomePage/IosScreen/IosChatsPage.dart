import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_converter/controller/PlatFormProvider.dart';
import 'package:platform_converter/modal/DataModal.dart';
import 'package:provider/provider.dart';

class IosChatsPage extends StatefulWidget {
  const IosChatsPage({Key? key});

  @override
  State<IosChatsPage> createState() => _IosChatsPageState();
}

class _IosChatsPageState extends State<IosChatsPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Chats"),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Search bar
          SizedBox(
            height: 57,
            width: 400,
            child: CupertinoTextField(
              placeholder: "Search",
              prefix: const Icon(CupertinoIcons.search),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: CupertinoColors.lightBackgroundGray),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                // height: 600, // Removed fixed height
                // color: Colors.red,
                child: _consumer(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Consumer _consumer() {
    return Consumer<PlatFormProvider>(
      builder: (BuildContext context, PlatFormProvider value, Widget? child) {
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: value.profileList.length,
          itemBuilder: (context, index) {
            DataModal profile = value.profileList[index];
            return CupertinoListTile(
              leading: CircleAvatar(
                backgroundImage:
                    FileImage(File(value.PFile ?? "Image_Not_Found")),
              ),
              title: Text(profile.fullName ?? "Contact_Name_Not_Found"),
              subtitle: Text(profile.mobileNo ?? "Contact_MobileNo_Not_Found"),
              trailing: CupertinoButton(
                onPressed: () {
                  Provider.of<PlatFormProvider>(context, listen: false)
                      .removeProfile(index);
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      CupertinoIcons.delete,
                      color: CupertinoColors.systemRed,
                    ),
                    Text("Delete"),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
