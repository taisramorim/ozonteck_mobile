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

class UpdatePersonalStockSuccess extends GetProductState {
  final String productId;
  final int personalStock;

  const UpdatePersonalStockSuccess({required this.productId, required this.personalStock});

  @override
  List<Object> get props => [productId, personalStock];
}

class UpdatePersonalStockFailure extends GetProductState {}
