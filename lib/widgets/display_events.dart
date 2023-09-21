import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cart/cart_bloc.dart';
import '../bloc/event/event_bloc.dart';
import '../models/cart_model.dart';
import '../models/event_model.dart';

class DisplayEvents extends StatefulWidget {
  const DisplayEvents({super.key});

  @override
  State<DisplayEvents> createState() => _DisplayEventsState();
}

class _DisplayEventsState extends State<DisplayEvents> {
  // controller para o campo de quantidade
  final itemsController = TextEditingController();
  // controller para a navegacao entre eventos
  CarouselController buttonCarouselController = CarouselController();

  // funcao que incrementa os itens antes de adiconar ao carrinho
  void incrementItem() {
    int itemsQuant = int.parse(itemsController.text);
    itemsQuant++;

    if (itemsQuant > 99) return;

    itemsController.value = itemsController.value.copyWith(
      text: itemsQuant.toString(),
      selection: TextSelection.collapsed(offset: itemsQuant.toString().length),
    );
  }

  @override
  // iniciando o controller com o valor 1
  void initState() {
    super.initState();

    itemsController.value = itemsController.value.copyWith(
      text: '1',
      selection: const TextSelection.collapsed(offset: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 75),
      child: SizedBox(
        width: 400,
        height: 400,
        child: Stack(
          children: [
            BlocBuilder<EventBloc, EventState>(
              builder: (eventContext, eventState) {
                if (eventState is EventInitial) {
                  return const CircularProgressIndicator(color: Colors.blue);
                }
                if (eventState is EventLoaded) {
                  if (eventState.events.isEmpty) {
                    eventContext.read<EventBloc>().add(GetEvents(Event.events));
                  }
                  // widget que exibe os eventos
                  return CarouselSlider(
                    key: const Key('external_widget'),
                    carouselController: buttonCarouselController,
                    options: CarouselOptions(
                      height: 300.0,
                      onPageChanged: (index, reason) {
                        itemsController.value = itemsController.value.copyWith(
                          text: '1',
                          selection: const TextSelection.collapsed(offset: 1),
                        );
                      },
                    ),
                    // lista de eventos
                    items: eventState.events.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Stack(alignment: Alignment.center, children: [
                            // visual do evento
                            Container(
                              height: 230,
                              width: 300,
                              decoration: const BoxDecoration(
                                  color: Colors.purpleAccent),
                              child: Image.asset(i.url),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // descricao do evento
                                Text(
                                  i.description,
                                  style: const TextStyle(fontSize: 16.0),
                                ),
                                // acoes para adicao de evento ao carrinho
                                BlocBuilder<CartBloc, CartState>(
                                  builder: (cartContext, cartState) {
                                    addToCart() {
                                      if (itemsController.text.isNotEmpty) {
                                        if (int.tryParse(
                                                itemsController.text) !=
                                            null) {
                                          cartContext.read<CartBloc>().add(
                                                AddItem(
                                                  Cart(
                                                    item: i,
                                                    quant: int.parse(
                                                      itemsController.text,
                                                    ),
                                                  ),
                                                ),
                                              );
                                        }
                                      }
                                    }

                                    if (cartState is CartInitial) {
                                      return const CircularProgressIndicator(
                                          color: Colors.blue);
                                    }
                                    if (cartState is CartLoaded) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          // acao de incrementar item
                                          IconButton(
                                            onPressed: () {
                                              incrementItem();
                                            },
                                            icon: const Icon(Icons.add),
                                            key: Key('add_item_${i.id}'),
                                          ),
                                          // campo de quantidade
                                          SizedBox(
                                            width: 24,
                                            height: 24,
                                            child: TextField(
                                              keyboardType:
                                                  TextInputType.number,
                                              controller: itemsController,
                                              textAlign: TextAlign.center,
                                              key: Key('input_item_${i.id}'),
                                            ),
                                          ),
                                          // acao de adicionar evento ao carrinho
                                          ElevatedButton(
                                            onPressed: () {
                                              addToCart();
                                            },
                                            child: const Text(
                                              'Adicionar ao\ncarrinho',
                                              style: TextStyle(fontSize: 10),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      );
                                    } else {
                                      return const Text('Something wrong');
                                    }
                                  },
                                ),
                              ],
                            ),
                          ]);
                        },
                      );
                    }).toList(),
                  );
                } else {
                  return const Text('Something wrong');
                }
              },
            ),
            // acoes para a navegacao entre eventos
            Container(
              alignment: Alignment.bottomLeft,
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: IconButton(
                onPressed: () async {
                  await buttonCarouselController.previousPage(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.linear);
                },
                icon: const Icon(Icons.arrow_back),
                key: const Key('carousel_arrowback'),
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: IconButton(
                onPressed: () async {
                  await buttonCarouselController.nextPage(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.linear);
                },
                icon: const Icon(Icons.arrow_forward),
                key: const Key('carousel_arrowforward'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
