mixin SignupMixin {
  String? password;

  String? validateName(value) {
    value ??= "";
    value = value.trim();
    if (value.isEmpty) {
      return "El nombre es obligatorio";
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

  String? validatePassword(value) {
    value ??= "";
    value = value.trim();
    if (value.isEmpty) {
      return "La contraseña es obligatoria";
    }
    if (value.length < 8) {
      return "La contraseña debe tener 8 o más caracteres";
    }
    password = value;
    return null;
  }

  String? validateConfirmPassword(value) {
    value ??= "";
    value = value.trim();
    if (value.isEmpty) {
      return "La confirmación de contraseña es obligatoria";
    }
    if (value.length < 8) {
      return "La confirmación contraseña debe tener 8 o más caracteres";
    }
    if (value != password) {
      return "Las contraseñas no coinciden";
    }
    return null;
  }

  String? validatePhoto(value) {
    value ??= "";
    value = value.trim();
    if (value.isEmpty) {
      return "La foto es obligatoria";
    }
    return null;
  }
}
