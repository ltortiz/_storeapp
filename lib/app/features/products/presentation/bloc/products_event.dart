sealed class ProductsEvent {}

class GetProductsEvent extends ProductsEvent {
  GetProductsEvent();
}

class DeleteProductEvent extends ProductsEvent {
  final String id;
  DeleteProductEvent({required this.id});
}

class LogoutEvent extends ProductsEvent {
  LogoutEvent();
}
