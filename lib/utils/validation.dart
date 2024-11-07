class Validations {
  static String? validateName(String? value) {
    if (value!.isEmpty || value.length < 3 || value.length > 10)
      return '사용자명을 3자이상 10자 이내로 입력하세요.';
  }
  static String? validateAuth(String? value) {
    if (value!.isEmpty || value.length < 3 || value.length > 5)
      return '인증번호 4자를 입력하세요.';
  }

  static String? validatePhone(String? value) {
    if (value!.isEmpty || value.length < 11 || value.length > 13)
      return '휴대폰번호를 정확히 입력하세요.';
  }

  static String? validateEmail(String? value, [bool isRequried = true]) {
    if (value!.isEmpty && isRequried) return '이메일 주소를 입력해 주세요.';
    final RegExp nameExp = new RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    if (!nameExp.hasMatch(value) && isRequried)
      return '유효한 이메일 주소를 입력해 주세요.';
  }
  static String? validatePassword(String? value) {
    if (value!.isEmpty || value.length < 4 || value.length > 10)
      return '비밀번호를 4자이상 10자 이내로 입력하세요.';
  }
}
