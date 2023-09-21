part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class LoadItems extends CartEvent {}

class AddItem extends CartEvent {
  final Cart item;

  const AddItem(this.item);

  @override
  List<Object> get props => [item];
}

class RemoveItem extends CartEvent {
  final Cart item;

  const RemoveItem(this.item);

  @override
  List<Object> get props => [item];
}
