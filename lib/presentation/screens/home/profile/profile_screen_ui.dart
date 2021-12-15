import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tinder/config/dimensions/padding_dimension.dart';
import 'package:tinder/config/paths.dart';
import 'package:tinder/config/theme/color_palette.dart';
import 'package:tinder/domain/model/user/user_profile.dart';
import 'package:tinder/extensions/build_context_extension.dart';
import 'package:tinder/presentation/widget/image/saved_state_cached_image.dart';

class ProfileScreenUi extends StatelessWidget {
  final UserProfile _profile;
  final void Function() _toSettings;
  final void Function() _refreshProfileScreen;
  final void Function() _toProfile;

  Future<void> uploadProfilePicture() async {
    ImagePicker imagePicker = ImagePicker();

    XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      File selectedImage = File(image.path);

      Reference ref = FirebaseStorage.instance.ref().child(_profile.uid);
      await ref.putFile(selectedImage);

      String url = await ref.getDownloadURL();

      DocumentReference userReference = FirebaseFirestore.instance
          .collection(Paths.usersPath)
          .doc(_profile.uid);

      await userReference.update({
        'profile_photo_path': url,
      });
    }
  }

  const ProfileScreenUi(UserProfile profile, void Function() toSettings,
      void Function() toProfile, void Function() refreshProfileScreen)
      : _profile = profile,
        _toSettings = toSettings,
        _toProfile = toProfile,
        _refreshProfileScreen = refreshProfileScreen;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: getBody(context),
        backgroundColor: ColorPalette.gray.withOpacity(0.2),
      );

  Widget getBody(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ClipPath(
      clipper: OvalBottomBorderClipper(),
      child: Container(
        width: size.width,
        height: size.height * 0.6,
        decoration: BoxDecoration(color: ColorPalette.white, boxShadow: [
          BoxShadow(
            color: ColorPalette.gray.withOpacity(0.1),
          ),
        ]),
        child: Padding(
          padding: const EdgeInsets.only(
              left: PaddingDimension.large,
              right: PaddingDimension.large,
              bottom: PaddingDimension.large),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 140,
                height: 140,
                margin: const EdgeInsets.only(
                  bottom: PaddingDimension.medium,
                ),
                child: ClipRRect(
                  child: SavedStateNetworkImage(
                    url: _profile.photoUrl,
                    fit: BoxFit.fitHeight,
                    placeholder: (_, __) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  borderRadius: BorderRadius.circular(90),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: PaddingDimension.medium,
                ),
                child: Text(
                  _profile.name +
                      ", " +
                      (DateTime.now().year - _profile.birthDate.year)
                          .toString(),
                  style: context.theme.textTheme.headline2,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: _singleButton(
                      context,
                      context.localizations.settingsText,
                      Icons.settings,
                    ),
                    onTap: () => _toSettings(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: PaddingDimension.medium,
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 85,
                          height: 85,
                          margin: const EdgeInsets.only(
                            bottom: PaddingDimension.small,
                          ),
                          child: Stack(
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      ColorPalette.colorPrimaryBase,
                                      ColorPalette.colorPrimary200,
                                    ],
                                  ),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: ColorPalette.gray.withOpacity(0.2),
                                      blurRadius: 15,
                                      spreadRadius: 10,
                                    ),
                                  ],
                                ),
                                child: IconButton(
                                  icon: const Icon(Icons.camera_alt),
                                  highlightColor: ColorPalette.white,
                                  onPressed: () async {
                                    await uploadProfilePicture();
                                    _refreshProfileScreen();
                                  },
                                ),
                              ),
                              Positioned(
                                right: 0,
                                bottom: 8,
                                child: Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    color: ColorPalette.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            ColorPalette.gray.withOpacity(0.2),
                                        blurRadius: 15,
                                        spreadRadius: 10,
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    color: ColorPalette.colorPrimaryBase,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          context.localizations.addMediaText,
                          style: context.theme.textTheme.bodyText1,
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    child: _singleButton(
                      context,
                      context.localizations.editText,
                      Icons.remove_red_eye,
                    ),
                    onTap: () => _toProfile(),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _singleButton(BuildContext context, String text, IconData icon) {
  return Column(
    children: [
      Container(
        width: 60,
        height: 60,
        margin: const EdgeInsets.only(
          bottom: PaddingDimension.small,
        ),
        decoration: BoxDecoration(
          color: ColorPalette.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: ColorPalette.gray.withOpacity(0.2),
              blurRadius: 15,
              spreadRadius: 10,
            ),
          ],
        ),
        child: Icon(
          icon,
          size: 35,
          color: ColorPalette.gray,
        ),
      ),
      Text(
        text,
        style: context.theme.textTheme.bodyText1,
      )
    ],
  );
}
