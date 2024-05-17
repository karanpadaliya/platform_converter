import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/main_Provider.dart';
import 'AndroidScreen/callsPage.dart';
import 'AndroidScreen/chatsPage.dart';
import 'AndroidScreen/profilePage.dart';
import 'AndroidScreen/settingsPage.dart';

class AndroidUi extends StatefulWidget {
  const AndroidUi({Key? key}) : super(key: key);

  @override
  State<AndroidUi> createState() => _AndroidUiState();
}

class _AndroidUiState extends State<AndroidUi> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (BuildContext context, MainProvider value, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Platform Converter"),
            actions: [
              Switch(
                activeColor: Colors.blue,
                activeTrackColor: Colors.blue.withOpacity(0.3),
                value: value.isAndroid,
                onChanged: (newValue) {
                  Provider.of<MainProvider>(context, listen: false)
                      .changePlatform(newValue);
                },
              ),
            ],
          ),
          body: DefaultTabController(
            length: 4, // Number of tabs
            child: Column(
              children: [
                TabBar(
                  // overlayColor: MaterialStatePropertyAll(Colors.red),
                  // padding: EdgeInsets.all(5),
                  indicatorColor: Colors.blue,
                  unselectedLabelColor: Colors.grey,
                  unselectedLabelStyle: TextStyle(
                    fontSize: 13,
                  ),
                  automaticIndicatorColorAdjustment: true,
                  indicatorPadding: EdgeInsets.only(top: 5, left: 5, right: 5),
                  indicatorSize: TabBarIndicatorSize.label,
                  labelPadding: EdgeInsets.only(top: 10, left: 5, right: 20),
                  labelColor: Colors.blue,
                  tabs: [
                    Tab(icon: Icon(Icons.person_add)),
                    Tab(text: "CHATS"),
                    Tab(text: "CALLS"),
                    Tab(text: "SETTINGS"),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      Center(child: ProfilePage()),
                      Center(child: ChatsPage()),
                      Center(child: CallsPage()),
                      Center(child: SettingsPage()),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
