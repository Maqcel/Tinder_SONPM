import 'package:flutter/material.dart';
import 'package:tinder/extensions/build_context_extension.dart';
import 'package:tinder/gen/assets.gen.dart';

class LikesScreen extends StatefulWidget {
  const LikesScreen({Key? key}) : super(key: key);

  @override
  _LikesScreenState createState() => _LikesScreenState();
}

class _LikesScreenState extends State<LikesScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      leading: Assets.images.icons.tinderWhite.svg(color: Colors.pink[600]),
    ),
    body: _body(context),
    backgroundColor: Colors.white70,
  );
}

Widget _body(BuildContext context) => Column(
  children: [
    Row(
      children: [
        _likesButton(context),
        _picksButton(context),
      ],
    ),
    _divider(),
    _descriptionFirstLine(),
    _descriptionSecondLine(),
    _namedImagesRow(),
    _blurredImagesRow(),
  ],
);

Widget _picksButton(BuildContext context) => Container(
  child: TextButton(
    child: const Text("10 Top Picks",
        style: TextStyle(fontSize: 20, color: Colors.black)),
    onPressed: () => {},
  ),
  width: MediaQuery.of(context).size.width * 0.5,
  padding: EdgeInsets.only(left: 20.0, top: 20),
);

Widget _likesButton(BuildContext context) => Container(
  child: TextButton(
    child: const Text(
      "15 likes",
      style: TextStyle(
        fontSize: 20,
        color: Colors.black,
      ),
    ),
    onPressed: () => {},
  ),
  width: MediaQuery.of(context).size.width * 0.45,
  padding: EdgeInsets.only(left: 30.0, top: 20),
);

Widget _divider() => const Divider(
    height: 5, thickness: 1, indent: 0, endIndent: 0, color: Colors.grey);

Widget _descriptionFirstLine() => Container(
  child: const Text("Upgrade to Gold to see people",
      style: TextStyle(color: Colors.black)),
  padding: EdgeInsets.only(top: 20),
);

Widget _descriptionSecondLine() => Text(
  "who already liked you",
  style: TextStyle(color: Colors.black),
);

Widget _blurredImagesRow() => Row(
  children: [
    Container(
      width: 150.0,
      height: 200.0,
      margin: EdgeInsets.only(left: 30.0, top: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black,
      ),
    ),
    Container(
      width: 150.0,
      height: 200.0,
      margin: EdgeInsets.only(left: 40.0, top: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blueGrey,
      ),
    )
  ],
);

Widget _namedImagesRow() => Row(
  children: [
    Container(
      width: 150.0,
      height: 200.0,
      margin: EdgeInsets.only(left: 30.0, top: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black,
      ),
    ),
    Container(
        width: 150.0,
        height: 200.0,
        margin: EdgeInsets.only(left: 40.0, top: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blueGrey,
        ),
        child: Container(
          child: const Text(
            "Nikol, 19",
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          padding: new EdgeInsets.only(left: 10.0, top: 160),
        ))
  ],
);
