import 'package:flutter/material.dart';
import 'package:tinder/di/service_locator.dart';
import 'package:tinder/presentation/app/tinder_app.dart';

void main() {
  ServiceLocator.init();
  runApp(const TinderApp());
}
