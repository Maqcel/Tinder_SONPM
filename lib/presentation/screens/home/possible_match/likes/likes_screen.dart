import 'package:flutter/material.dart';
import 'package:tinder/domain/model/possible_match/possible_match.dart';
import 'package:tinder/extensions/build_context_extension.dart';
import 'package:tinder/gen/assets.gen.dart';
import 'package:tinder/presentation/widget/image/saved_state_cached_image.dart';

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


  Widget _matchTile(PossibleMatch match) => GestureDetector(
          child: Card(
              child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          SavedStateNetworkImage(
            url: match.photoUrl,
            fit: BoxFit.fill,
            placeholder: (_, __) => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
          Text(match.name + ',' + (DateTime.now().year - match.birth_date.year)
              .toString(), style: const TextStyle(color: Colors.black, fontSize: 20),),
        ],
      )));
}
