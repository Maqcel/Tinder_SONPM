import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SavedStateNetworkImage extends StatelessWidget {
  final Key? _imageKey;
  final String _url;
  final BoxFit _fit;
  final PlaceholderWidgetBuilder? _placeholder;

  const SavedStateNetworkImage({
    Key? widgetKey,
    Key? imageKey,
    required String url,
    required BoxFit fit,
    PlaceholderWidgetBuilder? placeholder,
  })  : _imageKey = imageKey,
        _url = url,
        _fit = fit,
        _placeholder = placeholder,
        super(key: widgetKey);

  @override
  Widget build(BuildContext context) => CachedNetworkImage(
        key: _imageKey,
        imageUrl: _url,
        useOldImageOnUrlChange: true,
        placeholderFadeInDuration: Duration.zero,
        fadeOutDuration: Duration.zero,
        fadeInDuration: _fadeInDuration(context),
        fit: _fit,
        placeholder: _placeholder,
      );

  Duration _fadeInDuration(BuildContext context) =>
      _placeholder != null ? Duration.zero : const Duration(milliseconds: 500);
}
