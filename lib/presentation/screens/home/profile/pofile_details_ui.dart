import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  bool editMode = false;
  final myController = TextEditingController();

  Future<void> _changeBio() async {
    if (editMode) {
      // Problemy z cachem
      DocumentReference userReference = FirebaseFirestore.instance
          .collection('users')
          .doc(widget.profile.uid);
      userReference.update({'bio': myController.text});
    }
    setState(() {
      myController.text = widget.profile.bio;
      editMode = !editMode;
    });
  }

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
          editMode
              ? Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    controller: myController,
                    maxLines: 3,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.profile.bio,
                    style: context.theme.textTheme.headline2,
                  ),
                ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: ConstrainedBox(
                constraints: BoxConstraints.tightFor(width: 80, height: 80),
                child: ElevatedButton(
                  onPressed: () {
                    _changeBio();
                  },
                  child: const Text('Edit', style: TextStyle(fontSize: 25)),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9999.0),
                        side: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

//TODO: Texts to separate file