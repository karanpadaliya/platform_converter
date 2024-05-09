import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/main_Provider.dart';

class AndroidUi extends StatefulWidget {
  const AndroidUi({super.key});

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
            title: Text("Platform Converter ${value.isAndroid}"),
            actions: [
              Switch(
                value: value.isAndroid,
                onChanged: (newValue) {
                  Provider.of<MainProvider>(context, listen: false)
                      .changePlatform(newValue);
                },
              ),
            ],
          ),
          body: Text("Android Ui"),
        );
      },
    );
  }
}
