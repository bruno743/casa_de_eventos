import 'package:casa_de_eventos/models/event_model.dart';
//import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class Cart extends Equatable {
  final Event item;
  final int quant;

  const Cart({required this.item, required this.quant});

  @override
  List<Object?> get props => [item, quant];
}
