import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:product_repository/product_repository.dart';

part 'get_product_event.dart';
part 'get_product_state.dart';

class GetProductBloc extends Bloc<GetProductEvent, GetProductState> {
  final ProductRepository productRepository;

  GetProductBloc({required this.productRepository}) : super(GetProductInitial()) {
    on<LoadProduct>(_onLoadProduct);
    on<UpdateProductStock>(_onUpdatePersonalStock);
  }

  Future<void> _onLoadProduct(LoadProduct event, Emitter<GetProductState> emit) async {
    emit(GetProductLoading());
    try {
      List<Product> products = await productRepository.getProducts();
      emit(GetProductSuccess(products: products));
    } catch (e) {
      emit(GetProductFailure());
    }
  }

  Future<void> _onUpdatePersonalStock(UpdateProductStock event, Emitter<GetProductState> emit) async {
    try {
      await productRepository.updateProductStock(event.productId, event.stock);
      emit(UpdateProductStockSuccess(productId: event.productId, stock: event.stock));
      await _reloadProducts(emit);
    } catch (e) {
      emit(UpdateProductStockFailure());
    }
  }

  Future<void> _reloadProducts(Emitter<GetProductState> emit) async {
    try {
      List<Product> products = await productRepository.getProducts();
      emit(GetProductSuccess(products: products));
    } catch (e) {
      emit(GetProductFailure());
    }
  }
}