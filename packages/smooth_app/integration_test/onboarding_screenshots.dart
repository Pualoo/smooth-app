import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_app/main.dart' as app;

import 'app_test.dart';

Future<void> createOnboardingScreenshots(
    {required IntegrationTestWidgetsFlutterBinding binding}) async {
  group('Onboarding screenshots', () {
    testWidgets('just a single screenshot', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues(
        const <String, Object>{
          'IMPORTANCE_AS_STRINGnutriscore': 'important',
          'IMPORTANCE_AS_STRINGnova': 'important',
          'IMPORTANCE_AS_STRINGecoscore': 'important',
        },
      );

      await tester.runAsync(() async {
        await initScreenshot(binding);

        await app.main(screenshots: true);
        await tester.pumpAndSettle();

        sleep(const Duration(seconds: 30));
        await takeScreenshot(
            tester, binding, 'test-screenshot-onboarding-home');
        sleep(const Duration(seconds: 10));

        await tester.tap(find.byKey(const Key('next')));
        await tester.pumpAndSettle();

        await takeScreenshot(
            tester, binding, 'test-screenshot-onboarding-scan');
        sleep(const Duration(seconds: 10));

        await tester.tap(find.byKey(const Key('next')));
        await tester.pumpAndSettle();

        await takeScreenshot(
            tester, binding, 'test-screenshot-onboarding-health');
        sleep(const Duration(seconds: 10));

        await tester.tap(find.byKey(const Key('next')));
        await tester.pumpAndSettle();

        await takeScreenshot(tester, binding, 'test-screenshot-onboarding-eco');
        sleep(const Duration(seconds: 10));

        await tester.tap(find.byKey(const Key('next')));
        await tester.pumpAndSettle();

        await takeScreenshot(
            tester, binding, 'test-screenshot-onboarding-prefs');
        sleep(const Duration(seconds: 10));
      });
    });
  });
}
