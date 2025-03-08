import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/app/features/products/domain/use_case/delete_product_use_case.dart';
import 'package:storeapp/app/features/products/domain/use_case/get_products_use_case.dart';
import 'package:storeapp/app/features/products/presentation/bloc/products_event.dart';
import 'package:storeapp/app/features/products/presentation/bloc/products_state.dart';
import 'package:storeapp/app/features/products/presentation/model/product_model.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final GetProductsUseCase findProductsUseCase;
  final DeleteProductUseCase deleteProductUseCase;

  ProductsBloc({
    required this.findProductsUseCase,
    required this.deleteProductUseCase,
  }) : super(LoadingState()) {
    on<GetProductsEvent>(_getProductsEvent);
    on<DeleteProductEvent>(_deleteProductEvent);
  }

  Future<void> _getProductsEvent(
    GetProductsEvent event,
    Emitter<ProductsState> emit,
  ) async {
    late ProductsState newState;

    try {
      newState = LoadingState();
      emit(newState);

      final List<ProductModel> result = await findProductsUseCase.invoke();

      if (result.isEmpty) {
        newState = EmptyState();
      } else {
        newState = LoadDataState(model: state.model.copyWith(products: result));
      }
    } catch (e) {
      newState = ProductsErrorState(
        model: state.model,
        message: "Error cargando productos",
      );
    }
    emit(newState);
  }

  Future<void> _deleteProductEvent(
    DeleteProductEvent event,
    Emitter<ProductsState> emit,
  ) async {
    late ProductsState newState;
    try {
      newState = LoadingState();
      emit(newState);

      final bool result = await deleteProductUseCase.invoke(event.id);
      if (result) {
        newState = LoadingState();
        emit(newState);

        final List<ProductModel> result = await findProductsUseCase.invoke();

        if (result.isEmpty) {
          newState = EmptyState();
        } else {
          newState = LoadDataState(
            model: state.model.copyWith(products: result),
          );
        }
      } else {
        throw (Exception());
      }
    } catch (e) {
      newState = ProductsErrorState(
        model: state.model,
        message: "Error eliminando producto",
      );
    }
    emit(newState);
  }
}
