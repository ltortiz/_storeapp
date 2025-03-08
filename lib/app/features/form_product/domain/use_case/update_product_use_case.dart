import 'package:storeapp/app/core/domain/entity/product_entity.dart';
import 'package:storeapp/app/features/form_product/domain/repository/form_product_repository.dart';
import 'package:storeapp/app/features/form_product/presentation/model/product_form_model.dart';

class UpdateProductUseCase {
  late final FormProductRepository formProductRepository;

  UpdateProductUseCase({required this.formProductRepository});

  Future<bool> invoke(ProductFormModel productModel) {
    try {
      final ProductEntity data = productModel.toEntity();
      return formProductRepository.updateProduct(data);
    } catch (e) {
      throw (Exception());
    }
  }
}
