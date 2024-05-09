import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_converter/view/HomePage/IosScreen/CallsPage.dart';
import 'package:platform_converter/view/HomePage/IosScreen/ChatsPage.dart';
import 'package:platform_converter/view/HomePage/IosScreen/ProfilePage.dart';
import 'package:platform_converter/view/HomePage/IosScreen/SettingsPage.dart';
import 'package:provider/provider.dart';

import '../../controller/main_Provider.dart';

class IosUi extends StatefulWidget {
  const IosUi({super.key});

  @override
  State<IosUi> createState() => _IosUiState();
}

class _IosUiState extends State<IosUi> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (BuildContext context, MainProvider value, Widget? child) {
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: Text("Platform Converter"),
            trailing: CupertinoSwitch(
              value: value.isAndroid,
              onChanged: (newValue) {
                Provider.of<MainProvider>(context, listen: false)
                    .changePlatform(newValue);
              },
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: CupertinoTabScaffold(
                  tabBar: CupertinoTabBar(
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.person_add),
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.chat_bubble_2),
                        label: 'Chats'.toUpperCase(),
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.phone),
                        label: 'Calls'.toUpperCase(),
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.settings),
                        label: 'Settings'.toUpperCase(),
                      ),
                    ],
                  ),
                  tabBuilder: (BuildContext context, int index) {
                    return CupertinoTabView(
                      builder: (BuildContext context) {
                        switch (index) {
                          case 0:
                            return ProfilePage();
                          case 1:
                            return ChatsPage();
                          case 2:
                            return CallsPage();
                          case 3:
                            return SettingsPage();
                          default:
                            return Text("Geting Error on IOS");
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
