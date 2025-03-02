import 'package:storeapp/app/features/products/domain/repository/products_repository.dart';
import 'package:storeapp/app/features/products/presentation/model/product_model.dart';

class GetProductsUseCase {
  late final ProductsRepository productsRepository;

  GetProductsUseCase({required this.productsRepository});

  Future<List<ProductModel>> invoke() async {
    try {
      return (await productsRepository.getProducts())
          .map((item) => item.toProductModel())
          .toList();
    } catch (e) {
      throw (Exception(e));
    }
  }
}
