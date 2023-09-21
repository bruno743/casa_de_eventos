import 'package:casa_de_eventos/bloc/cart/cart_bloc.dart';
import 'package:casa_de_eventos/bloc/event/event_bloc.dart';
import 'package:flutter/material.dart';
import 'package:casa_de_eventos/pages/home.dart';
import 'package:casa_de_eventos/pages/cart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyApState();
}

class _MyApState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<EventBloc>(
          create: (context) => EventBloc()..add(LoadEvents()),
        ),
        BlocProvider<CartBloc>(
          create: (context) => CartBloc()..add(LoadItems()),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(brightness: Brightness.light),
        darkTheme: ThemeData(brightness: Brightness.dark),
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const Home(),
          'cart': (context) => const CartPage(),
        },
      ),
    );
  }
}
