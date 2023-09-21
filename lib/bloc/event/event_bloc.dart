import 'package:bloc/bloc.dart';
import 'package:casa_de_eventos/models/event_model.dart';
import 'package:equatable/equatable.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  EventBloc() : super(EventInitial()) {
    on<LoadEvents>((event, emit) async {
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(const EventLoaded(events: <Event>[]));
    });
    on<GetEvents>((event, emit) {
      if (state is EventLoaded) {
        final state = this.state as EventLoaded;
        emit(
            EventLoaded(events: List.from(state.events)..addAll(event.events)));
      }
    });
  }
}
