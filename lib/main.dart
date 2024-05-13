import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_converter/controller/PlatFormProvider.dart';
import 'package:platform_converter/controller/main_Provider.dart';
import 'package:platform_converter/view/HomePage.dart';
import 'package:platform_converter/view/HomePage/AndroidScreen/callsPage.dart';
import 'package:platform_converter/view/HomePage/AndroidScreen/chatsPage.dart';
import 'package:platform_converter/view/HomePage/AndroidScreen/profilePage.dart';
import 'package:platform_converter/view/HomePage/AndroidScreen/settingsPage.dart';
import 'package:platform_converter/view/HomePage/IosScreen/IosChatsPage.dart';
import 'package:platform_converter/view/HomePage/IosScreen/IosProfilePage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MainPage());
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MainProvider()),
        ChangeNotifierProvider(create: (context) => PlatFormProvider()),
      ],
      builder: (context, child) {
        return Consumer<MainProvider>(
          builder: (BuildContext context, MainProvider value, Widget? child) {
            if (value.isAndroid) {
              return Consumer<PlatFormProvider>(
                builder: (BuildContext context, PlatFormProvider value,
                    Widget? child) {
                  // Debugging: Check if the correct theme mode is received
                  print('Theme mode for Android: ${value.Android_Theme_Mode}');
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    initialRoute: "HomePage",
                    theme: value.Android_Theme_Mode
                        ? ThemeData(brightness: Brightness.dark)
                        : ThemeData(brightness: Brightness.light),
                    routes: {
                      "HomePage": (context) => HomePage(),
                      "ProfilePage": (context) => ProfilePage(),
                      "ChatsPage": (context) => ChatsPage(),
                      "CallsPage": (context) => CallsPage(),
                      "SettingsPage": (context) => SettingsPage(),
                    },
                  );
                },
              );
            } else {
              return Consumer<PlatFormProvider>(
                builder: (BuildContext context, PlatFormProvider value,
                    Widget? child) {
                  // Debugging: Check if the correct theme mode is received
                  print('Theme mode for iOS: ${value.Ios_Theme_Mode}');
                  return CupertinoApp(
                    theme: CupertinoThemeData(
                      brightness: value.Ios_Theme_Mode
                          ? Brightness.dark
                          : Brightness.light,
                    ),
                    debugShowCheckedModeBanner: false,
                    initialRoute: "/",
                    routes: {
                      "/": (context) => HomePage(),
                      "IosChatsPage": (context) => IosChatsPage(),
                      "IosProfilePage": (context) => IosProfilePage(),
                    },
                  );
                },
              );
            }
          },
        );
      },
    );
  }
}
