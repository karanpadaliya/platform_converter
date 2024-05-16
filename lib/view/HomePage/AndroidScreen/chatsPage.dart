import 'dart:io';

import 'package:flutter/material.dart';
import 'package:platform_converter/controller/PlatFormProvider.dart';
import 'package:platform_converter/modal/DataModal.dart';
import 'package:provider/provider.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chats"),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Search bar
          SizedBox(
            height: 57,
            width: 400,
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ),
          Consumer<PlatFormProvider>(
            builder:
                (BuildContext context, PlatFormProvider value, Widget? child) {
              if (value.profileList.isEmpty) {
                return Expanded(
                  child: Center(
                    child: Image.asset("assets/images/noChats.png"),
                  ),
                );
              } else {
                return Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Container(
                      height: 600,
                      // color: Colors.red,
                      child: _consumer(),
                    ),
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }

  Consumer _consumer() {
    return Consumer<PlatFormProvider>(
      builder: (BuildContext context, PlatFormProvider value, Widget? child) {
        return Container(
          child: ListView.builder(
            itemCount: value.profileList.length,
            itemBuilder: (context, index) {
              DataModal profile = value.profileList[index];
              // var backgroundImage =
              //     Provider.of<PlatFormProvider>(context, listen: false).PFile;
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    'ViewContact',
                    arguments: value.profileList[index],
                  );
                },
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: FileImage(File(profile.image??"")),
                  ),
                  title: Text(profile.fullName ?? "Contact_Name_Not_Found"),
                  subtitle:
                      Text(profile.mobileNo ?? "Contact_MobileNo_Not_Found"),
                  trailing: PopupMenuButton(
                    elevation: 10,
                    position: PopupMenuPosition.under,
                    // splashRadius: 50,
                    surfaceTintColor: Colors.white,
                    color: Colors.white.withOpacity(0.9),
                    // enableFeedback: true,
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          child: InkWell(
                            onTap: () {
                              Provider.of<PlatFormProvider>(context,listen: false).removeProfile(index);
                              Navigator.pop(context);
                            },
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                                Text("Delete"),
                              ],
                            ),
                          ),
                        ),
                      ];
                    },
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
