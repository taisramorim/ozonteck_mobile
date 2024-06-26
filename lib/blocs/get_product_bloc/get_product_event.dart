part of 'get_product_bloc.dart';

abstract class GetProductEvent extends Equatable {
  const GetProductEvent();

  @override
  List<Object> get props => [];
}

class  LoadProduct extends GetProductEvent{}

class UpdatePersonalStock extends GetProductEvent{
  final String productId;
  final int personalStock;

  const UpdatePersonalStock({required this.productId, required this.personalStock});

  @override
  List<Object> get props => [productId, personalStock];
}
