import 'package:flutter/material.dart';
import 'package:casa_de_eventos/widgets/display_events.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // funcao para navegar ate a pagina de carrinho
  void goToCart() {
    Navigator.of(context).pushNamed('cart');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Casa de Eventos'),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // icone de carrinho
              Container(
                alignment: Alignment.topRight,
                margin: const EdgeInsets.all(18.0),
                child: IconButton(
                  key: const Key('cart_icon'),
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () {
                    goToCart();
                  },
                ),
              ),
              // titulo da pagina e widget que exibe os eventos
              Container(
                margin: const EdgeInsets.fromLTRB(100.0, 150.0, 100.0, 60.0),
                child: const Text(
                  'Home',
                  style: TextStyle(fontSize: 24),
                  key: Key('homepage_title'),
                ),
              ),
              const DisplayEvents(),
            ],
          ),
        ),
      ),
    );
  }
}
