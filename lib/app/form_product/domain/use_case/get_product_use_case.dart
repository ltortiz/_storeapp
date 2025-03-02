import 'package:storeapp/app/form_product/domain/repository/form_product_repository.dart';
import 'package:storeapp/app/form_product/presentation/model/product_form_model.dart';

class GetProductUseCase {
  late final FormProductRepository formProductRepository;

  GetProductUseCase({required this.formProductRepository});

  Future<ProductFormModel> invoke(String id) async {
    try {
      return (await formProductRepository.getProduct(id)).toProductFormModel();
    } catch (e) {
      throw (Exception());
    }
  }
}
