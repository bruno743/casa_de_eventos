//import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class Event extends Equatable {
  final String id;
  final String description;
  final String url;

  const Event({required this.id, required this.description, required this.url});

  @override
  List<Object?> get props => [id, description, url];

  static List<Event> events = [
    const Event(
      id: '0',
      description: 'Feijoada',
      url: 'assets/images/feijoada.png',
    ),
    const Event(
      id: '1',
      description: 'Festa de halloween',
      url: 'assets/images/halloween.png',
    ),
    const Event(
      id: '2',
      description: 'Noite do teatro',
      url: 'assets/images/peca.png',
    ),
    const Event(
      id: '3',
      description: 'Show com música ao vivo',
      url: 'assets/images/banda.png',
    ),
  ];
}
