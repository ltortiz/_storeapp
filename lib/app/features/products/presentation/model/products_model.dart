import 'package:storeapp/app/features/products/presentation/model/product_model.dart';

class ProductsModel {
  final List<ProductModel> products;

  ProductsModel({required this.products});

  ProductsModel copyWith({List<ProductModel>? products}) {
    return ProductsModel(products: products ?? this.products);
  }
}
