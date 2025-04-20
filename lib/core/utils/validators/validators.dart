abstract class Validators {
  Validators._();

  static String? phoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'لطفا شماه موبایل را وارد کنید';
    }

    final trimmedValue = value.trim();
    final phoneRegex = RegExp(r'^09[0-9]{9}$');

    if (!phoneRegex.hasMatch(trimmedValue)) {
      return 'لطفا یک شماره موبایل معتبر وارد کنید';
    }

    return null;
  }

  static String? fullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'لطفا نام و نام خانوادگی خود را وارد کنید';
    }
    return null;
  }

  static String? notEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'این فیلد الزامی است';
    }
    return null;
  }
}
