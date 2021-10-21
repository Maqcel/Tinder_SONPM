import 'package:flutter/material.dart';
import 'package:tinder/extensions/build_context_extension.dart';
import 'package:tinder/gen/assets.gen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: Assets.images.icons.tinderWhite.svg(color: Colors.pink[600]),
        ),
        body: Center(child: Text(context.localizations.profileText)),
        backgroundColor: Colors.teal,
      );
}
