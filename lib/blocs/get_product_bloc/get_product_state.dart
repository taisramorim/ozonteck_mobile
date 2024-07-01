part of 'get_product_bloc.dart';

abstract class GetProductState extends Equatable {
  const GetProductState();

  @override
  List<Object> get props => [];
}

class GetProductInitial extends GetProductState {}

class GetProductLoading extends GetProductState {}

class GetProductSuccess extends GetProductState {
  final List<Product> products;

  const GetProductSuccess({required this.products});

  @override
  List<Object> get props => [products];
}

class GetProductFailure extends GetProductState {}

class UpdateProductStockSuccess extends GetProductState {
  final String productId;
  final int stock;

  const UpdateProductStockSuccess({required this.productId, required this.stock});

  @override
  List<Object> get props => [productId, stock];
}

class UpdateProductStockFailure extends GetProductState {}
