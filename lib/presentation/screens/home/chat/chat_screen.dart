import 'package:flutter/material.dart';
import 'package:tinder/extensions/build_context_extension.dart';
import 'package:tinder/gen/assets.gen.dart';
import 'new_pairs.dart';
import 'recent_chats.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      leading: Assets.images.icons.tinderWhite.svg(color: Colors.pink[600]),
    ),
    body: SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            children: <Widget>[NewPairs(), RecentChats()],
          ),
      )
    )
  );
}