import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'onboarding_screenshots.dart';

Size size = const Size(500, 500);

Future<void> initScreenshot(
  final IntegrationTestWidgetsFlutterBinding binding,
) async {
  if ((!kIsWeb) && Platform.isAndroid) {
    await binding.convertFlutterSurfaceToImage();
  }
}

Future<void> takeScreenshot(
  final WidgetTester tester,
  final IntegrationTestWidgetsFlutterBinding binding,
  final String screenshotName,
) async {
  await tester.pumpAndSettle();
  await binding
      .takeScreenshot('$platform/$size/$country/$language/$screenshotName');
}

const String language = String.fromEnvironment('LANGUAGE'); // e.g. fr
const String country = String.fromEnvironment('COUNTRY'); // e.g. BE
const String platform = String.fromEnvironment('PLATFORM'); // e.g. ios
const String device = String.fromEnvironment('DEVICE'); // e.g. iPhone8Plus

/*
flutter drive --driver=test_driver/screenshot_driver.dart --target=integration_test/app_test.dart \
 --dart-define=LANGUAGE=fr --dart-define=COUNTRY=FR --dart-define=PLATFORM=ios --dart-define=DEVICE=iPhone8Plus
 */
/// Onboarding screenshots.
void main() async {
  final IntegrationTestWidgetsFlutterBinding binding =
      IntegrationTestWidgetsFlutterBinding.ensureInitialized()
          as IntegrationTestWidgetsFlutterBinding;

  binding.binding.setSurfaceSize(size);
  await createOnboardingScreenshots(binding: binding);
  size = const Size(1000, 1000);
  binding.window.physicalSizeTestValue = size;
  await createOnboardingScreenshots(binding: binding);
}
