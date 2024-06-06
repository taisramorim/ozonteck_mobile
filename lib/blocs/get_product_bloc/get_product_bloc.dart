import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:product_repository/product_repository.dart';

part 'get_product_event.dart';
part 'get_product_state.dart';

class GetProductBloc extends Bloc<GetProductEvent, GetProductState> {
  final ProductRepository _productRepository;

  GetProductBloc(this._productRepository) : super(GetProductInitial()) {
    on<GetProduct>((event, emit) async {
      emit(GetProductLoading());
      try {
        List<Product> products = await _productRepository.getProducts();
        emit(GetProductSuccess(products));
      } catch (e) {
        emit(GetProductFailure());
      }
    });
  }
}
