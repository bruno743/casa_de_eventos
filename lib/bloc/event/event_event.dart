part of 'event_bloc.dart';

sealed class EventEvent extends Equatable {
  const EventEvent();

  @override
  List<Object> get props => [];
}

class LoadEvents extends EventEvent {}

class GetEvents extends EventEvent {
  final List<Event> events;

  const GetEvents(this.events);

  @override
  List<Object> get props => [events];
}
