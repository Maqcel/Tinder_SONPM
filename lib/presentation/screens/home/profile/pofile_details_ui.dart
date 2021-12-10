import 'package:flutter/material.dart';
import 'package:tinder/config/theme/color_palette.dart';
import 'package:tinder/domain/model/user/user_profile.dart';
import 'package:tinder/extensions/build_context_extension.dart';
import 'package:tinder/gen/assets.gen.dart';
import 'package:tinder/presentation/widget/image/saved_state_cached_image.dart';

class ProfileDetails extends StatefulWidget {
  final UserProfile profile;
  const ProfileDetails({Key? key, required this.profile}) : super(key: key);

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Assets.images.icons.tinderWhite
            .svg(color: ColorPalette.colorPrimary100),
        title: Align(
          child: Text("Account", style: context.theme.textTheme.headline2),
          alignment: Alignment.centerLeft,
        ),
      ),
      backgroundColor: ColorPalette.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: ClipRRect(
              child: SavedStateNetworkImage(
                url: widget.profile.photoUrl,
                fit: BoxFit.fitHeight,
                placeholder: (_, __) => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.profile.name +
                  ", " +
                  (DateTime.now().year - widget.profile.birthDate.year)
                      .toString(),
              style: context.theme.textTheme.headline1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.profile.bio,
              style: context.theme.textTheme.headline2,
            ),
          )
        ],
      ),
    );
  }
}

//TODO: Texts to separate file