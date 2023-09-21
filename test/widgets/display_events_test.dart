import 'package:bloc_test/bloc_test.dart';
import 'package:casa_de_eventos/bloc/cart/cart_bloc.dart';
import 'package:casa_de_eventos/bloc/event/event_bloc.dart';
import 'package:casa_de_eventos/widgets/display_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

class MockCartBloc extends MockBloc<CartEvent, CartState> implements CartBloc {}

class MockEventBloc extends MockBloc<EventEvent, EventState>
    implements EventBloc {}

void main() {
  group('events screen', () {
    testWidgets('render the button to add to cart', (tester) async {
      final eventBloc = EventBloc();
      final cartBloc = CartBloc();

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<EventBloc>(
              create: (context) => eventBloc..add(LoadEvents()),
            ),
            BlocProvider<CartBloc>(
              create: (context) => cartBloc..add(LoadItems()),
            ),
          ],
          child: const MaterialApp(
            home: Scaffold(body: DisplayEvents()),
          ),
        ),
      );

      await tester.pumpAndSettle();

      final cartAdd = find.text('Adicionar ao\ncarrinho');

      expect(cartAdd, findsWidgets);
    });

    testWidgets('render icon add item', (tester) async {
      final eventBloc = EventBloc();
      final cartBloc = CartBloc();

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<EventBloc>(
              create: (context) => eventBloc..add(LoadEvents()),
            ),
            BlocProvider<CartBloc>(
              create: (context) => cartBloc..add(LoadItems()),
            ),
          ],
          child: const MaterialApp(
            home: Scaffold(body: DisplayEvents()),
          ),
        ),
      );

      await tester.pumpAndSettle();

      final addItem = find.byKey(const Key('add_item_1'));

      expect(addItem, findsOneWidget);
    });

    testWidgets('render text field item', (tester) async {
      final eventBloc = EventBloc();
      final cartBloc = CartBloc();

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<EventBloc>(
              create: (context) => eventBloc..add(LoadEvents()),
            ),
            BlocProvider<CartBloc>(
              create: (context) => cartBloc..add(LoadItems()),
            ),
          ],
          child: const MaterialApp(
            home: Scaffold(body: DisplayEvents()),
          ),
        ),
      );

      await tester.pumpAndSettle();

      final inputItem = find.byKey(const Key('input_item_1'));

      expect(inputItem, findsOneWidget);
    });

    testWidgets('text field initial value', (tester) async {
      final eventBloc = EventBloc();
      final cartBloc = CartBloc();

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<EventBloc>(
              create: (context) => eventBloc..add(LoadEvents()),
            ),
            BlocProvider<CartBloc>(
              create: (context) => cartBloc..add(LoadItems()),
            ),
          ],
          child: const MaterialApp(
            home: Scaffold(body: DisplayEvents()),
          ),
        ),
      );

      await tester.pumpAndSettle();

      final textFieldValue = find.text('1');

      expect(textFieldValue, findsWidgets);
    });

    testWidgets('render arrows icons', (tester) async {
      final eventBloc = EventBloc();
      final cartBloc = CartBloc();

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<EventBloc>(
              create: (context) => eventBloc..add(LoadEvents()),
            ),
            BlocProvider<CartBloc>(
              create: (context) => cartBloc..add(LoadItems()),
            ),
          ],
          child: const MaterialApp(
            home: Scaffold(body: DisplayEvents()),
          ),
        ),
      );

      await tester.pumpAndSettle();

      final arrowB = find.byKey(const Key('carousel_arrowback'));
      final arrowF = find.byKey(const Key('carousel_arrowforward'));

      expect(arrowB, findsOneWidget);
      expect(arrowF, findsOneWidget);
    });
  });

  group('actions', () {
    testWidgets('prev item in carousel', (tester) async {
      final eventBloc = EventBloc();
      final cartBloc = CartBloc();

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<EventBloc>(
              create: (context) => eventBloc..add(LoadEvents()),
            ),
            BlocProvider<CartBloc>(
              create: (context) => cartBloc..add(LoadItems()),
            ),
          ],
          child: const MaterialApp(
            home: Scaffold(body: DisplayEvents()),
          ),
        ),
      );

      await tester.pump(const Duration(seconds: 3));
      final arrowB = find.byKey(const Key('carousel_arrowback'));
      await tester.tap(arrowB);
      await tester.pumpAndSettle();

      expect(find.text('Show com música ao vivo'), findsOneWidget);
      expect(find.text('Standup, com alguém aí'), findsOneWidget);
      expect(find.text('Grande evento'), findsOneWidget);
    });

    testWidgets('next item in carousel', (tester) async {
      final eventBloc = EventBloc();
      final cartBloc = CartBloc();

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<EventBloc>(
              create: (context) => eventBloc..add(LoadEvents()),
            ),
            BlocProvider<CartBloc>(
              create: (context) => cartBloc..add(LoadItems()),
            ),
          ],
          child: const MaterialApp(
            home: Scaffold(body: DisplayEvents()),
          ),
        ),
      );

      await tester.pump(const Duration(seconds: 3));
      final arrowF = find.byKey(const Key('carousel_arrowforward'));
      await tester.tap(arrowF);
      await tester.pumpAndSettle();

      expect(find.text('Grande evento'), findsOneWidget);
      expect(find.text('Uma peça legal'), findsOneWidget);
      expect(find.text('Festa dançante'), findsOneWidget);
    });

    testWidgets('check the inserted value on text field', (tester) async {
      final eventBloc = EventBloc();
      final cartBloc = CartBloc();

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<EventBloc>(
              create: (context) => eventBloc..add(LoadEvents()),
            ),
            BlocProvider<CartBloc>(
              create: (context) => cartBloc..add(LoadItems()),
            ),
          ],
          child: const MaterialApp(
            home: Scaffold(body: DisplayEvents()),
          ),
        ),
      );

      await tester.pumpAndSettle();
      final inputItem = find.byKey(const Key('input_item_0'));
      await tester.enterText(inputItem, '2');

      final textFieldValue = find.text('2');

      expect(textFieldValue, findsWidgets);
    });

    testWidgets('check itens count on text field', (tester) async {
      final eventBloc = EventBloc();
      final cartBloc = CartBloc();

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<EventBloc>(
              create: (context) => eventBloc..add(LoadEvents()),
            ),
            BlocProvider<CartBloc>(
              create: (context) => cartBloc..add(LoadItems()),
            ),
          ],
          child: const MaterialApp(
            home: Scaffold(body: DisplayEvents()),
          ),
        ),
      );

      await tester.pumpAndSettle();
      final addItem = find.byKey(const Key('add_item_0'));

      int nTouches = 4;
      for (int i = 0; i < nTouches; i++) {
        await tester.tap(addItem);
      }

      final textFieldValue = find.text((nTouches + 1).toString());

      expect(textFieldValue, findsWidgets);
    });

    testWidgets('check max itens count, when too much touches on add icon',
        (tester) async {
      final eventBloc = EventBloc();
      final cartBloc = CartBloc();

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<EventBloc>(
              create: (context) => eventBloc..add(LoadEvents()),
            ),
            BlocProvider<CartBloc>(
              create: (context) => cartBloc..add(LoadItems()),
            ),
          ],
          child: const MaterialApp(
            home: Scaffold(body: DisplayEvents()),
          ),
        ),
      );

      await tester.pumpAndSettle();
      final addItem = find.byKey(const Key('add_item_0'));

      int nTouches = 112;
      for (int i = 0; i < nTouches; i++) {
        await tester.tap(addItem);
      }

      final textFieldTouches = find.text((nTouches + 1).toString());
      final maxTextFieldValue = find.text('99');

      expect(textFieldTouches, findsNothing);
      expect(maxTextFieldValue, findsWidgets);
    });
  });
}
