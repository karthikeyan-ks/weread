class User {
  final String refresh;
  final String access;

  User(this.access, this.refresh);

  User.fromJson(Map<String, dynamic> json)
      : refresh = json['refresh'] as String,
        access = json['access'] as String;

  Map<String, dynamic> toJson() => {'refresh': refresh, 'access': access};
}
