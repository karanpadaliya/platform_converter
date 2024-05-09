import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_converter/controller/IosProvider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
                            color: CupertinoColors.white,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: CupertinoColors.activeBlue,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: IconButton(
                                    onPressed: () {

                                    },
                                    icon: Icon(
                                      CupertinoIcons.camera,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10,left: 30,right: 30,bottom: 15),
                                  child: CupertinoTextField(
                                    decoration: BoxDecoration(
                                      color: CupertinoColors.lightBackgroundGray.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    placeholder: "Name",
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 30,right: 30,bottom: 20),
                                  child: CupertinoTextField(
                                    decoration: BoxDecoration(
                                      color: CupertinoColors.lightBackgroundGray.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    placeholder: "Bio",
                                  ),
                                ),
                                TextButton(onPressed: (){}, child: Text("Save"))
                              ],
                            ),
                          ),
                        ),
                        CupertinoListTile(
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
