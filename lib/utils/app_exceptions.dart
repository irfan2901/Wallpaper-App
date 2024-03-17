class AppExceptions implements Exception {
  String title;
  String msg;
  AppExceptions({required this.title, required this.msg});

  String toErrorMsg() {
    return "$title: $msg";
  }
}

class FetchDataException extends AppExceptions {
  FetchDataException({required String errormMsg})
      : super(title: "Network error", msg: errormMsg);
}

class BadRequestException extends AppExceptions {
  BadRequestException({required String errorMsg})
      : super(title: "Inavlid request", msg: errorMsg);
}

class UnauthorizedException extends AppExceptions {
  UnauthorizedException({required String errorMsg})
      : super(title: "Unauthorized error", msg: errorMsg);
}

class InvalidInputException extends AppExceptions {
  InvalidInputException({required String errorMsg})
      : super(title: "Invalid input", msg: errorMsg);
}
