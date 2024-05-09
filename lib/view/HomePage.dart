import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_converter/controller/main_Provider.dart';
import 'package:platform_converter/view/HomePage/AndroidUi.dart';
import 'package:platform_converter/view/HomePage/IosUi.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (BuildContext context, value, Widget? child) {
        if (value.isAndroid == true) {
          return AndroidUi();
        } else {
          return IosUi();
        }
        // return ;
      },
    );
  }
}