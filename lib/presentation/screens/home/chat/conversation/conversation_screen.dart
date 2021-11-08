import 'package:flutter/material.dart';
import 'package:tinder/presentation/widget/appbar/cancel_icon_button.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({Key? key}) : super(key: key);

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const CancelIconButton()),
      backgroundColor: Colors.amber,
      body: const Center(
        child: Text('Conversation Screen'),
      ),
    );
  }
}
