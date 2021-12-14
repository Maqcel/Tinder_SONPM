import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder/domain/model/possible_match/possible_match.dart';
import 'package:tinder/presentation/screens/home/chat/widgets/swiping_cards_placeholder.dart';
import 'package:tinder/presentation/screens/main/navigation/cubit/main_navigation_cubit.dart';
import 'package:tinder/presentation/widget/image/saved_state_cached_image.dart';

class LikesScreen extends StatefulWidget {
  final List<PossibleMatch> _matchList;

  const LikesScreen({
    Key? key,
    required List<PossibleMatch> matchList,
  })  : _matchList = matchList,
        super(key: key);

  @override
  _LikesScreenState createState() => _LikesScreenState();
}

class _LikesScreenState extends State<LikesScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: widget._matchList.isEmpty
            ? const SwipingCardPlaceholder(isPossibleMatchesScreen: true)
            : _body(),
        backgroundColor: Colors.white70,
      );

  Widget _body() => GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 175,
          childAspectRatio: 1 / 1,
          crossAxisSpacing: 40,
          mainAxisSpacing: 50),
      itemCount: widget._matchList.length,
      itemBuilder: (context, index) => _matchTile(widget._matchList[index]));

  void toProfile(PossibleMatch profile) =>
      context.read<MainNavigationCubit>().matchProfileDetails(profile);

  Widget _matchTile(PossibleMatch match) => GestureDetector(
        child: Card(
          borderOnForeground: false,
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              ClipRRect(
                child: SavedStateNetworkImage(
                  url: match.photoUrl,
                  fit: BoxFit.fitHeight,
                  placeholder: (_, __) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
              Text(
                match.name +
                    ',' +
                    (DateTime.now().year - match.birth_date.year).toString(),
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          ),
        ),
        onTap: () => toProfile(match),
      );
}
