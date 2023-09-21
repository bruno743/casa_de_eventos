import 'package:bloc/bloc.dart';
import 'package:casa_de_eventos/models/cart_model.dart';
import 'package:equatable/equatable.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<LoadItems>((event, emit) async {
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(const CartLoaded(items: <Cart>[]));
    });
    on<AddItem>((event, emit) {
      if (state is CartLoaded) {
        final state = this.state as CartLoaded;
        emit(CartLoaded(items: List.from(state.items)..add(event.item)));
      }
    });
    on<RemoveItem>((event, emit) {
      if (state is CartLoaded) {
        final state = this.state as CartLoaded;
        emit(CartLoaded(items: List.from(state.items)..remove(event.item)));
      }
    });
  }
}
