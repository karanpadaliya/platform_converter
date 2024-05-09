import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_converter/controller/IosProvider.dart';
import 'package:platform_converter/controller/main_Provider.dart';
import 'package:platform_converter/view/HomePage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MainPage());
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MainProvider()),
        ChangeNotifierProvider(create: (context) => IosProvider()),
      ],
      builder: (context, child) {
        return Consumer<MainProvider>(
          builder: (BuildContext context, value, Widget? child) {
            if (value.isAndroid) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                initialRoute: "HomePage",
                routes: {
                  "HomePage": (context) => HomePage(),
                },
              );
            } else {
              return Consumer<IosProvider>(
                builder: (BuildContext context, value, Widget? child) {
                  return CupertinoApp(
                    theme: CupertinoThemeData(
                      brightness:
                          value.Theme_Mode ? Brightness.dark : Brightness.light,
                    ),
                    debugShowCheckedModeBanner: false,
                    initialRoute: "/",
                    routes: {
                      "/": (context) => HomePage(),
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
