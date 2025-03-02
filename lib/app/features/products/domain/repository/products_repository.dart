import 'package:storeapp/app/core/domain/entity/product_entity.dart';

abstract class ProductsRepository {
  Future<List<ProductEntity>> getProducts();
  Future<bool> deleteProduct(String id);
}
