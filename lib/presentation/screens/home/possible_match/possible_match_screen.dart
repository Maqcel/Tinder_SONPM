import 'package:flutter/material.dart';
import 'package:tinder/extensions/build_context_extension.dart';
import 'package:tinder/gen/assets.gen.dart';

class PossibleMatchScreen extends StatefulWidget {
  const PossibleMatchScreen({Key? key}) : super(key: key);

  @override
  _PossibleMatchScreenState createState() => _PossibleMatchScreenState();
}

class _PossibleMatchScreenState extends State<PossibleMatchScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: Assets.images.icons.tinderWhite.svg(color: Colors.pink[600]),
        ),
        body: Center(child: Text(context.localizations.possibleMatchText)),
        backgroundColor: Colors.yellow,
      );
}
