import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:tinder/config/theme/color_palette.dart';
import 'package:tinder/config/dimensions/padding_dimension.dart';
import 'package:tinder/domain/model/user/user_profile.dart';
import 'package:tinder/extensions/build_context_extension.dart';
import 'package:tinder/gen/assets.gen.dart';
import 'package:tinder/presentation/widget/image/saved_state_cached_image.dart';

class ProfileScreenUi extends StatelessWidget {
  final UserProfile _profile;
  final void Function() _toSettings;

  const ProfileScreenUi(UserProfile profile, void Function() toSettings)
      : _profile = profile,
        _toSettings = toSettings;

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
                                child: const Icon(
                                  Icons.camera_alt,
                                  size: 45,
                                  color: ColorPalette.white,
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
                  _singleButton(
                    context,
                    context.localizations.editText,
                    Icons.edit,
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
