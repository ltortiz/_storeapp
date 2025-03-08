import 'package:storeapp/app/core/data/remote/service/product_service.dart';
import 'package:storeapp/app/core/domain/entity/product_entity.dart';
import 'package:storeapp/app/features/products/domain/repository/products_repository.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductService productService;

  ProductsRepositoryImpl({required this.productService});

  @override
  Future<bool> deleteProduct(String id) {
    try {
      return productService.delete(id);
    } catch (e) {
      throw (Exception(e));
    }
  }

  @override
  Future<List<ProductEntity>> getProducts() async {
    try {
      return (await productService.getAll())
          .map((item) => item.toProductEntity())
          .toList();
    } catch (e) {
      throw (Exception(e));
    }
  }
}
