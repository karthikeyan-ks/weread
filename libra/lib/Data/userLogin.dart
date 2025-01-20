class User {
  final String refresh;
  final String access;

  User(this.access, this.refresh);

  User.fromJson(Map<String, dynamic> json)
      : refresh = json['refresh'] as String,
        access = json['access'] as String;

  Map<String, dynamic> toJson() => {'refresh': refresh, 'access': access};
}

class SignUp {
  final String message;
  final String access;
  SignUp(this.message, this.access);
  SignUp.fromJson(Map<String, dynamic> json)
      : message = json['message'] as String,
        access = json['access_token'] as String;
  Map<String, dynamic> toJson() => {'message': message, 'access': access};
}

class AuthResponse {
  final String message;
  final String detail;

  AuthResponse(this.message, this.detail);

  // Factory constructor to create an instance from a JSON response
  AuthResponse.fromJson(Map<String, dynamic> json)
      : message = json['message'] != null ? json['message'] as String : '',
        detail = json['detail'] != null ? json['detail'] as String : '';

  bool get isSuccess => message != '';
  bool get isFailure => detail != '';
}
