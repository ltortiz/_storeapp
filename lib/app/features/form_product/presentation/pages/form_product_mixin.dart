import 'package:http/http.dart' as http;

mixin FormProductMixin {
  String? validateName(value) {
    value ??= "";
    value = value.trim();
    if (value.isEmpty) {
      return "El nombre es obligatorio";
    }
    return null;
  }

  String? validatePrice(value) {
    value ??= "";
    value = value.trim();
    if (value.isEmpty) {
      return "El precio es obligatorio";
    }
    final bool isValid = double.tryParse(value) != null;
    if (!isValid) {
      return "El precio es incorrecto";
    }
    return null;
  }

  String? validateImage(value) {
    value ??= "";
    value = value.trim();
    if (value.isEmpty) {
      return "La imagen es obligatoria";
    }
    final bool isValid = RegExp(
      r'\.(jpeg|jpg|png|gif|bmp|webp|svg)$',
      caseSensitive: false,
    ).hasMatch(value);
    if (!isValid) {
      // return "La imagen es incorrecta";
    }
    return null;
  }

  Future<bool> isImageUrl(String url) async {
    try {
      final response = await http.head(Uri.parse(url));
      if (response.statusCode == 200) {
        String? contentType = response.headers['content-type'];
        return contentType != null && contentType.startsWith('image/');
      }
    } catch (e) {}
    return false;
  }
}
