import 'package:casa_de_eventos/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('home', () {
    testWidgets('render homepage title', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Home(),
        ),
      );

      final homepageTitleKey = find.byKey(const Key('homepage_title'));

      expect(homepageTitleKey, findsOneWidget);
    });

    testWidgets('render external widget', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Home(),
        ),
      );

      final externalWidgetKey = find.byKey(const Key('external_widget'));

      expect(externalWidgetKey, findsOneWidget);
    });

    testWidgets('render cart icon', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Home(),
        ),
      );

      final cartIconKey = find.byKey(const Key('cart_icon'));

      expect(cartIconKey, findsOneWidget);
    });
  });
}
