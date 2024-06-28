part of 'get_product_bloc.dart';

abstract class GetProductEvent extends Equatable {
  const GetProductEvent();

  @override
  List<Object> get props => [];
}

class LoadProduct extends GetProductEvent {}

class UpdateProductStock extends GetProductEvent {
  final String productId;
  final int stock;

  const UpdateProductStock({required this.productId, required this.stock});

  @override
  List<Object> get props => [productId, stock];
}
