import 'package:flutter/cupertino.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(child: Text("No any chats yet...")),
    );
  }
}
