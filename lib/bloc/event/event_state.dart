part of 'event_bloc.dart';

class EventState extends Equatable {
  const EventState();

  @override
  List<Object> get props => [];
}

final class EventInitial extends EventState {}

final class EventLoaded extends EventState {
  final List<Event> events;

  const EventLoaded({required this.events});

  @override
  List<Object> get props => [events];
}
