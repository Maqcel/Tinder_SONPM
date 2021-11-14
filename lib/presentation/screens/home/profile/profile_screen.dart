import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:tinder/config/theme/color_palette.dart';
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
          leading: Assets.images.icons.tinderWhite
              .svg(color: ColorPalette.colorPrimary100),
        ),
        body: getBody(context),
        backgroundColor: ColorPalette.gray.withOpacity(0.2),
      );

  Widget getBody(BuildContext context) {
    var size = MediaQuery.of(context).size;
    String settingText = context.localizations.settingsText;
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
          padding: const EdgeInsets.only(left: 30, right: 30, bottom: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 140,
                height: 140,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/david-dobrik-attends-build-brunch-to-discuss-his-recent-and-news-photo-1616503401.?crop=1xw:0.66667xh;center,top&resize=640:*"),
                      fit: BoxFit.cover),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'David, 22',
                style: TextStyle(
                  fontSize: 25,
                  color: ColorPalette.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
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
                        child: const Icon(
                          Icons.settings,
                          size: 35,
                          color: ColorPalette.gray,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        context.localizations.settingsText,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: ColorPalette.gray,
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 85,
                          height: 85,
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
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          context.localizations.addMediaText,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: ColorPalette.gray),
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
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
                        child: const Icon(
                          Icons.edit,
                          size: 35,
                          color: ColorPalette.gray,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        context.localizations.editText,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: ColorPalette.gray,
                        ),
                      )
                    ],
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
