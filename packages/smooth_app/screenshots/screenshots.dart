import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_app/main.dart' as app;
import 'package:smooth_app/pages/user_preferences_page.dart';

import '../test/utils/mocks.dart';

Size size = const Size(500, 500);

void main() {
  final IntegrationTestWidgetsFlutterBinding binding =
      IntegrationTestWidgetsFlutterBinding.ensureInitialized()
          as IntegrationTestWidgetsFlutterBinding;

  testWidgets('just a single screenshot', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues(
      const <String, Object>{
        'IMPORTANCE_AS_STRINGnutriscore': 'important',
        'IMPORTANCE_AS_STRINGnova': 'important',
        'IMPORTANCE_AS_STRINGecoscore': 'important',
      },
    );

    await tester.runAsync(() async {
      binding.setSurfaceSize(size);

      await MockSmoothApp();
      await tester.pumpAndSettle();

      sleep(const Duration(seconds: 30));
      binding.takeScreenshot('first');

      binding.setSurfaceSize(const Size(1000, 1000));
      await tester.pumpAndSettle();
      sleep(const Duration(seconds: 30));
      binding.takeScreenshot('second');

/*
      sleep(const Duration(seconds: 10));

      await tester.tap(find.byKey(const Key('next')));
      await tester.pumpAndSettle();
*/
    });
  });
}
