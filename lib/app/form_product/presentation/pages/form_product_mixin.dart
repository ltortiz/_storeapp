mixin FormProductMixin {
  String? validatePassword(value) {
    // value = value ?? "";
    value ??= "";
    value = value.trim();
    if (value.isEmpty) {
      return "La contraseña es obligatoria";
    }
    if (value.length < 8) {
      return "La contraseña es incorrecta";
    }
    return null;
  }

  String? validateEmail(value) {
    value ??= "";
    value = value.trim();
    if (value.isEmpty) {
      return "El email es obligatorio";
    }
    final bool isValid = RegExp(
      r"^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$",
    ).hasMatch(value);
    if (!isValid) {
      return "El email es incorrecto";
    }
    return null;
  }
}
