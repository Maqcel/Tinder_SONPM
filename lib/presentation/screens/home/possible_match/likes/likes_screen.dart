import 'package:flutter/material.dart';
import 'package:tinder/domain/model/possible_match/possible_match.dart';
import 'package:tinder/extensions/build_context_extension.dart';
import 'package:tinder/gen/assets.gen.dart';

class LikesScreen extends StatefulWidget {
  final String descriptionTextPartOne;
  final String descriptionTextPartTwo;
  final String screenType; // `likes` or `picks`
  final List<PossibleMatch> matchList;

  const LikesScreen({
    Key? key,
    required this.descriptionTextPartOne,
    required this.descriptionTextPartTwo,
    required this.screenType,
    required this.matchList,
  }) : super(key: key);

  @override
  _LikesScreenState createState() => _LikesScreenState();
}

class _LikesScreenState extends State<LikesScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: _body(),
        backgroundColor: Colors.white70,
      );



  Widget _body() => GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      itemCount: widget.matchList.length,
      itemBuilder: (context, index) => _matchTile(widget.matchList[index]));

  Widget _descriptionFirstLine() => Container(
        // TODO: why I can't access variables from `LikesScreen`
        child: Text("Upgrade to Gold to see people",
            style: TextStyle(color: Colors.black)),
        padding: EdgeInsets.only(top: 20),
      );

  Widget _descriptionSecondLine() => Text(
        "who already liked you",
        style: TextStyle(color: Colors.black),
      );

  Widget _textCard() => Card();

  Widget _matchTile(PossibleMatch match) => GestureDetector(
          child: Card(
              child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Image.network(match.photoUrl),
          Text(match.name + ',' + match.birth_date.toString()),
        ],
      )));
}
