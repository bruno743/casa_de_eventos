import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cart/cart_bloc.dart';
import '../models/cart_model.dart';
import '../models/event_model.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartState();
}

class _CartState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartInitial) {
              return const CircularProgressIndicator(color: Colors.blue);
            }
            if (state is CartLoaded) {
              // os itens no carrinho sao ordenados por ordem alfabetica da descricao
              if (state.items.length > 1) {
                state.items.sort(
                  (a, b) => a.item.description.compareTo(b.item.description),
                );
              }
              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 150, 10, 150),
                    alignment: Alignment.center,
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.fromLTRB(0, 75, 0, 75),
                      color: Colors.blueGrey,
                      width: 400,
                      child: state.items.isEmpty
                          ? Container(
                              color: Colors.grey,
                              width: 375,
                              padding: const EdgeInsets.all(20),
                              child: const Center(
                                child: Text('Nenhum evento no carrinho'),
                              ),
                            )
                          : Column(
                              children: state.items.map((i) {
                                // funcao para remover um item do carrinho
                                removeItem() {
                                  context.read<CartBloc>().add(RemoveItem(i));
                                }

                                int quantItem = i.quant;

                                // funcao que aumenta a quantidade de um item no carrinho
                                void incrementItem() {
                                  setState(() {
                                    if (quantItem < 99) {
                                      quantItem++;
                                      Event item = i.item;
                                      removeItem();
                                      context.read<CartBloc>().add(
                                            AddItem(
                                              Cart(
                                                item: item,
                                                quant: quantItem,
                                              ),
                                            ),
                                          );
                                    }
                                  });
                                }

                                // funcao que aumenta a quantidade de um item no carrinho
                                void decrementItem() {
                                  setState(() {
                                    if (quantItem > 1) {
                                      quantItem--;
                                      Event item = i.item;
                                      removeItem();
                                      context.read<CartBloc>().add(
                                            AddItem(
                                              Cart(
                                                item: item,
                                                quant: quantItem,
                                              ),
                                            ),
                                          );
                                    }
                                  });
                                }

                                return Container(
                                  color: Colors.grey,
                                  padding: const EdgeInsets.all(16),
                                  width: 375,
                                  margin: const EdgeInsets.fromLTRB(0, 3, 0, 3),
                                  child: Center(
                                    child: Row(
                                      children: [
                                        Column(
                                          children: [
                                            // acao para incremento de quantidade
                                            IconButton(
                                              key: const Key('increment'),
                                              onPressed: () {
                                                incrementItem();
                                              },
                                              icon: const Icon(
                                                Icons.arrow_drop_up_outlined,
                                              ),
                                            ),
                                            // acao para decremento de quantidade
                                            IconButton(
                                              key: const Key('decrement'),
                                              onPressed: () {
                                                decrementItem();
                                              },
                                              icon: const Icon(
                                                Icons.arrow_drop_down_outlined,
                                              ),
                                            ),
                                          ],
                                        ),
                                        // indicador da quantidade
                                        Text('   $quantItem     '),
                                        // descricao do item
                                        Flexible(
                                          child: Center(
                                            child: Text(
                                              'Descrição do Evento: ${i.item.description}    ',
                                              maxLines: 3,
                                            ),
                                          ),
                                        ),
                                        // acao para a remocao do item
                                        IconButton(
                                          key: const Key('remove_item'),
                                          onPressed: () {
                                            removeItem();
                                          },
                                          icon: const Icon(
                                            Icons.delete_forever,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                    ),
                  ),
                  state.items.isNotEmpty
                      ? Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 32),
                          child: ElevatedButton(
                            onPressed: () {},
                            child: const Text('Finalizar compra'),
                          ),
                        )
                      : const Text(''),
                ],
              );
            } else {
              return const Text('Something wrong');
            }
          },
        ),
      ),
    );
  }
}
