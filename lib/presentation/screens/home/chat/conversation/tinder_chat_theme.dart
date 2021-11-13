import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:tinder/config/dimensions/icon_dimension.dart';
import 'package:tinder/config/dimensions/padding_dimension.dart';
import 'package:tinder/config/theme/color_palette.dart';
import 'package:tinder/extensions/build_context_extension.dart';

class TinderChatTheme extends DefaultChatTheme {
  TinderChatTheme(BuildContext context)
      : super(
          backgroundColor: context.theme.colorScheme.background,
          primaryColor: context.theme.colorScheme.background,
          secondaryColor: context.theme.colorScheme.background,
          messageBorderRadius: 24,
          dateDividerTextStyle: context.theme.textTheme.bodyText2!.copyWith(
            color: ColorPalette.grayMid,
          ),
          dateDividerMargin: const EdgeInsets.all(PaddingDimension.medium),
          seenIcon: const SizedBox(width: PaddingDimension.small),
          sendingIcon: const SizedBox(width: PaddingDimension.small),
          deliveredIcon: const SizedBox(width: PaddingDimension.small),
          errorIcon: const Icon(
            Icons.error_outline,
            size: IconDimension.small,
            color: ColorPalette.black,
          ),
          statusIconPadding:
              const EdgeInsets.symmetric(horizontal: PaddingDimension.small),
        );
}
