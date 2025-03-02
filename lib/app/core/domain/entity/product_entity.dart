import 'package:storeapp/app/core/data/remote/dto/product_data_model.dart';
import 'package:storeapp/app/form_product/presentation/model/product_form_model.dart';
import 'package:storeapp/app/features/products/presentation/model/product_model.dart';

class ProductEntity {
  final String id;
  final String name;
  final String image;
  final int price;

  ProductEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
  });

  ProductModel toProductModel() =>
      ProductModel(id: id, name: name, urlImage: image, price: price);

  ProductDataModel toProductDataModel() =>
      ProductDataModel(id: id, name: name, price: price, imageUrl: image);

  ProductFormModel toProductFormModel() => ProductFormModel(
    id: id,
    name: name,
    price: price.toString(),
    urlImage: image,
  );
}
