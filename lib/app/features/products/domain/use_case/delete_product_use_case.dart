import 'package:storeapp/app/features/products/domain/repository/products_repository.dart';

class DeleteProductUseCase {
  late final ProductsRepository productsRepository;

  DeleteProductUseCase({required this.productsRepository});

  Future<bool> invoke(String id) {
    return productsRepository.deleteProduct(id);
  }
}
