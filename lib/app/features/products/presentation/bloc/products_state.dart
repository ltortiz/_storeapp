import 'package:storeapp/app/features/products/presentation/model/products_model.dart';

sealed class ProductsState {
  ProductsState({required this.model});

  final ProductsModel model;
}

final class EmptyState extends ProductsState {
  EmptyState() : super(model: ProductsModel(products: []));
}

final class LoadingState extends ProductsState {
  final String message;
  LoadingState({this.message = "Cargando Productos..."})
    : super(model: ProductsModel(products: []));
}

final class LoadDataState extends ProductsState {
  LoadDataState({required super.model});
}

final class ProductsErrorState extends ProductsState {
  final String message;
  ProductsErrorState({required super.model, required this.message});
}
