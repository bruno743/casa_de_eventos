part of 'cart_bloc.dart';

class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartInitial extends CartState {}

final class CartLoaded extends CartState {
  final List<Cart> items;

  const CartLoaded({required this.items});

  @override
  List<Object> get props => [items];
}
