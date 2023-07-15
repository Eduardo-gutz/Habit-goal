import '../../utils/regex.dart';

mixin ValidationMixin {
  String? requiredField(String? value) {
    if (value == null || value == '') return 'Este campo es requerido';
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null) return null;
    if (!emailRegex.hasMatch(value)) return 'Email invalido';
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null) return null;
    if (!passwordRegex.hasMatch(value)) {
      return 'La contraseña debe contener al menos 8 caracteres, una letra mayúscula, una letra minúscula, un numero y un carácter especial';
    }
    return null;
  }

  String? Function(String?) minLength(int length) {
    return (value) {
      if (value == null) return null;
      if (value.length < length) {
        return 'Este campo debe contener por lo menos $length caracteres';
      }
      return null;
    };
  }

  String? Function(String?) maxLength(int length) {
    return (value) {
      if (value == null) return null;
      if (value.length > length) {
        return 'Este campo no puede contener mas de $length caracteres';
      }
      return null;
    };
  }

  String? Function(String?) confirmPassword(String pass) {
    return (value) {
      if (value == null) return null;
      if (value != pass) {
        return 'Las contraseñas no coinciden';
      }
      return null;
    };
  }
}
