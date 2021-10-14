import 'package:flutter/material.dart';
import 'package:tinder/gen/app_localizations.dart';

extension ContextProvider on BuildContext {
  AppLocalizations get localizations => AppLocalizations.of(this)!;
  Router get router => Router.of(this);
  FocusScopeNode get focusScope => FocusScope.of(this);
}
