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

final class HomeErrorState extends ProductsState {
  final String message;
  HomeErrorState({required super.model, required this.message});
}

final class LogoutState extends ProductsState {
  LogoutState() : super(model: ProductsModel(products: []));
}
